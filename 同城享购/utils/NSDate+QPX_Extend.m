//
//  NSDate+QPX_Extend.m
//  QPXExtend
//
//  Created by DemonArrow on 2016/11/26.
//  Copyright © 2016年 DemonArrow. All rights reserved.
//

#import "NSDate+QPX_Extend.h"

@interface NSDate ( )
/*
 *  清空时分秒，保留年月日
 */
@property (nonatomic,strong,readonly) NSDate *ymdDate;
@end

@implementation NSDate (QPX_Extend)

/*
 获取本地时间
 */
+(NSDate *)qpx_localDate{
    NSDate *date = [NSDate date];
//    NSTimeZone *zone = [NSTimeZone systemTimeZone];
//    NSTimeInterval time = [zone secondsFromGMTForDate:date];
//    date = [date dateByAddingTimeInterval:time];
    return date;
}

-(NSDate *)qpx_localDate{
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSTimeInterval time = [zone secondsFromGMTForDate:self];
    NSDate *date = [self dateByAddingTimeInterval:time];
    return date;
}

-(NSString *)qpx_timestamp{
    NSTimeInterval timeInterval = [self timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%.0f",timeInterval];
    return [timeString copy];
}

-(NSDateComponents *)qpx_components{
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    //定义成分
    NSCalendarUnit unit=NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self];
}

-(BOOL)qpx_isThisYear{
    //取出给定时间的components
    NSDateComponents *dateComponents=self.qpx_components;
    //取出当前时间的components
    NSDateComponents *nowComponents=[NSDate date].qpx_components;
    //直接对比年成分是否一致即可
    BOOL res = dateComponents.year==nowComponents.year;
    return res;
}

-(BOOL)qpx_isToday{
    //差值为0天
    return [self qpx_calWithValue:0];
}

-(BOOL)qpx_isYesterday{
    //差值为1天
    return [self qpx_calWithValue:1];
}

-(BOOL)qpx_calWithValue:(NSInteger)value{
    //得到给定时间的处理后的时间的components
    NSDateComponents *dateComponents=self.ymdDate.qpx_components;
    //得到当前时间的处理后的时间的components
    NSDateComponents *nowComponents=[NSDate date].ymdDate.qpx_components;
    //比较
    BOOL res=dateComponents.year==nowComponents.year && dateComponents.month==nowComponents.month && (dateComponents.day + value)==nowComponents.day;
    return res;
}

/*
 *  清空时分秒，保留年月日
 */
-(NSDate *)qpx_ymdDate{
    //定义fmt
    NSDateFormatter *fmt=[[NSDateFormatter alloc] init];
    //设置格式:去除时分秒
    fmt.dateFormat=@"yyyy-MM-dd";
    //得到字符串格式的时间
    NSString *dateString=[fmt stringFromDate:self];
    //再转为date
    NSDate *date=[fmt dateFromString:dateString];
    return date;
}

+(NSDateComponents *)qpx_dateComponents:(NSCalendarUnit)unit fromDate:(NSDate *)fromDate toDate:(NSDate *)toDate{
    //创建日历
    NSCalendar *calendar=[NSCalendar currentCalendar];
    //直接计算
    NSDateComponents *components = [calendar components:unit fromDate:fromDate toDate:toDate options:0];
    return components;
}

- (NSUInteger)qpx_getDay {
    return [NSDate qpx_DayOfDate:self];
}

- (NSUInteger)qpx_getMonth {
    return [NSDate qpx_MonthOfDate:self];
}

- (NSUInteger)qpx_getYear {
    return [NSDate qpx_YearOfDate:self];
}

- (NSUInteger)qpx_getHour {
    return [NSDate qpx_HourOfDate:self];
}

- (NSUInteger)qpx_getMinute {
    return [NSDate qpx_MinuteOfDate:self];
}

- (NSUInteger)qpx_getSecond {
    return [NSDate qpx_SecondOfDate:self];
}

+ (NSUInteger)qpx_DayOfDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSDayCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents day];
}

+ (NSUInteger)qpx_MonthOfDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMonthCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents month];
}

+ (NSUInteger)qpx_YearOfDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitYear) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSYearCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents year];
}

+ (NSUInteger)qpx_HourOfDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitHour) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSHourCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents hour];
}

+ (NSUInteger)qpx_MinuteOfDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMinute) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSMinuteCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents minute];
}

+ (NSUInteger)qpx_SecondOfDate:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitSecond) fromDate:date];
#else
    NSDateComponents *dayComponents = [calendar components:(NSSecondCalendarUnit) fromDate:date];
#endif
    
    return [dayComponents second];
}

