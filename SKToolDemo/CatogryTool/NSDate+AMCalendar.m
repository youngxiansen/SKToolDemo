//
//  NSDate+AMCalendar.m
//  decoration
//
//  Created by Aimi on 15/9/28.
//  Copyright © 2015年 AQiang. All rights reserved.
//

#import "NSDate+AMCalendar.h"

@implementation NSDate (AMCalendar)
//这个月有多少天
- (NSUInteger)numberOfDaysInCurrentMonth
{
    // 频繁调用 [NSCalendar currentCalendar] 可能存在性能问题
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:self].length;
}
//确定这个月的第一天是星期几
- (NSDate *)firstDayOfCurrentMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

- (NSDate *)firstDayOfCurrentWeek
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:NSWeekCalendarUnit startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

- (NSUInteger)weeklyOrdinality
{
    return [[NSCalendar currentCalendar] ordinalityOfUnit:NSDayCalendarUnit inUnit:NSWeekCalendarUnit forDate:self];
}
-(NSUInteger)daysOfMonth:(NSUInteger)month year:(NSUInteger)year{
    int numberOfDays;
    if (month == 4 || month == 6 || month == 9 || month == 11)
        numberOfDays = 30;
    else if (month == 2)
    { bool isLeapYear = (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
        if (isLeapYear)
            numberOfDays = 29;
        else
            numberOfDays = 28;
    }
    else
        numberOfDays = 31;
    return numberOfDays;
    
}
//指定年月日是星期几 type:1 (1是周一) type:0(1是周日)
-(NSInteger)dateOfWeekdayWithYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day type:(NSInteger)type{
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:day];
    [_comps setMonth:month];
    [_comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int _weekday = (int)[weekdayComponents weekday];
    //    NSLog(@"_weekday::%d",_weekday);//1是星期日2是星期一
    if (type) {
        if (_weekday>1) {
            _weekday=_weekday-1;
            
        }else{
            _weekday=7;
        }
        return _weekday;
    }else{
        return _weekday;
    }
}
+(NSInteger)getYear{
    NSDate* date=[NSDate date];
    NSDateFormatter* dateToString=[[NSDateFormatter alloc]init];
    [dateToString setDateFormat:@"yyyy"];
    NSString* year=[dateToString stringFromDate:date];
    return [year integerValue];
    
}
+(NSInteger)getMonth{
    NSDate* date=[NSDate date];
    NSDateFormatter* dateToString=[[NSDateFormatter alloc]init];
    [dateToString setDateFormat:@"MM"];
    NSString* month=[dateToString stringFromDate:date];
    return [month integerValue];
    
}
+(NSInteger)getDay{
    NSDate* date=[NSDate date];
    NSDateFormatter* dateToString=[[NSDateFormatter alloc]init];
    [dateToString setDateFormat:@"dd"];
    NSString* day=[dateToString stringFromDate:date];
    return [day integerValue];
}

//指定年月日是星期几 type:1 (1是周一) type:0(1是周日)
+(NSInteger)weekdayOfYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day type:(NSInteger)type{
    NSDateComponents *_comps = [[NSDateComponents alloc] init];
    [_comps setDay:day];
    [_comps setMonth:month];
    [_comps setYear:year];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *_date = [gregorian dateFromComponents:_comps];
    NSDateComponents *weekdayComponents =
    [gregorian components:NSWeekdayCalendarUnit fromDate:_date];
    int _weekday = (int)[weekdayComponents weekday];
    //    NSLog(@"_weekday::%d",_weekday);//1是星期日2是星期一
    if (type) {
        if (_weekday>1) {
            _weekday=_weekday-1;
            
        }else{
            _weekday=7;
        }
        return _weekday;
    }else{
        return _weekday;
    }
}


-(NSInteger)getYear{
    NSDate* date= self;
    NSDateFormatter* dateToString=[[NSDateFormatter alloc]init];
    [dateToString setDateFormat:@"yyyy"];
    NSString* year=[dateToString stringFromDate:date];
    return [year integerValue];
    
}

-(NSInteger)getMonth{
    NSDate* date= self;
    NSDateFormatter* dateToString=[[NSDateFormatter alloc]init];
    [dateToString setDateFormat:@"MM"];
    NSString* month=[dateToString stringFromDate:date];
    return [month integerValue];
    
}
-(NSInteger)getDay{
    NSDate* date= self;
    NSDateFormatter* dateToString=[[NSDateFormatter alloc]init];
    [dateToString setDateFormat:@"dd"];
    NSString* day=[dateToString stringFromDate:date];
    return [day integerValue];
}


#pragma mark  -----农历相关----
-(NSString*)getChineseCalendar{
    
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯",  @"戊辰",  @"己巳",  @"庚午",  @"辛未",  @"壬申",  @"癸酉",
                             @"甲戌",   @"乙亥",  @"丙子",  @"丁丑", @"戊寅",   @"己卯",  @"庚辰",  @"辛己",  @"壬午",  @"癸未",
                             @"甲申",   @"乙酉",  @"丙戌",  @"丁亥",  @"戊子",  @"己丑",  @"庚寅",  @"辛卯",  @"壬辰",  @"癸巳",
                             @"甲午",   @"乙未",  @"丙申",  @"丁酉",  @"戊戌",  @"己亥",  @"庚子",  @"辛丑",  @"壬寅",  @"癸丑",
                             @"甲辰",   @"乙巳",  @"丙午",  @"丁未",  @"戊申",  @"己酉",  @"庚戌",  @"辛亥",  @"壬子",  @"癸丑",
                             @"甲寅",   @"乙卯",  @"丙辰",  @"丁巳",  @"戊午",  @"己未",  @"庚申",  @"辛酉",  @"壬戌",  @"癸亥", nil];
    
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月", @"七月", @"八月",
                            @"九月", @"十月", @"冬月", @"腊月", nil];
    
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    
    NSString *y_str = [chineseYears objectAtIndex:localeComp.year-1];
    NSString *m_str = [chineseMonths objectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays objectAtIndex:localeComp.day-1];
    
    NSString *chineseCal_str =[NSString stringWithFormat: @"%@_%@_%@",y_str,m_str,d_str];
    
    return chineseCal_str;
}


