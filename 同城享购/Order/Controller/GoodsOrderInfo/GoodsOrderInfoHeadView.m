//
//  GoodsOrderInfoHeadView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoHeadView.h"
#import "GoodsOrderInfoProgressView.h"

@interface GoodsOrderInfoHeadView()
{
    UILabel *_mStateLabel;
    GoodsOrderInfoProgressView *_mProgressView;
    UIButton *_mCommentButton;
}
@end

@implementation GoodsOrderInfoHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = PX_COLOR_HEX(@"ffffff");
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _mStateLabel = [UILabel new];
    _mProgressView = [GoodsOrderInfoProgressView new];
    _mCommentButton = [UIButton new];
    [self sd_addSubviews:@[_mStateLabel,_mProgressView,_mCommentButton]];
    
    CGFloat padding = 15.0f;
    
    _mStateLabel.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(self, padding)
        .autoHeightRatio(0);
    _mStateLabel.textAlignment = NSTextAlignmentCenter;
    _mStateLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _mStateLabel.textColor = PX_COLOR_HEX(@"333333");
    
    _mProgressView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(_mStateLabel, padding)
        .heightIs(70);
    
    _mCommentButton.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(_mProgressView, padding);
    [_mCommentButton setTitle:@"评论订单" forState:UIControlStateNormal];
    _mCommentButton.backgroundColor = PX_COLOR_HEX(@"57e038");
    _mCommentButton.titleLabel.font = Font(15);
    _mCommentButton.sd_cornerRadius = @(5);
    [_mCommentButton setupAutoSizeWithHorizontalPadding:padding buttonHeight:35];
    
    __weak typeof(self) weakSelf = self;
    [_mCommentButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        weakSelf.GoodsOrderInfoHeadViewButtonAction?weakSelf.GoodsOrderInfoHeadViewButtonAction(sender):nil;
    }];
    
}

- (void)setModel:(GoodsOrderModel *)model{
    _mStateLabel.text = model.order_stateDes;
    _mProgressView.progress = 5;
    //如果已经评论，或者不需要评论的时候隐藏评论按钮
    //[_mCommentButton sd_clearAutoLayoutSettings];
    //_mCommentButton.hidden = YES;
    //[self setupAutoHeightWithBottomView:_mProgressView bottomMargin:15];
    //否则显示评论按钮
    [self setupAutoHeightWithBottomView:_mCommentButton bottomMargin:15];
    
}

@end
