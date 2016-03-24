//
//  LocationModel.h
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/24.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
@interface LocationModel : NSObject

@property (copy, nonatomic) NSString* detailAddress;
@property (assign, nonatomic) CLLocationCoordinate2D coor2D;
@property (copy, nonatomic) NSString* city;
@end
