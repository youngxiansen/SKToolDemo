//
//  SKMyPoint.h
//  GaodeMapDemo
//
//  Created by youngxiansen on 15/10/13.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
//#import <AMapNaviKit/AMapNaviKit.h>
@interface SKMyPoint : MAPointAnnotation

@property(nonatomic,copy)NSString* address;/**< 详细地址信息 */

@end
