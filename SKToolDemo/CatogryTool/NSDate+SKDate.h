//
//  NSDate+SKDate.h
//  SKAttendanceRecords
//
//  Created by youngxiansen on 15/9/11.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (SKDate)

/**
 *  将时间戳转成日期
 *  @param str 字符串时间戳
 */
+(NSDate*)transfromStringToDateWithStr:(NSString*)str;


/**
 *  返回某个时间 正数是未来  负数是过去
 *  @param beforeDayCount 天数
 */
-(NSDate *)dateWithtTimeinterval:(NSInteger)beforeDayCount;

/**
 *  判断某个日期是一年中的第几周
 */
+(NSInteger)getWeekNumberWithDate:(NSDate*)date;

/**
 *  将日期字符串转成日期
 *  @param dateStr 2015-01-01
 *  @param format  yyyy-MM-dd
 */
+(NSDate*)trsansFromDateStrToDate:(NSString*)dateStr format:(NSString*)format;

/**
 *  获取某一天的开始时间戳 2016-01-01 00:00:00
 */
+(NSString*)getOneDayStartTimeStr:(NSDate*)startDate;

/**
 *  获取某一天的开始时间戳 2015-01-01 23:59:59
 */
+(NSString*)getOneDayEndTimeStr:(NSDate*)endDate;

/**
 *  判断是否是最新的月份
 */
-(BOOL)isTheNewestMonth:(NSDate*)date;

/**
 *  判断是否是最新的天
 */
-(BOOL)isTheNewestDay:(NSDate*)date;

/**
 *  判断是否是最新的week
 */
-(BOOL)isTheNewestWeek:(NSDate*)date;
@end