-(NSString*)getChineseYear{
    NSString* chinesesCalStr = [self getChineseCalendar];
    NSArray* array = [chinesesCalStr componentsSeparatedByString:@"_"];
    return array[0];
}

-(NSString*)getChineseMonth{
    NSString* chinesesCalStr = [self getChineseCalendar];
    NSArray* array = [chinesesCalStr componentsSeparatedByString:@"_"];
    return array[1];
}

-(NSString*)getChineseDay{
    NSString* chinesesCalStr = [self getChineseCalendar];
    NSArray* array = [chinesesCalStr componentsSeparatedByString:@"_"];
    return array[2];
}


-(NSString*)getChineseDayAndNeedHoliday{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd"];
    NSString * dateString = [format stringFromDate:self];
    
    NSDictionary* gregorianHoliday = @{
                                       @"01-01":    @"元旦",
                                       @"02-14":   @"情人",
                                       @"04-04":    @"清明",
                                       @"05-01":    @"劳动",
                                       @"10-01":   @"国庆",
                                       };
    
    if(gregorianHoliday[dateString]){
        return gregorianHoliday[dateString];
    }
    
    
    NSDictionary *chineseHoliDay =@{
                                    @"1-1":  @"春节",
                                    @"1-15": @"元宵",
                                    @"5-5":  @"端午",
                                    @"7-7":  @"七夕",
                                    @"7-15": @"中元",
                                    @"8-15": @"中秋",
                                    @"9-9":  @"重阳",
                                    @"12-8": @"腊八",
                                    @"12-24":@"小年"
                                    };
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    NSString *key_str = [NSString stringWithFormat:@"%d-%d",(int)localeComp.month,(int)localeComp.day];
    
    if (chineseHoliDay[key_str]) {
        return chineseHoliDay[key_str];
    }
    
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    return chineseDays[localeComp.day-1];
}


-(BOOL)hasHoliday{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MM-dd"];
    NSString * dateString = [format stringFromDate:self];
    
    NSDictionary* gregorianHoliday = @{
                                       @"01-01":    @"元旦",
                                       @"02-14":   @"情人",
                                       @"04-04":    @"清明",
                                       @"05-01":    @"劳动",
                                       @"10-01":   @"国庆",
                                       };
    
    if(gregorianHoliday[dateString]){
        return YES;
    }
    
    
    NSDictionary *chineseHoliDay =@{
                                    @"1-1":  @"春节",
                                    @"1-15": @"元宵",
                                    @"5-5":  @"端午",
                                    @"7-7":  @"七夕",
                                    @"7-15": @"中元",
                                    @"8-15": @"中秋",
                                    @"9-9":  @"重阳",
                                    @"12-8": @"腊八",
                                    @"12-24":@"小年"
                                    };
    NSCalendar *localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSChineseCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:self];
    NSString *key_str = [NSString stringWithFormat:@"%d-%d",(int)localeComp.month,(int)localeComp.day];
    
    if (chineseHoliDay[key_str]) {
        return YES;
    }
    
    return NO;
}

-(NSDate*)nextMonthDate{
    NSDate* first = [self firstDayOfCurrentMonth];
    NSDate* next = [NSDate dateWithTimeInterval:60*60*24*32 sinceDate:first];
    return [next firstDayOfCurrentMonth];
}

-(NSDate*)awordMonthDate{
    NSDate* first = [self firstDayOfCurrentMonth];
    NSDate* aword = [NSDate dateWithTimeInterval:-60*60*24*2 sinceDate:first];
    return [aword firstDayOfCurrentMonth];
}

//-(NSDictionary *)getYellowCalendarDic{
//    return [AMYellowCalendarTools getCalendarDicWithDate:self];
//}

@end
