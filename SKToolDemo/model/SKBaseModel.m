//
//  SKBaseModel.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKBaseModel.h"
#import <objc/message.h>
#import "NSDictionary+SKDic.h"

@implementation SKBaseModel

+(id)SKValuesToModelWithResponseObject:(NSDictionary*)responseObject
{
    if (![responseObject[@"data"] isKindOfClass:[NSDictionary class]]) {
        
        NSLog(@"responseObject->data不是一个字典");
        return nil;
    }
    
    //判断返回的值的类型
    [responseObject[@"data"] NSLogDicValueType];
    return [self objectWithKeyValues:responseObject[@"data"]];
}

/**
 *  返回数组模型
 */
+(NSMutableArray*)SKValuesToModelArrayWithResponseObject:(NSDictionary*)responseObject
{
    if (![responseObject isKindOfClass:[NSDictionary class]]) {
        NSLog(@"responseObject不是一个字典");
        return [NSMutableArray array];
    }
    
    if (![responseObject[@"data"]isKindOfClass:[NSArray class]]) {
        NSLog(@"responseObject->data不是一个数组");
        
        return [NSMutableArray array];
    }
    NSMutableArray *dataArray = [NSMutableArray array];
    dataArray = [self objectArrayWithKeyValuesArray:responseObject[@"data"]];
    return dataArray;
    
}


// 返回self的所有对象名称
+ (NSArray *)propertyOfSelf{
    unsigned int count = 0;
    
    // 1. 获得类中的所有成员变量
    Ivar *ivarList = class_copyIvarList(self, &count);
    
    NSMutableArray *properNames =[NSMutableArray array];
    for (int i = 0; i < count; i++) {
        Ivar ivar = ivarList[i];
        
        // 获得成员属性名
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        // 除去下划线，从第一个角标开始截取
        NSString *key = [name substringFromIndex:1];
        [properNames addObject:key];
    }
    free(ivarList);
    
    return [properNames copy];
}

// 归档
- (void)encodeWithCoder:(NSCoder *)enCoder{
    // 取得所有成员变量名
    NSArray *properNames = [[self class] propertyOfSelf];
    
    for (NSString *propertyName in properNames) {
        //        NSLog(@"属性的值:%@",[self valueForKey:propertyName]);
        [enCoder encodeObject:[self valueForKey:propertyName] forKey:propertyName];
    }
}

// 解档
- (id)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        // 取得所有成员变量名
        NSArray *properNames = [[self class] propertyOfSelf];
        
        for (NSString *propertyName in properNames) {
            
            [self setValue:[aDecoder decodeObjectForKey:propertyName] forKey:propertyName];
        }
    }
    return  self;
}


@end
