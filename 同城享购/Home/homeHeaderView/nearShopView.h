//
//  nearShopView.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface nearShopView : UIView

@property (weak, nonatomic) IBOutlet UIButton *sumButton;
@property (weak, nonatomic) IBOutlet UIButton *topSaleButton;
@property (weak, nonatomic) IBOutlet UIButton *qunlityButton;
@property (weak, nonatomic) IBOutlet UIButton *distanceButton;

@property (nonatomic, strong) void(^sum)(NSInteger index);
@property (nonatomic, strong) void(^topSale)(NSInteger index);
@property (nonatomic, strong) void(^qunlity)(NSInteger index);
@property (nonatomic, strong) void(^distance)(NSInteger index);

@property NSInteger indexTag;

@end
