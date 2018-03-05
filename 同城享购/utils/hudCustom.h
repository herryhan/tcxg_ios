//
//  hudCustom.h
//  ZTMall
//
//  Created by 庄园 on 16/12/21.
//  Copyright © 2016年 ztsm. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface hudCustom : NSObject



+ (BOOL)isValidateMobileNumber:(NSString *)mobileNum;

+ (NSString *)calculateOneDate:(NSString *)dateString1 To:(NSString *)dateString2;

@end
