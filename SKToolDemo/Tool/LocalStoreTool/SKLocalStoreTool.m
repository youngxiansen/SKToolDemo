//
//  SKLocalStoreTool.m
//  SKTools
//
//  Created by youngxiansen on 15/7/30.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import "SKLocalStoreTool.h"
#import "NSString+SKString.h"

@implementation SKLocalStoreTool
static SKLocalStoreTool* _l = nil;
+(id)shareManager
{
    //给下面这一段代码加锁:线程锁,同一时刻只能有一个线程访问
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        if (!_l)
        {
            _l = [[SKLocalStoreTool alloc]init];
        }
    });

    return _l;
}

//当调用alloc方法的时候,系统会调用这个方法
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_l) {
        _l = [super allocWithZone:zone];
    }
    return _l;
}


#pragma mark --存储的变量--
-(void)storeDriverId:(NSString*)driverId
{
    [NSString storeObject:driverId forKey:@"driverId"];
}
/** 获取userid */
-(NSString*)getDriverId
{
    return [NSString getObjectWithKey:@"driverId"];
}

//+(void)storeSearchHistory:(AMapPOI*)poiInfo
//{
//    if (!poiInfo.location.latitude||!poiInfo.location.longitude) {
//        return;
//    }
//    NSDictionary* dic = @{@"Hname":poiInfo.name,
//                          @"Hlatitude":[NSString stringWithFormat:@"%lf",poiInfo.location.latitude],
//                          @"Hlongitude":[NSString stringWithFormat:@"%lf",poiInfo.location.longitude],
//                          @"Haddress":poiInfo.address};
////    NSLog(@"******存储%@",dic);
//    NSString* filePath = [[NSString getCachePath]stringByAppendingString:@"searchHistory.plist"];
//    
//    // 4.读取数据
//    NSMutableArray *searchHistory = [[NSMutableArray arrayWithContentsOfFile:filePath]mutableCopy];
//    if (!searchHistory) {
//        searchHistory = [NSMutableArray array];
//        
//    }
//    for (int i =0; i<searchHistory.count; i++) {
//        
//        NSDictionary* dic=searchHistory[i];
//        if ([poiInfo.name isEqualToString:dic[@"Hname"]]) {
//            return;
//        }
//        
//    }
//    
//    if (searchHistory.count==5) {
//        [searchHistory removeLastObject];
//    }
//    
//    [searchHistory insertObject:dic atIndex:0];
//    [searchHistory writeToFile:filePath atomically:YES];
//
//}
//
//+(NSMutableArray*)getSearchHistory
//{
//    NSString* filePath = [[NSString getCachePath]stringByAppendingString:@"searchHistory.plist"];
//    
//    NSMutableArray *data = [NSMutableArray arrayWithContentsOfFile:filePath];
//    
//    NSMutableArray* poiArray=[NSMutableArray array];
//    
//    for (int i=0; i<data.count; i++) {
////
//        NSDictionary* dic=data[i];
//        AMapPOI* poi = [[AMapPOI alloc]init];
//        poi.name = dic[@"Hname"];
//        poi.location.latitude = [dic[@"Hlatitude"] floatValue];
//        poi.location.longitude = [dic[@"Hlongitude"] floatValue];
//        AMapGeoPoint* point = [[AMapGeoPoint alloc]init];
//        point.latitude = [dic[@"Hlatitude"] floatValue];
//        point.longitude = [dic[@"Hlongitude"] floatValue];
//        
//        poi.location = point;
//        
//        poi.address = dic[@"Haddress"];
//        [poiArray addObject:poi];
//    }
//    return poiArray;
//
//}


@end
