//
//  SecCateModel.m
//  同城享购
//
//  Created by Charles on 2018/2/25.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "SecCateModel.h"

@implementation SecCateModel

+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName substringFromIndex:5];
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"cate_list":@"SecCateSecModel"};
}

@end

@implementation SecCateSecModel
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName substringFromIndex:5];
}
@end
