//
//  GoodsOrderInfoItemView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoItemView.h"

@interface GoodsOrderInfoItemView()
{
    UILabel *_mLeftLabel;
    UILabel *_mRightLabel;
}
@end

@implementation GoodsOrderInfoItemView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _mLeftLabel = [UILabel new];
    _mRightLabel = [UILabel new];
    [self sd_addSubviews:@[_mLeftLabel,_mRightLabel]];
    
    _mLeftLabel.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 0);
    _mLeftLabel.font = Font(14);
    _mLeftLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mLeftLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _mRightLabel.sd_layout
        .rightSpaceToView(self, 0)
        .topEqualToView(_mLeftLabel);
    _mRightLabel.font = Font(14);
    _mRightLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mRightLabel setSingleLineAutoResizeWithMaxWidth:200];
}

- (void)setModel:(NSDictionary *)model{
    _mLeftLabel.text = [model objectForKey:@"key"];
    _mRightLabel.text = [model objectForKey:@"value"];
    [self setupAutoHeightWithBottomView:_mRightLabel bottomMargin:0];
}

@end
