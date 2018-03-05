//
//  SameCityOrderListVC.h
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "baseViewController.h"

typedef NS_ENUM(NSUInteger,SameCityOrderType) {
    OrderListVCType_SameCityAll = 0,//同城订单-全部
    OrderListVCType_SameCityDelivery,//同城订单-配送中
    OrderListVCType_SameCityComment,//同城订单-待评价
    OrderListVCType_SameCityRefund//同城订单-退款中
};

@interface SameCityOrderListVC : baseViewController
/**
 * type
 */
@property (nonatomic,assign) SameCityOrderType  type;
@end
