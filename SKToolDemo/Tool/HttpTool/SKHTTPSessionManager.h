//
//  SKHTTPSessionManager.h
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
@interface SKHTTPSessionManager : NSObject
typedef void (^SuccessBlock)(NSURLSessionDataTask *operation, id responseObject);
typedef void (^FailedBlock)(NSURLSessionDataTask *operation, NSError *error);

/**
 *  @param interface 完整的网址
 */
+(void)postProgressWithInterface:(NSString *)interface params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed;

/**
 *  @param interface 完整的网址
 */
+(void)postWithInterface:(NSString *)interface params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
