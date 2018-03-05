//
//  CitySendBottomView.m
//  同城享购
//
//  Created by Charles on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CitySendBottomView.h"

@implementation CitySendBottomView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    UIButton *button = [[UIButton alloc] init];
    UILabel *label = [[UILabel alloc] init];
    [self sd_addSubviews:@[button,label]];
    button.sd_layout
        .rightSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
    [button setTitle:@"提交订单" forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"999999")] forState:UIControlStateDisabled];
    [button setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"5e038f")] forState:UIControlStateNormal];
    [button setupAutoSizeWithHorizontalPadding:20 buttonHeight:50];
    button.enabled = NO;
    
    label.sd_layout
        .leftSpaceToView(self, 15)
        .rightSpaceToView(button, 10)
        .topSpaceToView(self, 0)
        .bottomSpaceToView(self, 0);
    label.isAttributedContent = YES;
    [label setMaxNumberOfLinesToShow:0];
    label.textColor = PX_COLOR_HEX(@"72fe3d");
    label.font = Font(15);
    label.text = @"￥0.00";
    
    self.mLabel = label;
    self.confirmButton = button;
    
}

@end