- (NSUInteger)qpx_dayInYear {
    return [NSDate qpx_dayInYearOfDate:self];
}

+ (NSUInteger)qpx_dayInYearOfDate:(NSDate *)date {
    return [self qpx_isLeapYearOfDate:date] ? 366 : 365;
}

- (BOOL)qpx_isLeapYear {
    return [NSDate qpx_isLeapYearOfDate:self];
}

+ (BOOL)qpx_isLeapYearOfDate:(NSDate *)date {
    NSUInteger year = [date qpx_getYear];
    if ((year % 4  == 0 && year % 100 != 0) || year % 400 == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)qpx_formatYMD {
    return [NSDate qpx_formatYMD:self];
}

+ (NSString *)qpx_formatYMD:(NSDate *)date {
    return [NSString stringWithFormat:@"%lu-%02lu-%02lu",(unsigned long)[date qpx_getYear],(unsigned long)[date qpx_getMonth], (unsigned long)[date qpx_getDay]];
}

- (NSUInteger)qpx_weeksOfMonth {
    return [NSDate qpx_weeksOfMonth:self];
}

+ (NSUInteger)qpx_weeksOfMonth:(NSDate *)date {
    return [[date qpx_lastdayOfMonth] qpx_weekOfYear] - [[date qpx_begindayOfMonth] qpx_weekOfYear] + 1;
}

- (NSUInteger)qpx_weekOfYear {
    return [NSDate qpx_weekOfYearOfDate:self];
}

+ (NSUInteger)qpx_weekOfYearOfDate:(NSDate *)date {
    NSUInteger i;
    NSUInteger year = [date qpx_getYear];
    
    NSDate *lastdate = [date qpx_lastdayOfMonth];
    
    for (i = 1;[[lastdate qpx_dateAfterDay:-7 * i] qpx_getYear] == year; i++) {
        
    }
    
    return i;
}

- (NSDate *)qpx_dateAfterDay:(NSUInteger)day {
    return [NSDate qpx_dateAfterDate:self day:day];
}

+ (NSDate *)qpx_dateAfterDate:(NSDate *)date day:(NSInteger)day {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterDay;
}

- (NSDate *)qpx_dateAfterMonth:(NSUInteger)month {
    return [NSDate qpx_dateAfterDate:self month:month];
}

+ (NSDate *)qpx_dateAfterDate:(NSDate *)date month:(NSInteger)month {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setMonth:month];
    NSDate *dateAfterMonth = [calendar dateByAddingComponents:componentsToAdd toDate:date options:0];
    
    return dateAfterMonth;
}

- (NSDate *)qpx_begindayOfMonth {
    return [NSDate qpx_begindayOfMonth:self];
}

+ (NSDate *)qpx_begindayOfMonth:(NSDate *)date {
    return [self qpx_dateAfterDate:date day:-[date qpx_getDay] + 1];
}

- (NSDate *)qpx_lastdayOfMonth {
    return [NSDate qpx_lastdayOfMonth:self];
}

+ (NSDate *)qpx_lastdayOfMonth:(NSDate *)date {
    NSDate *lastDate = [self qpx_begindayOfMonth:date];
    return [[lastDate qpx_dateAfterMonth:1] qpx_dateAfterDay:-1];
}

- (NSUInteger)qpx_daysAgo {
    return [NSDate qpx_daysAgo:self];
}

+ (NSUInteger)qpx_daysAgo:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    NSDateComponents *components = [calendar components:(NSCalendarUnitDay)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#else
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit)
                                               fromDate:date
                                                 toDate:[NSDate date]
                                                options:0];
#endif
    
    return [components day];
}

- (NSInteger)qpx_weekday {
    return [NSDate qpx_weekday:self];
}

+ (NSInteger)qpx_weekday:(NSDate *)date {
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *comps = [gregorian components:(NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitWeekday) fromDate:date];
    NSInteger weekday = [comps weekday];
    
    return weekday;
}

- (NSString *)qpx_dayFromWeekday {
    return [NSDate qpx_dayFromWeekday:self];
}

+ (NSString *)qpx_dayFromWeekday:(NSDate *)date {
    switch([date qpx_weekday]) {
        case 1:
            return @"星期天";
            break;
        case 2:
            return @"星期一";
            break;
        case 3:
            return @"星期二";
            break;
        case 4:
            return @"星期三";
            break;
        case 5:
            return @"星期四";
            break;
        case 6:
            return @"星期五";
            break;
        case 7:
            return @"星期六";
            break;
        default:
            break;
    }
    return @"";
}

