//
//  SKGDLocationTool.m
//  AGPSNaviDemo
//
//  Created by youngxiansen on 15/10/14.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//
#import "SKToolInterface.h"
#import "SKGDLocationTool.h"
#import "SKMyPoint.h"
//以下路径规划相关
#import "SKLocalStoreTool.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface SKGDLocationTool()<AMapSearchDelegate,MAMapViewDelegate>


@property (strong, nonatomic) AMapReGeocodeSearchRequest* reGeocodeSearch;/**< 地理反编码 */
@property (strong, nonatomic) AMapGeocodeSearchRequest* geoCodeSearch;/**< 地理编码请求 */
@property (strong, nonatomic) AMapSearchAPI* search;

@property (assign, nonatomic) BOOL haveLoaction;


@property (strong, nonatomic) SKMyPoint* myPoint;/**< 地图上我的位置 */

@property (copy, nonatomic) NSString* city;/**< 定位的城市 */

@end
@implementation SKGDLocationTool
static SKGDLocationTool* _gd = nil;
+(id)shareSKGDLocationToolManager
{
    //给下面这一段代码加锁:线程锁,同一时刻只能有一个线程访问
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        if (!_gd)
        {
            _gd = [[SKGDLocationTool alloc]init];
        }
    });
    
    return _gd;
}

//当调用alloc方法的时候,系统会调用这个方法
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_gd) {
        _gd = [super allocWithZone:zone];
    }
    return _gd;
}
#pragma mark --懒加载--

-(MAMapView *)mapView{
    if (_mapView == nil) {
        _mapView = [[MAMapView alloc]init];
        _mapView.delegate = self;
        _mapView.showsScale = NO;
        _mapView.showsCompass = NO;
        _mapView.showTraffic = NO;
        _mapView.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        [_mapView setZoomLevel:15];
        
        _mapView.userTrackingMode = MAUserTrackingModeFollowWithHeading;
        
        
//        //以下两句后台定位需要用到
//        _mapView.pausesLocationUpdatesAutomatically = NO;
//        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
//            _mapView.allowsBackgroundLocationUpdates = YES;//iOS9以上系统必须配置
//        }
    }
    return _mapView;
}

-(LocationModel *)locatoinModel
{
    if (!_locatoinModel) {
        _locatoinModel = [[LocationModel alloc]init];
    }
    return _locatoinModel;
}

-(AMapSearchAPI *)search{
    if (_search == nil) {
        _search = [[AMapSearchAPI alloc]init];
        _search.delegate = self;
    }
    return _search;
}

-(AMapReGeocodeSearchRequest *)reGeocodeSearch
{
    if (_reGeocodeSearch == nil) {
        _reGeocodeSearch = [[AMapReGeocodeSearchRequest alloc]init];
    }
    return _reGeocodeSearch;
}

-(AMapGeocodeSearchRequest *)geoCodeSearch{
    if (_geoCodeSearch == nil) {
        _geoCodeSearch = [[AMapGeocodeSearchRequest alloc]init];
    }
    return _geoCodeSearch;
}
-(SKMyPoint *)myPoint{
    if (_myPoint == nil) {
        _myPoint = [[SKMyPoint alloc]init];
    }
    return _myPoint;
}

-(SKOtherPoint *)otherPoint{
    if (_otherPoint == nil) {
        _otherPoint = [[SKOtherPoint alloc]init];
    }
    return _otherPoint;
}


#pragma mark --外部调用--

-(void)startGetLocation
{
    _haveLoaction = NO;
    self.mapView.showsUserLocation = NO;
    self.mapView.showsUserLocation = YES;
    [self setCenterCoordinate];
}


-(void)setCenterCoordinate{
    if (!_tempCoor2d.latitude||!_tempCoor2d.longitude) {
    }
    else{
        [self.mapView setCenterCoordinate:_tempCoor2d animated:YES];
    }

}

/** 为了显示迅速,首先添加一次 */
-(void)addMapAnnotation
{
    if (self.otherPoint.coordinate.latitude&&self.otherPoint.coordinate.longitude) {
        [self.mapView removeAnnotation:self.otherPoint];
        [self.mapView addAnnotation:self.otherPoint];
    }
    else{
        MJLog(@"顾客大头针有0点");
    }
    
    if (self.myPoint.coordinate.latitude&&self.myPoint.coordinate.longitude) {
        [self.mapView removeAnnotation:self.myPoint];
        [self.mapView addAnnotation:self.myPoint];
    }
    else{
        MJLog(@"我的位置大头针有0点");
    }

}

