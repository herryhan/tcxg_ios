//
//  GoodsOrderModel.h
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsProducts :NSObject
@property (nonatomic , assign) NSInteger order_id;
@property (nonatomic , assign) NSInteger order_count;
@property (nonatomic , copy  ) NSString  * order_name;
@property (nonatomic , assign) CGFloat   order_price;
@property (nonatomic , copy  ) NSString  * order_logo;

@end

@interface GoodsOrderModel : NSObject
@property (nonatomic , assign) NSInteger order_id;
@property (nonatomic , assign) NSInteger order_state;
@property (nonatomic , assign) CGFloat   order_money;
@property (nonatomic , assign) BOOL      order_canOk;
@property (nonatomic , copy  ) NSString  * order_shopLogo;
@property (nonatomic , copy  ) NSString  * order_time;
@property (nonatomic , assign) BOOL      order_canDel;
@property (nonatomic , assign) BOOL      order_canComment;
@property (nonatomic , assign) BOOL      order_canPay;
@property (nonatomic , assign) NSInteger order_commitState;
@property (nonatomic , assign) BOOL      order_canRefund;
@property (nonatomic , strong) NSArray<GoodsProducts  *> * order_products;
@property (nonatomic , copy  ) NSString  * order_shopName;
@property (nonatomic , assign) NSInteger order_refunState;
@property (nonatomic , copy  ) NSString  * order_stateDes;
@end
