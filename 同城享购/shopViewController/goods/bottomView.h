//
//  bottomView.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/15.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BadgeView.h"
#import "cartView.h"
#import "overLayView.h"

@interface bottomView : UIView

@property (weak, nonatomic) IBOutlet UIView *bottomBgView;
@property (weak, nonatomic) IBOutlet UILabel *sumPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *sendFeeLabel;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;

@property (nonatomic,strong) BadgeView *badgeView;
@property (nonatomic,strong) overLayView *overLayView;//遮照
@property (nonatomic,strong) cartView *goodsCartView;
@property (nonatomic,assign) BOOL open;
@property (nonatomic,strong)   UIView *parentView;//背景图层
@property (nonatomic,assign) NSInteger badgeValue;

@property (nonatomic,strong) void(^showCartView)(BOOL isShow);

- (void)shoppCartClick;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cartBtnConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *totalPriceConstraint;

- (void)configDataWith:(NSDictionary *)dic;

@end
