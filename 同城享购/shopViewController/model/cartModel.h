//
//  cartModel.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/17.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cartModel : NSObject

@property (nonatomic,assign)BOOL isStop;
@property (nonatomic,copy) NSString *money;
@property (nonatomic,copy) NSString *count;
@property (nonatomic,copy) NSString *weight;
@property (nonatomic,copy) NSString *releaseMoney;
@property (nonatomic,copy) NSString *minMoney;
@property (nonatomic,copy) NSArray *carts;

@end