- (BOOL)qpx_isSameDay:(NSDate *)anotherDate {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components1 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:self];
    NSDateComponents *components2 = [calendar components:(NSCalendarUnitYear
                                                          | NSCalendarUnitMonth
                                                          | NSCalendarUnitDay)
                                                fromDate:anotherDate];
    return ([components1 year] == [components2 year]
            && [components1 month] == [components2 month]
            && [components1 day] == [components2 day]);
}

- (NSDate *)qpx_dateByAddingDays:(NSUInteger)days {
    NSDateComponents *c = [[NSDateComponents alloc] init];
    c.day = days;
    return [[NSCalendar currentCalendar] dateByAddingComponents:c toDate:self options:0];
}

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
+ (NSString *)qpx_monthWithMonthNumber:(NSInteger)month {
    switch(month) {
        case 1:
            return @"January";
            break;
        case 2:
            return @"February";
            break;
        case 3:
            return @"March";
            break;
        case 4:
            return @"April";
            break;
        case 5:
            return @"May";
            break;
        case 6:
            return @"June";
            break;
        case 7:
            return @"July";
            break;
        case 8:
            return @"August";
            break;
        case 9:
            return @"September";
            break;
        case 10:
            return @"October";
            break;
        case 11:
            return @"November";
            break;
        case 12:
            return @"December";
            break;
        default:
            break;
    }
    return @"";
}

+ (NSString *)qpx_stringWithDate:(NSDate *)date format:(NSString *)format {
    return [date qpx_stringWithFormat:format];
}

- (NSString *)qpx_stringWithFormat:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:format];
    
    NSString *retStr = [outputFormatter stringFromDate:self];
    
    return retStr;
}

