//
//  SameCityOrderModel.h
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SameCityAddresse :NSObject
@property (nonatomic , copy  ) NSString  * order_address;
@property (nonatomic , copy  ) NSString  * order_title;
@property (nonatomic , copy  ) NSString  * order_la;
@property (nonatomic , copy  ) NSString  * order_lo;

@end

@interface SameCityOrderModel :NSObject
@property (nonatomic , assign) NSInteger        order_id;
@property (nonatomic , assign) NSInteger        order_state;
@property (nonatomic , assign) CGFloat          order_money;
@property (nonatomic , assign) NSInteger        order_back;
@property (nonatomic , strong) NSArray<SameCityAddresse *> * order_addresses;
@property (nonatomic , copy  ) NSString         * order_time;
@property (nonatomic , assign) NSInteger        order_cart;
@property (nonatomic , assign) NSInteger        order_refundState;
@property (nonatomic , assign) BOOL             order_canComment;
@property (nonatomic , assign) BOOL             order_canPay;
@property (nonatomic , assign) BOOL             order_canDel;
@property (nonatomic , assign) BOOL             order_canRefund;
@property (nonatomic , copy  ) NSString         * order_no;
@property (nonatomic , assign) NSInteger        order_carry;
@property (nonatomic , copy  ) NSString         * order_stateDes;

@end
