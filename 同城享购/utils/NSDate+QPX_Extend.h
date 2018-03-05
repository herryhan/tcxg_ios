//
//  NSDate+QPX_Extend.h
//  QPXExtend
//
//  Created by DemonArrow on 2016/11/26.
//  Copyright © 2016年 DemonArrow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (QPX_Extend)

@property (nonatomic,copy,readonly) NSString *qpx_timestamp;//时间戳

@property (nonatomic,strong,readonly) NSDateComponents *qpx_components;//时间成分

@property (nonatomic,assign,readonly) BOOL qpx_isThisYear;//是否是今年

@property (nonatomic,assign,readonly) BOOL qpx_isToday;//是否是今天

@property (nonatomic,assign,readonly) BOOL qpx_isYesterday;//是否是昨天

/*
    获取本地时间
 */
+(NSDate *)qpx_localDate;
-(NSDate *)qpx_localDate;

+(NSDateComponents *)qpx_dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate;

-(NSUInteger)qpx_getYear;//获取年
-(NSUInteger)qpx_getMonth;//获取月
-(NSUInteger)qpx_getDay;//获取日
-(NSUInteger)qpx_getHour;//获取时
-(NSUInteger)qpx_getMinute;//获取分
-(NSUInteger)qpx_getSecond;//获取秒

+(NSUInteger)qpx_YearOfDate:(NSDate *)date;//获取年
+(NSUInteger)qpx_MonthOfDate:(NSDate *)date;//获取月
+(NSUInteger)qpx_DayOfDate:(NSDate *)date;//获取日
+(NSUInteger)qpx_HourOfDate:(NSDate *)date;//获取时
+(NSUInteger)qpx_MinuteOfDate:(NSDate *)date;//获取分
+(NSUInteger)qpx_SecondOfDate:(NSDate *)date;//获取秒

-(NSUInteger)qpx_dayInYear;//一年中总天数
+(NSUInteger)qpx_dayInYearOfDate:(NSDate *)date;//一年中总天数

-(BOOL)qpx_isLeapYear;//是否闰年
+(BOOL)qpx_isLeapYearOfDate:(NSDate *)date;//是否闰年

-(NSUInteger)qpx_weekOfYear;//该日期是该年的第几周
+(NSUInteger)qpx_weekOfYearOfDate:(NSDate *)date;//该日期是该年的第几周

/**
 * 获取格式化为YYYY-MM-dd格式的日期字符串
 */
- (NSString *)qpx_formatYMD;
+ (NSString *)qpx_formatYMD:(NSDate *)date;

/**
 * 返回当前月一共有几周(可能为4,5,6)
 */
- (NSUInteger)qpx_weeksOfMonth;
+ (NSUInteger)qpx_weeksOfMonth:(NSDate *)date;

/**
 * 获取该月的第一天的日期
 */
- (NSDate *)qpx_begindayOfMonth;
+ (NSDate *)qpx_begindayOfMonth:(NSDate *)date;

/**
 * 获取该月的最后一天的日期
 */
- (NSDate *)qpx_lastdayOfMonth;
+ (NSDate *)qpx_lastdayOfMonth:(NSDate *)date;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)qpx_dateAfterDay:(NSUInteger)day;
+ (NSDate *)qpx_dateAfterDate:(NSDate *)date day:(NSInteger)day;

/**
 * 返回day天后的日期(若day为负数,则为|day|天前的日期)
 */
- (NSDate *)qpx_dateAfterMonth:(NSUInteger)month;
+ (NSDate *)qpx_dateAfterDate:(NSDate *)date month:(NSInteger)month;

/**
 * 返回numYears年后的日期
 */
- (NSDate *)qpx_offsetYears:(int)numYears;
+ (NSDate *)qpx_offsetYears:(int)numYears fromDate:(NSDate *)fromDate;

/**
 * 返回numMonths月后的日期
 */
- (NSDate *)qpx_offsetMonths:(int)numMonths;
+ (NSDate *)qpx_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate;

/**
 * 返回numDays天后的日期
 */
- (NSDate *)qpx_offsetDays:(int)numDays;
+ (NSDate *)qpx_offsetDays:(int)numDays fromDate:(NSDate *)fromDate;

/**
 * 返回numHours小时后的日期
 */
- (NSDate *)qpx_offsetHours:(int)hours;
+ (NSDate *)qpx_offsetHours:(int)numHours fromDate:(NSDate *)fromDate;

/**
 * 距离该日期前几天
 */
