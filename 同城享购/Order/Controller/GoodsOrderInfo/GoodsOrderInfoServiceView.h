//
//  GoodsOrderInfoServiceView.h
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsOrderInfoServiceView : UIView
//** model */
@property (nonatomic,strong) NSDictionary * model;
@property (nonatomic,copy) void(^GoodsOrderInfoServiceButtonAction)(void);
@end
