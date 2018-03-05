//
//  NSString+PX.m
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "NSString+PX.h"

@implementation NSString (PX)

- (BOOL)px_checkPhoneNum{
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:self];
}

+ (NSString *)transform:(NSString *)chinese{
    //将NSString装换成NSMutableString
    NSMutableString *pinyin = [chinese mutableCopy];
    
    //将汉字转换为拼音(带音标)
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    PXDALog(@"%@", pinyin);
    
    //去掉拼音的音标
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    PXDALog(@"%@", pinyin);
    
    //返回最近结果
    return pinyin;
    
}

@end