- (NSUInteger)qpx_daysAgo;
+ (NSUInteger)qpx_daysAgo:(NSDate *)date;

/**
 *  获取星期几
 *
 *  @return Return weekday number
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSInteger)qpx_weekday;
+ (NSInteger)qpx_weekday:(NSDate *)date;

/**
 *  获取星期几(名称)
 *
 *  @return Return weekday as a localized string
 *  [1 - Sunday]
 *  [2 - Monday]
 *  [3 - Tuerday]
 *  [4 - Wednesday]
 *  [5 - Thursday]
 *  [6 - Friday]
 *  [7 - Saturday]
 */
- (NSString *)qpx_dayFromWeekday;
+ (NSString *)qpx_dayFromWeekday:(NSDate *)date;

/**
 *  日期是否相等
 *
 *  @param anotherDate The another date to compare as NSDate
 *  @return Return YES if is same day, NO if not
 */
- (BOOL)qpx_isSameDay:(NSDate *)anotherDate;

/**
 *  Add days to self
 *
 *  @param days The number of days to add
 *  @return Return self by adding the gived days number
 */
- (NSDate *)qpx_dateByAddingDays:(NSUInteger)days;

/**
 *  Get the month as a localized string from the given month number
 *
 *  @param month The month to be converted in string
 *  [1 - January]
 *  [2 - February]
 *  [3 - March]
 *  [4 - April]
 *  [5 - May]
 *  [6 - June]
 *  [7 - July]
 *  [8 - August]
 *  [9 - September]
 *  [10 - October]
 *  [11 - November]
 *  [12 - December]
 *
 *  @return Return the given month as a localized string
 */
+ (NSString *)qpx_monthWithMonthNumber:(NSInteger)month;

/**
 * 根据日期返回字符串 format源字符串格式
 */
+ (NSString *)qpx_stringWithDate:(NSDate *)date format:(NSString *)format;
- (NSString *)qpx_stringWithFormat:(NSString *)format;
+ (NSDate *)qpx_dateWithString:(NSString *)string format:(NSString *)format;
/**
 *  本地英文的格式
 *
 *  @param string 时间戳
 *  @param format  eg @"MM/d/yyyy h:mm:ss aa"
 *
 *  @return NSDate
 */
+ (NSDate *)qpx_dateWithLocaleEN_USString:(NSString *)string format:(NSString *)format;
/**
 *  Use DateFormatter to transform dateString to specified date string.
 *
 *  @param dateString                Date string. (eg. 2015-06-26 08:08:08)
 *  @param inputDateStringFormatter  Input date string formatter. (eg. yyyy-MM-dd HH:mm:ss)
 *  @param outputDateStringFormatter Output date string formatter. (eg. yy/MM/dd)
 *
 *  @return Specified date string.
 */
+ (NSString *)qpx_dateFormatterWithInputDateString:(NSString *)dateString
                      inputDateStringFormatter:(NSString *)inputDateStringFormatter
                     outputDateStringFormatter:(NSString *)outputDateStringFormatter;



/**
 * 获取指定月份的天数
 */
- (NSUInteger)qpx_daysInMonth:(NSUInteger)month;
+ (NSUInteger)qpx_daysInMonth:(NSDate *)date month:(NSUInteger)month;

/**
 * 获取当前月份的天数
 */
- (NSUInteger)qpx_daysInMonth;
+ (NSUInteger)qpx_daysInMonth:(NSDate *)date;

/**
 * 返回x分钟前/x小时前/昨天/x天前/x个月前/x年前
 */
- (NSString *)qpx_timeInfo;
+ (NSString *)qpx_timeInfoWithDate:(NSDate *)date;
+ (NSString *)qpx_timeInfoWithDateString:(NSString *)dateString;

/**
 * 分别获取yyyy-MM-dd/HH:mm:ss/yyyy-MM-dd HH:mm:ss格式的字符串
 */
- (NSString *)qpx_ymdFormat;
- (NSString *)qpx_hmsFormat;
- (NSString *)qpx_ymdHmsFormat;
+ (NSString *)qpx_ymdFormat;
+ (NSString *)qpx_hmsFormat;
+ (NSString *)qpx_ymdHmsFormat;

/**
 *  返回时间戳
 */
+(NSString *)qpx_timeToTimeStamps;

/**
 *  获取系统当前时间返回指定格式
 *
 *  @param format 时间格式
 *
 *  @return 时间格式字符串
 */
+(NSString *)qpx_getNewTimeFormat:(NSString *)format;

/**
 * 判断时间早晚
 */
+(int)qpx_compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;



@end
