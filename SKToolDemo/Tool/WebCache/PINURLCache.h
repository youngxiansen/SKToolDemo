//
//  PINURLCache.h
//  iOS-UIWebView-Cache
//
//  Created by 雷亮 on 16/7/25.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Util.h"

@interface PINURLCache : NSURLCache

@property(nonatomic, assign) NSInteger cacheTime;
@property(nonatomic, strong) NSString *diskPath;
@property(nonatomic, strong) NSMutableDictionary *responseDictionary;

/**
 * @param memoryCapacity: 内存容量
 * @param diskCapacity: 磁盘容量
 * @param path: 磁盘路径
 * @param cacheTime: 缓存时间
 **/
- (instancetype)initWithMemoryCapacity:(NSUInteger)memoryCapacity
                          diskCapacity:(NSUInteger)diskCapacity
                              diskPath:(NSString *)path
                             cacheTime:(NSInteger)cacheTime;

/// 删除所有缓存
- (void)removeAllCachedResponses;

@end
