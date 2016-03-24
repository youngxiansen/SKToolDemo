//
//  SKBaseModel.h
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import <UIKit/UIKit.h>

@interface SKBaseModel : NSObject

/**
 *  基类-将字典转模型或者数组
 */
+(id)SKValuesToModelWithResponseObject:(NSDictionary*)responseObject;

/**
 *  返回数组模型
 */
+(NSMutableArray*)SKValuesToModelArrayWithResponseObject:(NSDictionary*)responseObject;

@end
