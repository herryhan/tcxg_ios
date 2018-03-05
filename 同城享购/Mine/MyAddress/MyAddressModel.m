//
//  MyAddressModel.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "MyAddressModel.h"
#import "NSString+PX.h"

@implementation MyAddressModel

+(id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName substringFromIndex:5];
}

- (void)mj_keyValuesDidFinishConvertingToObject{
    NSString *pinyin = [NSString transform:self.mine_name];
    self.mine_pinyin = [pinyin stringByReplacingOccurrencesOfString:@" " withString:@""];
}

@end
