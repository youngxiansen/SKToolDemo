//
//  SKOtherPoint.h
//  GaodeMapDemo
//
//  Created by youngxiansen on 15/10/14.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
//#import <AMapNaviKit/AMapNaviKit.h>
/**
 *  其他的点
 */
@interface SKOtherPoint : MAPointAnnotation
@property(nonatomic,copy)NSString* address;/**< 详细地址信息 */

//
///*!
// @brief 获取annotation标题
// @return 返回annotation的标题信息
// */
//- (NSString *)title;
//
///*!
// @brief 获取annotation副标题
// @return 返回annotation的副标题信息
// */
//- (NSString *)subtitle;
@end
