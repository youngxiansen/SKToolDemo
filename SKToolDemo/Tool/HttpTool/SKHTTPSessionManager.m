//
//  SKHTTPSessionManager.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//
#import "NSDictionary+SKDic.h"
#import "SKHTTPSessionManager.h"

@implementation SKHTTPSessionManager

+(void)postWithInterface:(NSString *)interface params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    NSDictionary* dic = [NSDictionary reCombineDic:params];
    
    [manager POST:interface parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
        NSLog(@"\n接口地址:%@\n参数:%@\n出参:%@",interface,dic,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n接口地址:%@\n参数:%@\n失败信息:\n%@",interface,dic,error);
        failed(task,error);
    }];
}


+(void)postProgressWithInterface:(NSString *)interface params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    NSDictionary* dic = [NSDictionary reCombineDic:params];
    
    
    [manager POST:interface parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        app.networkActivityIndicatorVisible = NO;
        success(task,responseObject);
        NSLog(@"\n接口地址:%@\n参数:%@\n出参:%@",interface,dic,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        app.networkActivityIndicatorVisible = NO;
        NSLog(@"\n接口地址:%@\n参数:%@\n失败信息:\n%@",interface,dic,error);
        failed(task,error);
    }];
}
@end
