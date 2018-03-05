//
//  goodsInfoModel.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/14.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface goodsInfoModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSNumber *price;
@property (nonatomic,copy) NSString *logo;
@property (nonatomic,copy) NSNumber *id;
@property (nonatomic,copy) NSNumber *count;
@property (nonatomic,copy) NSArray *attrs;

@end
