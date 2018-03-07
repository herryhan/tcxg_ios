//
//  GoodsOrderInfoRiderView.h
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsOrderInfoRiderView : UIView

//** mdoel */
@property (nonatomic,strong) NSString * model;
@property (nonatomic,copy) void(^GoodsOrderInfoRiderButtonAction)(void);
@end
