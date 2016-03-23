//
//  SKHttpToolManager.m
//  SKTools
//
//  Created by youngxiansen on 15/9/21.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import "SKHttpToolManager.h"
#import "AFHTTPSessionManager.h"
@implementation SKHttpToolManager

#pragma mark --一下是一些初始化的工作

static SKHttpToolManager* _s;
+(id)shareManager
{
    //给下面这一段代码加锁:线程锁,同一时刻只能有一个线程访问
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        if (!_s)
        {
            _s = [[self alloc]initWithBaseURL:[NSURL URLWithString:kBaseUrl]];
            _s.requestSerializer = [AFHTTPRequestSerializer serializer];
            _s.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
        }
    });
    return _s;
}

//当调用alloc方法的时候,系统会调用这个方法
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_s) {
        _s = [super allocWithZone:zone];
    }
    return _s;
}
/*
 
 */


@end
