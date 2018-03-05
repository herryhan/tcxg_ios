//
//  homeModel.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface homeModel : NSObject

@property (nonatomic,copy) NSString *logo;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *singleDay;
@property (nonatomic,copy) NSNumber *score;
@property (nonatomic,copy) NSNumber *vip;
@property (nonatomic,copy) NSNumber *monthSells;
@property (nonatomic,copy) NSNumber *distance;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSArray *products;
@property (nonatomic,copy) NSArray *actives;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *notice;
@property (nonatomic,copy) NSNumber *minMoney;
@property (nonatomic,copy) NSNumber *fee;
@property (nonatomic,copy) NSNumber *avgTime;

@end
