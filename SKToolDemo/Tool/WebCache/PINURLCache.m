//
//  PINURLCache.m
//  iOS-UIWebView-Cache
//
//  Created by 雷亮 on 16/7/25.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import "PINURLCache.h"
#import "Reachability.h"

@implementation PINURLCache

- (instancetype)initWithMemoryCapacity:(NSUInteger)memoryCapacity
                          diskCapacity:(NSUInteger)diskCapacity
                              diskPath:(NSString *)path
                             cacheTime:(NSInteger)cacheTime {
    self = [super initWithMemoryCapacity:memoryCapacity diskCapacity:diskCapacity diskPath:path];
    if (self) {
        self.cacheTime = cacheTime;
        if (path) {
            self.diskPath = path;
        } else {
            self.diskPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        }
        self.responseDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
    }
    return self;
}

- (NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request {
    if ([request.HTTPMethod compare:@"GET"] != NSOrderedSame) {
        return [super cachedResponseForRequest:request];
    }
    return [self dataFromRequest:request];
}

- (void)removeAllCachedResponses {
    [super removeAllCachedResponses];
    [self deleteCacheFolder];
}

- (void)removeCachedResponseForRequest:(NSURLRequest *)request {
    [super removeCachedResponseForRequest:request];
    
    NSString *url = request.URL.absoluteString;
    NSString *fileName = [self cacheRequestFileName:url];
    NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
    NSString *filePath = [self cacheFilePath:fileName];
    NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
    [fileManager removeItemAtPath:otherInfoPath error:nil];
}

#pragma mark -
#pragma mark - CUSTOM URL CACHE
- (NSString *)cacheFolder {
    return @"URLCACHE";
}

- (void)deleteCacheFolder {
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:path error:nil];
}

- (NSString *)cacheFilePath:(NSString *)file {
    NSString *path = [NSString stringWithFormat:@"%@/%@", self.diskPath, [self cacheFolder]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if ([fileManager fileExistsAtPath:path isDirectory:&isDir] && isDir) {
        
    } else {
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [NSString stringWithFormat:@"%@/%@", path, file];
}

- (NSString *)cacheRequestFileName:(NSString *)requestUrl {
    return [Util md5Hash:requestUrl];
}

- (NSString *)cacheRequestOtherInfoFileName:(NSString *)requestUrl {
    return [Util md5Hash:[NSString stringWithFormat:@"%@-otherInfo", requestUrl]];
}

- (NSCachedURLResponse *)dataFromRequest:(NSURLRequest *)request {
    NSString *url = request.URL.absoluteString;
    NSString *fileName = [self cacheRequestFileName:url];
    NSString *otherInfoFileName = [self cacheRequestOtherInfoFileName:url];
    NSString *filePath = [self cacheFilePath:fileName];
    NSString *otherInfoPath = [self cacheFilePath:otherInfoFileName];
    NSDate *date = [NSDate date];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:filePath]) {
        BOOL expire = false;
        NSDictionary *otherInfo = [NSDictionary dictionaryWithContentsOfFile:otherInfoPath];
        if (self.cacheTime > 0) {
            NSInteger createTime = [[otherInfo objectForKey:@"time"] intValue];
            if (createTime + self.cacheTime < [date timeIntervalSince1970]) {
                expire = true;
            }
        }
        if (expire == false) {
            NSLog(@"data from cache ...");
            
            NSData *data = [NSData dataWithContentsOfFile:filePath];
            NSURLResponse *response = [[NSURLResponse alloc] initWithURL:request.URL
                                                                MIMEType:[otherInfo objectForKey:@"MIMEType"]
                                                   expectedContentLength:data.length
                                                        textEncodingName:[otherInfo objectForKey:@"textEncodingName"]];
            NSCachedURLResponse *cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            return cachedResponse;
        } else {
            NSLog(@"cache expire ... ");
            [fileManager removeItemAtPath:filePath error:nil];
            [fileManager removeItemAtPath:otherInfoPath error:nil];
        }
    }
    if (![Reachability networkAvailable]) {
        return nil;
    }
    __block NSCachedURLResponse *cachedResponse = nil;
    // sendSynchronousRequest 请求也要经过 NSURLCache
    id boolExsite = [self.responseDictionary objectForKey:url];
    if (boolExsite == nil) {
        [self.responseDictionary setValue:[NSNumber numberWithBool:YES] forKey:url];
        
#ifdef __IPHONE_7_0 // iOS7.0及以上
        NSURLSession *URLSession = [NSURLSession sharedSession];
        NSURLSessionDataTask *URLSessionDataTask = [URLSession dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (response && data) {
                [self.responseDictionary removeObjectForKey:url];
                if (error) {
                    NSLog(@"error : %@", error);
                    NSLog(@"not cached: %@", request.URL.absoluteString);
                    cachedResponse = nil;
                }
                NSLog(@"CACHE URL --- %@ ",url);
                // save to cache
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"time",
                                      response.MIMEType, @"MIMEType",
                                      response.textEncodingName, @"textEncodingName", nil];
                [dict writeToFile:otherInfoPath atomically:YES];
                [data writeToFile:filePath atomically:YES];
                cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            }
        }];
        [URLSessionDataTask resume];
#else // iOS7.0以下
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data,NSError *error) {
            if (response && data) {
                [self.responseDictionary removeObjectForKey:url];
                if (error) {
                    NSLog(@"error : %@", error);
                    NSLog(@"not cached: %@", request.URL.absoluteString);
                    cachedResponse = nil;
                }
                NSLog(@"CACHE URL --- %@ ",url);
                // save to cache
                NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f", [date timeIntervalSince1970]], @"time",
                                      response.MIMEType, @"MIMEType",
                                      response.textEncodingName, @"textEncodingName", nil];
                [dict writeToFile:otherInfoPath atomically:YES];
                [data writeToFile:filePath atomically:YES];
                cachedResponse = [[NSCachedURLResponse alloc] initWithResponse:response data:data];
            }
        }];
#endif
        return cachedResponse;
    }
    return nil;
}

@end