+ (NSDate *)qpx_dateWithString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:format];
    
    NSDate *date = [inputFormatter dateFromString:string];
    
    return date;
}
+ (NSDate *)qpx_dateWithLocaleEN_USString:(NSString *)string format:(NSString *)format {
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    outputFormatter.locale=[[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    [outputFormatter setDateFormat:format];
    NSDate* inputDate = [outputFormatter dateFromString:string];
    return inputDate;
}
+ (NSString *)qpx_dateFormatterWithInputDateString:(NSString *)dateString
                      inputDateStringFormatter:(NSString *)inputDateStringFormatter
                     outputDateStringFormatter:(NSString *)outputDateStringFormatter {
    
    NSParameterAssert(dateString);
    NSParameterAssert(inputDateStringFormatter);
    NSParameterAssert(outputDateStringFormatter);
    
    NSString *outputString = nil;
    
    NSDateFormatter *inputFormatter  = [[NSDateFormatter alloc] init] ;
    inputFormatter.dateFormat        = inputDateStringFormatter;
    
    NSDate *date = [inputFormatter dateFromString:dateString];
    
    if (date) {
        
        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
        outputFormatter.dateFormat       = outputDateStringFormatter;
        outputString                     = [outputFormatter stringFromDate:date];
    }
    
    return outputString;
}


- (NSUInteger)qpx_daysInMonth:(NSUInteger)month {
    return [NSDate qpx_daysInMonth:self month:month];
}

+ (NSUInteger)qpx_daysInMonth:(NSDate *)date month:(NSUInteger)month {
    switch (month) {
        case 1: case 3: case 5: case 7: case 8: case 10: case 12:
            return 31;
        case 2:
            return [date qpx_isLeapYear] ? 29 : 28;
    }
    return 30;
}

- (NSUInteger)qpx_daysInMonth {
    return [NSDate qpx_daysInMonth:self];
}

+ (NSUInteger)qpx_daysInMonth:(NSDate *)date {
    return [self qpx_daysInMonth:date month:[date qpx_getMonth]];
}

- (NSString *)qpx_timeInfo {
    return [NSDate qpx_timeInfoWithDate:self];
}

+ (NSString *)qpx_timeInfoWithDate:(NSDate *)date {
    return [self qpx_timeInfoWithDateString:[self qpx_stringWithDate:date format:[self qpx_ymdHmsFormat]]];
}

+ (NSString *)qpx_timeInfoWithDateString:(NSString *)dateString {
    NSDate *date = [self qpx_dateWithString:dateString format:[self qpx_ymdHmsFormat]];
    
    NSDate *curDate = [NSDate date];
    NSTimeInterval time = -[date timeIntervalSinceDate:curDate];
    
    int month = (int)([curDate qpx_getMonth] - [date qpx_getMonth]);
    int year = (int)([curDate qpx_getYear] - [date qpx_getYear]);
    int day = (int)([curDate qpx_getDay] - [date qpx_getDay]);
    
    NSTimeInterval retTime = 1.0;
    if (time < 3600) { // 小于一小时
        retTime = time / 60;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f分钟前", retTime];
    } else if (time < 3600 * 24) { // 小于一天，也就是今天
        retTime = time / 3600;
        retTime = retTime <= 0.0 ? 1.0 : retTime;
        return [NSString stringWithFormat:@"%.0f小时前", retTime];
    } else if (time < 3600 * 24 * 2) {
        return @"昨天";
    }
    // 第一个条件是同年，且相隔时间在一个月内
    // 第二个条件是隔年，对于隔年，只能是去年12月与今年1月这种情况
    else if ((abs(year) == 0 && abs(month) <= 1)
             || (abs(year) == 1 && [curDate qpx_getMonth] == 1 && [date qpx_getMonth] == 12)) {
        int retDay = 0;
        if (year == 0) { // 同年
            if (month == 0) { // 同月
                retDay = day;
            }
        }
        
        if (retDay <= 0) {
            // 获取发布日期中，该月有多少天
            int totalDays = (int)[self qpx_daysInMonth:date month:[date qpx_getMonth]];
            
            // 当前天数 + （发布日期月中的总天数-发布日期月中发布日，即等于距离今天的天数）
            retDay = (int)[curDate qpx_getDay] + (totalDays - (int)[date qpx_getDay]);
        }
        
        return [NSString stringWithFormat:@"%d天前", (abs)(retDay)];
    } else  {
        if (abs(year) <= 1) {
            if (year == 0) { // 同年
                return [NSString stringWithFormat:@"%d个月前", abs(month)];
            }
            
            // 隔年
            int month = (int)[curDate qpx_getMonth];
            int preMonth = (int)[date qpx_getMonth];
            if (month == 12 && preMonth == 12) {// 隔年，但同月，就作为满一年来计算
                return @"1年前";
            }
            return [NSString stringWithFormat:@"%d个月前", (abs)(12 - preMonth + month)];
        }
        
        return [NSString stringWithFormat:@"%d年前", abs(year)];
    }
    
    return @"1小时前";
}

- (NSString *)qpx_ymdFormat {
    return [NSDate qpx_ymdFormat];
}

- (NSString *)qpx_hmsFormat {
    return [NSDate qpx_hmsFormat];
}

- (NSString *)qpx_ymdHmsFormat {
    return [NSDate qpx_ymdHmsFormat];
}

+ (NSString *)qpx_ymdFormat {
    return @"yyyy-MM-dd";
}

+ (NSString *)qpx_hmsFormat {
    return @"HH:mm:ss";
}

+ (NSString *)qpx_ymdHmsFormat {
    return [NSString stringWithFormat:@"%@ %@", [self qpx_ymdFormat], [self qpx_hmsFormat]];
}

- (NSDate *)qpx_offsetYears:(int)numYears {
    return [NSDate qpx_offsetYears:numYears fromDate:self];
}

+ (NSDate *)qpx_offsetYears:(int)numYears fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setYear:numYears];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)qpx_offsetMonths:(int)numMonths {
    return [NSDate qpx_offsetMonths:numMonths fromDate:self];
}

+ (NSDate *)qpx_offsetMonths:(int)numMonths fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setMonth:numMonths];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)qpx_offsetDays:(int)numDays {
    return [NSDate qpx_offsetDays:numDays fromDate:self];
}

+ (NSDate *)qpx_offsetDays:(int)numDays fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setDay:numDays];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

- (NSDate *)qpx_offsetHours:(int)hours {
    return [NSDate qpx_offsetHours:hours fromDate:self];
}

+ (NSDate *)qpx_offsetHours:(int)numHours fromDate:(NSDate *)fromDate {
    if (fromDate == nil) {
        return nil;
    }
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED >= __IPHONE_8_0
    // NSDayCalendarUnit
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
#else
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
#endif
    
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    [offsetComponents setHour:numHours];
    
    return [gregorian dateByAddingComponents:offsetComponents
                                      toDate:fromDate
                                     options:0];
}

+(NSString *)qpx_timeToTimeStamps
{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYYMMddHHmm"];
    NSString *  timeStamps=[dateformatter stringFromDate:senddate];
    return timeStamps;
}

+(NSString *)qpx_getNewTimeFormat:(NSString *)format
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:currentDate];
}


+(int)qpx_compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
    NSComparisonResult result = [dateA compare:dateB];
    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
    if (result == NSOrderedDescending) {
        //NSLog(@"Date1  is in the future");
        return 1;
    }
    else if (result == NSOrderedAscending){
        //NSLog(@"Date1 is in the past");
        return -1;
    }
    //NSLog(@"Both dates are the same");
    return 0;
    
}



@end