-(void)startGetLocationSuccess:(void(^)(LocationModel*locationModel))locationInfo Failure:(void(^)(NSString*errorInfo))failureInfo
{

    _locationInfo = locationInfo;
    _failureInfo = failureInfo;
    _haveLoaction = NO;
    self.mapView.showsUserLocation = NO;
    self.mapView.showsUserLocation = YES;
    if (!_tempCoor2d.latitude) {
    }
    else{
        [self.mapView setCenterCoordinate:_tempCoor2d animated:YES];
    }
}

/** 停止定位,清除内存 */
-(void)stopGetLocation
{
    NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
    [self.mapView removeAnnotations:array];
//    self.mapView.delegate = nil;
//    self.mapView = nil;
    self.search.delegate = nil;
    self.search = nil;
    self.reGeocodeSearch = nil;
    self.geoCodeSearch = nil;
    
    if (self.otherPoint) {
        self.otherPoint = nil;
    }
}




/**
 *  地理编码转换的经纬度
 *  @param address   传入地址字段来编码
 *  @param geoResult 地理编码转换的经纬度
 */
-(void)transfromAddress:(NSString *)address ToCoorSuccess:(void (^)(CLLocationCoordinate2D coor2d))geoResult
{
    _geoResult = geoResult;
   
    self.geoCodeSearch.address = address;
    self.geoCodeSearch.city = _city;
    [self.search AMapGeocodeSearch:self.geoCodeSearch];
}

#pragma mark --搜索附近--

/**
 *  根据关键字来搜索 如果是附近搜索的话需要先定位
 *
 *  @param keyword     关键字
 *  @param searchType  搜索的类型
 *  @param searchArray 搜索的结果数组 AMapPOI类型
 */
- (void)searchPoiByKeyword:(NSString*)keyword SearchType:(SKSearchType)searchType searchArray:(void(^)(NSArray* amapPoiArray))searchArray;
{
    _haveLoaction = NO;
    _mapView.showsUserLocation = NO;
    _mapView.showsUserLocation = YES;
    _searchResultArray = searchArray;
    if (searchType == SKSearchTypeNearby) {
        AMapPOIAroundSearchRequest* request = [[AMapPOIAroundSearchRequest alloc]init];
        request.keywords = keyword;
       request.location = [AMapGeoPoint locationWithLatitude:_tempCoor2d.latitude longitude:_tempCoor2d.longitude];
         request.sortrule            = 1;
        request.requireExtension    = YES;
        [self.search AMapPOIAroundSearch:request];
    }
    else if (searchType == SKSearchTypeKeywords)
    {
        /* 根据关键字来搜索POI. */
        
        AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
        request.keywords            = keyword;
        request.city                = _city;
        request.requireExtension    = YES;
        [self.search AMapPOIKeywordsSearch:request];
    }
}

#pragma mark --搜索代理--

/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        NSLog(@"没有搜索到数据");
        return;
    }
    if (_searchResultArray) {
        _searchResultArray(response.pois);
    }
    
    
    /* 如果只有一个结果，设置其为中心点. */
    if (response.pois.count == 1)
    {
        [self.mapView setCenterCoordinate:[response.pois[0] coordinate]];
    }
    /* 如果有多个结果, 设置地图使所有的annotation都可见. */
    else
    {
        //        [self.mapView showAnnotations:poiAnnotations animated:NO];
    }
}




- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    
    if ([annotation isKindOfClass:[SKMyPoint class]])
    {
        static NSString *customReuseIndetifier = @"SKMyPoint";
        
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            //            // must set to NO, so we can show the custom callout view.
            
//            annotationView.image = [UIImage imageNamed:@"myPosition"];
        }
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.calloutOffset = CGPointMake(0, -5);
        return annotationView;
    }
    
    if ([annotation isKindOfClass:[SKOtherPoint class]]) {
        
        static NSString *customReuseIndetifier = @"SKOtherPoint";
        
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:customReuseIndetifier];
        
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:customReuseIndetifier];
            //            // must set to NO, so we can show the custom callout view.
            
            annotationView.image = [UIImage imageNamed:@"overIcon"];
        }
        annotationView.canShowCallout = YES;
        annotationView.draggable = YES;
        annotationView.calloutOffset = CGPointMake(0, -5);
        return annotationView;

        
    }

    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    
    if(!_haveLoaction)
    {
        if (userLocation.location.horizontalAccuracy > 400) {
            _haveLoaction = YES;
            return;
        }
        _tempCoor2d = userLocation.coordinate;
        [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
        
        self.myPoint.coordinate = userLocation.coordinate;

        NSArray* array = [NSArray arrayWithArray:self.mapView.annotations];
        [self.mapView removeAnnotations:array];
        [self.mapView addAnnotation:self.myPoint];
        
        
        NSLog(@"顾客大头针lat:%f lon:%f",self.otherPoint.coordinate.latitude,self.otherPoint.coordinate.longitude);
        if (self.otherPoint.coordinate.latitude&&self.otherPoint.coordinate.longitude) {
            
            [self.mapView addAnnotation:self.otherPoint];
        }
       
        
        self.reGeocodeSearch.location  = [AMapGeoPoint locationWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
        self.reGeocodeSearch.requireExtension = YES;
        [self.search AMapReGoecodeSearch:self.reGeocodeSearch];
        if (userLocation.coordinate.latitude) {
            _haveLoaction = YES;
//            self.mapView.showsUserLocation = NO;//暂时去掉
        }
    }
}

#pragma mark --地理编码查询回调函数相关--

/**
 *  逆地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapReGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapReGeocodeSearchResponse 。
 */
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
//    AMapAddressComponent* addrComponet = response.regeocode.addressComponent;
    
    //获取定位的城市
    NSString* city = response.regeocode.addressComponent.province;
   
    if (city&&![city isEqualToString:@""]) {
        
        NSArray* arr = @[@"北京市",@"天津市",@"重庆市",@"上海市"];
        
        for (NSString*cityStr in arr) {
            if ([city isEqualToString:cityStr]) {
                _city = city;
            }
            else{
                _city = response.regeocode.addressComponent.city;
            }
        }
    }
    else{
        MJLog(@"获取城市失败");
    }
    
    self.myPoint.title = response.regeocode.formattedAddress;
    
    if (response.regeocode.formattedAddress&&_tempCoor2d.latitude&&_tempCoor2d.longitude) {
        if (_locationInfo) {
            self.locatoinModel.coor2D = _tempCoor2d;
            self.locatoinModel.detailAddress = response.regeocode.formattedAddress;
            self.locatoinModel.city = _city;
            
            MJLog(@"******************定位成功回调*********************");
            _locationInfo(self.locatoinModel);
        }
    }
    else{
        
        if (_failureInfo) {
            NSLog(@"获取位置失败");
             _failureInfo(@"获取位置失败");
        }
    }
}

/**
 *  地理编码查询回调函数
 *
 *  @param request  发起的请求，具体字段参考 AMapGeocodeSearchRequest 。
 *  @param response 响应结果，具体字段参考 AMapGeocodeSearchResponse 。
 */
- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response
{
    
    AMapGeocode* geoCode = [response.geocodes firstObject];
    
    if (geoCode.location.latitude && geoCode.location.longitude)
    {
        CLLocationCoordinate2D coor = CLLocationCoordinate2DMake(geoCode.location.latitude,  geoCode.location.longitude);
        if (_geoResult) {
            _geoResult(coor);
            NSLog(@"地理编码结果---lat:%f   lon:%f",coor.latitude,coor.longitude);
        }
    }
}






/**
 *  当请求发生错误时，会调用代理的此方法.
 *
 *  @param request 发生错误的请求.
 *  @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    
    MJLog(@"搜索代理错误%@",error);
//    [self showAlertWithContent:[NSString stringWithFormat:@"%@",error]];
}

#pragma mark --定位失败调用--
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    
    if (error.code == 1) {
//        NSLog(@"检测到系统没有开启定位服务");
        [self showAlertWithContent:@"检测到系统没有开启定位服务"];
    }
}

-(void)showAlertWithContent:(NSString*)content
{
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alert show];
}
@end
