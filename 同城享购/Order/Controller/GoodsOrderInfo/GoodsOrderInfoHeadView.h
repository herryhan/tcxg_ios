//
//  GoodsOrderInfoHeadView.h
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsOrderModel.h"

@interface GoodsOrderInfoHeadView : UIView

//** model */
@property (nonatomic,strong) GoodsOrderModel * model;

@property (nonatomic,copy) void(^GoodsOrderInfoHeadViewButtonAction)(UIButton *sender);

@end
