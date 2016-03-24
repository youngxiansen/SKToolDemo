//
//  SKGDLocationTool.h
//  AGPSNaviDemo
//
//  Created by youngxiansen on 15/10/14.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SKOtherPoint.h"
#import "LocationModel.h"
typedef enum {
    SKSearchTypeNearby = 1,/**< 附近搜索需要定位 */
    
    SKSearchTypeKeywords,/**< 城市搜索需要定位 */
}SKSearchType;/**< 定义搜索的类型 */


/**
 *  高德地图工具类
 */
@interface SKGDLocationTool : NSObject

+(id)shareSKGDLocationToolManager;
@property (strong, nonatomic) MAMapView* mapView;/**< 要添加在viewappear中 */
@property (strong, nonatomic) SKOtherPoint* otherPoint;/**< 其他的大头针 */
@property (assign, nonatomic) CLLocationCoordinate2D tempCoor2d;/**< 临时我的位置 */
@property (strong, nonatomic) LocationModel* locatoinModel;

/** 仅仅是定位 */
-(void)startGetLocation;

-(void)setCenterCoordinate;

/** 为了显示迅速,首先添加一次 */
-(void)addMapAnnotation;

@property (copy, nonatomic) void(^locationInfo)(LocationModel* locationModel);
@property (copy, nonatomic) void(^failureInfo)(NSString* error);

/**
 *  获取位置回调 经纬度和地址信息
 *
 *  @param locationInfo
 */
-(void)startGetLocationSuccess:(void(^)(LocationModel*locationModel))locationInfo Failure:(void(^)(NSString*errorInfo))failureInfo;

/** 停止定位,清除内存 */
-(void)stopGetLocation;

/**
 *  地理编码转换的经纬度
 */
@property (copy, nonatomic) void(^geoResult)(CLLocationCoordinate2D);

/**
 *  地理编码转换的经纬度
 *  @param address   传入地址字段来编码
 *  @param city      所在的城市
 *  @param geoResult 地理编码转换的经纬度
 */
-(void)transfromAddress:(NSString*)address ToCoorSuccess:(void(^)(CLLocationCoordinate2D))geoResult;


@property (copy, nonatomic) void(^searchResultArray)(NSArray*poisArray);

/**
 *  根据关键字来搜索 如果是附近搜索的话需要先定位
 *
 *  @param keyword     关键字
 *  @param searchType  搜索的类型
 *  @param searchArray 搜索的结果数组 AMapPOI类型
 */
- (void)searchPoiByKeyword:(NSString*)keyword SearchType:(SKSearchType)searchType searchArray:(void(^)(NSArray* amapPoiArray))searchArray;


//#pragma mark --规划路径--
///** 规划路径起始点经纬度 */
//@property (nonatomic) CLLocationCoordinate2D startCoordinate;
///** 规划路径终点经纬度 */
//@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;



@end
