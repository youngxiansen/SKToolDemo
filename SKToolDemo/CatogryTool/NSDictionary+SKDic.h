//
//  NSDictionary+SKDic.h
//  dicDemo
//
//  Created by youngxiansen on 15/11/26.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SKDic)
-(void)NSLogDicValueType;

/**
 *  将NSCFNum转成字符串类型 将NSNull转成空字符串
 */
+(NSDictionary*)transFromCFNumberToString:(NSDictionary*)dic;

+(NSDictionary*)reCombineDic:(NSDictionary*)dic;
@end
