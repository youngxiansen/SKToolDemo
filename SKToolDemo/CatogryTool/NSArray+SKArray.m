//
//  NSArray+SKArray.m
//  BENBENDaiJia
//
//  Created by youngxiansen on 15/12/7.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import "NSArray+SKArray.h"

@implementation NSArray (SKArray)

-(void)NSLogArrayValueType
{
    if (![[self firstObject]isKindOfClass:[NSDictionary class]]) {
        return;
    }
    NSDictionary* dic = [self firstObject];
    NSInteger num =  [[dic allKeys] count];
    if (num <= 0) {
        return;
    }
    for (int i = 0; i < num; i++) {
        NSString* key = [dic allKeys][i];
        NSLog(@"数组第一个元素key***%@---value***%@---%@\n",key,dic[key],NSStringFromClass([dic[key] class]));
    }
}

@end
