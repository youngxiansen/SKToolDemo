//
//  NSDate+SKDate.m
//  SKAttendanceRecords
//
//  Created by youngxiansen on 15/9/11.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import "NSDate+SKDate.h"
#import <UIKit/UIKit.h>
@implementation NSDate (SKDate)

/**
 *  将时间戳转成日期
 *  @param str 字符串时间戳
 */
+(NSDate*)transfromStringToDateWithStr:(NSString*)str
{
    if (!str || [str isEqualToString:@""])
    {
        NSLog(@"时间戳为nil或者为空字符串");
        return nil;
    }
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[str floatValue]];
    return date;
}


/**
 *  返回某个时间 正数是未来  负数是过去
 *  @param beforeDayCount 天数
 */
-(NSDate *)dateWithtTimeinterval:(NSInteger)beforeDayCount
{
    return [self dateByAddingTimeInterval:3600*24*beforeDayCount];
}

/**
 *  判断某个日期是一年中的第几周
 */
+(NSInteger)getWeekNumberWithDate:(NSDate*)date
{
    NSDateComponents *componets;
    NSInteger weekNum;
    componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSCalendarUnitWeekOfYear fromDate:date];

    weekNum = componets.weekOfYear;
    
    
    return weekNum;
}

/**
 *  将日期字符串转成日期
 *  @param dateStr 2015-01-01
 *  @param format  yyyy-MM-dd
 */
+(NSDate*)trsansFromDateStrToDate:(NSString*)dateStr format:(NSString*)format
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    NSDate* date = [formatter dateFromString:dateStr];
    return date;
}

/**
 *  获取某一天的开始时间戳 2016-01-01 00:00:00
 */
+(NSString*)getOneDayStartTimeStr:(NSDate*)startDate
{
    //先将日期转成字符串获取00:00:00的时间字符串
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr = [format stringFromDate:startDate];
    dateStr = [dateStr stringByAppendingString:@" 00:00:00"];
    
    NSDate * tempDate = [NSDate trsansFromDateStrToDate:dateStr format:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"startDateStr---%@",dateStr);
    NSString* timeStr = [NSString stringWithFormat:@"%d",(int)(tempDate.timeIntervalSince1970)];
    return timeStr;
}

/**
 *  获取某一天的开始时间戳 2015-01-01 23:59:59
 */
+(NSString*)getOneDayEndTimeStr:(NSDate*)endDate
{
    //先将日期转成字符串获取2015-01-01 23:59:59的时间字符串
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr = [format stringFromDate:endDate];
    
    dateStr = [dateStr stringByAppendingString:@" 23:59:59"];
    NSDate * tempDate = [NSDate trsansFromDateStrToDate:dateStr format:@"yyyy-MM-dd HH:mm:ss"];
    NSLog(@"endDateStr---%@",dateStr);
    NSString* timeStr = [NSString stringWithFormat:@"%d",(int)(tempDate.timeIntervalSince1970)];
    return timeStr;
}

/**
 *  判断是否是最新的月份
 */
-(BOOL)isTheNewestMonth:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM"];
    NSString * dateStr = [format stringFromDate:date];
    
    NSString* currentDateStr = [format stringFromDate:self];
    
    NSLog(@"----%@----%@",currentDateStr,dateStr);
    if ([dateStr isEqualToString:currentDateStr]) {
        return YES;
    }
    return NO;
    
}

/**
 *  判断是否是最新的天
 */
-(BOOL)isTheNewestDay:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr = [format stringFromDate:date];
    
    NSString* currentDateStr = [format stringFromDate:self];
    
    NSLog(@"----%@----%@",currentDateStr,dateStr);
    if ([dateStr isEqualToString:currentDateStr]) {
        return YES;
    }
    return NO;
    
}

/**
 *  判断是否是最新的week
 */
-(BOOL)isTheNewestWeek:(NSDate*)date
{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd"];
    NSString * dateStr = [format stringFromDate:date];
    NSArray* arr1 = [dateStr componentsSeparatedByString:@"-"];
    
    NSString* currentDateStr = [format stringFromDate:self];
    NSArray* arr2 = [currentDateStr componentsSeparatedByString:@"-"];
    
    NSLog(@"-------%@------%@",currentDateStr,dateStr);
    if ([arr2[0] floatValue] < [arr1[0] floatValue]) {
        return YES;
    }
    else if ([arr2[0] floatValue] == [arr1[0] floatValue])
    {
        if ([arr2[1] floatValue] < [arr1[1] floatValue]) {
            return YES;
        }
        else if ([arr2[1]floatValue] == [arr1[1] floatValue])
        {
            if ([arr2[2]integerValue] <= [arr1[2]floatValue]) {
                return YES;
            }
            else{
                return NO;
            }
        }
        else{
            return NO;
        }
    }
    else{
        return NO;
    }
    return NO;
    
}

@end
