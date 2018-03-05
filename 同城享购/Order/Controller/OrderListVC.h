//
//  OrderListVC.h
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "baseViewController.h"

typedef NS_ENUM(NSUInteger,OrderListVCType) {
    OrderListVCType_GoodsAll = 0,//商品订单-全部
    OrderListVCType_GoodsDelivery,//商品订单-配送中
    OrderListVCType_GoodsComment,//商品订单-待评价
    OrderListVCType_GoodsRefund,//商品订单-退款中
};

@interface OrderListVC : baseViewController

//** 页面内容的类型 */
@property (nonatomic,assign) OrderListVCType  type;

@end
