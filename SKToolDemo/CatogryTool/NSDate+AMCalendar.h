//
//  NSDate+AMCalendar.h
//  decoration
//
//  Created by Aimi on 15/9/28.
//  Copyright © 2015年 AQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "AMYellowCalendarTools.h"

@interface NSDate (AMCalendar)

+(NSInteger)getYear;
+(NSInteger)getMonth;
+(NSInteger)getDay;
+(NSInteger)weekdayOfYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day type:(NSInteger)type;
-(NSUInteger)daysOfMonth:(NSUInteger)month year:(NSUInteger)year;
- (NSUInteger)weeklyOrdinality;

/**
 *  获取当前月份一共多少天
 */
- (NSUInteger)numberOfDaysInCurrentMonth;

/**
 *  获取当前月份的第一天
 */
- (NSDate *)firstDayOfCurrentMonth;

/**
 *  获取当前星期的第一天 (周日为第一天)
 */
- (NSDate *)firstDayOfCurrentWeek;

/**
 *  获取到某一天是星期几
 *
 *  @param year  年份
 *  @param month 月份
 *  @param day   天
 *  @param type:1 (1是周一) type:0(1是周日)
 *
 *  @return 星期几
 */
- (NSInteger)dateOfWeekdayWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day type:(NSInteger)type;

/**
 *  获取年份
 */
-(NSInteger)getYear;

/**
 *  获取月份
 */
-(NSInteger)getMonth;

/**
 *  获取日期
 */
-(NSInteger)getDay;

/**
 *  下一个月
 */
-(NSDate*)nextMonthDate;

/**
 *  上一个月
 */
-(NSDate*)awordMonthDate;




#pragma mark  --------农历相关------
/**
 *  获取农历的年份
 */
-(NSString*)getChineseYear;

/**
 *  获取农历的月份
 */
-(NSString*)getChineseMonth;

/**
 *  获取农历的初几
 */
-(NSString*)getChineseDay;

/**
 *  获取节日名 如果没有节日 则直接返回农历初几
 */
-(NSString*)getChineseDayAndNeedHoliday;

/**
 *  判断是否存在节日
 */
-(BOOL)hasHoliday;


#pragma mark  -------获取黄历相关--------
-(NSDictionary*)getYellowCalendarDic;


@end
