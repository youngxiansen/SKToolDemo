//
//  NSDictionary+SKDic.m
//  dicDemo
//
//  Created by youngxiansen on 15/11/26.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import "NSDictionary+SKDic.h"
#import "NSString+SKString.h"
@implementation NSDictionary (SKDic)

-(void)NSLogDicValueType
{
    
    if ([self isKindOfClass:[NSNull class]]) {
        return;
    }
    if (![self isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    
    NSInteger num =  [[self allKeys] count];
    if (num <= 0) {
        return;
    }
    for (int i = 0; i < num; i++) {
        NSString* key = [self allKeys][i];
        NSLog(@"key***%@---value***%@---%@\n",key,self[key],NSStringFromClass([self[key] class]));
    }

}

/**
 *  将NSCFNum转成字符串类型 将NSNull转成空字符串
 */
+(NSDictionary*)transFromCFNumberToString:(NSDictionary*)dic
{
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return dic;
    }
    NSMutableDictionary* tempDic = [dic mutableCopy];
    NSInteger num =  [[dic allKeys] count];
    if (num <= 0) {
        return [tempDic copy];
    }
    for (int i = 0; i < num; i++) {
        NSString* key = [tempDic allKeys][i];
        
        if ([tempDic[key] isKindOfClass:[NSNumber class]]) {
            
            [tempDic setObject:[NSString stringWithFormat:@"%@",tempDic[key]] forKey:key];
        }
        
        if ([tempDic[key] isKindOfClass:[NSNull class]]||[tempDic[key] isEqual:[NSNull null]]) {
             [tempDic setObject:@"" forKey:key];
        }
//        NSLog(@"key***%@---value***%@---%@\n",key,tempDic[key],NSStringFromClass([tempDic[key] class]));
    }
    return [tempDic copy];
}

+(NSDictionary*)reCombineDic:(NSDictionary*)dic{
    


    if (!dic[@"driver_id"]) {
        
        
        return dic;
    }
    
    if (!dic[@"token"]){
        
        
        return dic;
    }
    else{
        
        NSMutableDictionary* muDic = [dic mutableCopy];
        
        NSMutableString* tokenStr = [NSMutableString string];
        [tokenStr appendString:@"driver_id:"];
        [tokenStr appendString:dic[@"driver_id"]];
        
        NSString* time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]*1000];
        [muDic setObject:time forKey:@"time_stamp"];
        
        [tokenStr appendString:@"time_stamp:"];
        [tokenStr appendString:time];
        
        [tokenStr appendString:@"token:"];
        [tokenStr appendString:dic[@"token"]];
        [muDic setObject:tokenStr forKey:@"token"];
        [muDic setObject:[tokenStr MD5] forKey:@"token"];
        
        
        return [muDic copy];
    }
}


@end
