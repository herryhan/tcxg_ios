//
//  GoodsOrderModel.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderModel.h"

@implementation GoodsOrderModel

+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName substringFromIndex:6];
}

+ (NSDictionary *)mj_objectClassInArray{
    return @{@"order_products":@"GoodsProducts"};
}

@end

@implementation GoodsProducts

+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName{
    return [propertyName substringFromIndex:6];
}

@end
