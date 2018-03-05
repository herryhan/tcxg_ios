//
//  GoodsInfoRiderItemView.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsInfoRiderItemView.h"

@interface GoodsInfoRiderItemView()
{
    UILabel *_mNameLabel;
    UILabel *_mContentLabel;
}
@end

@implementation GoodsInfoRiderItemView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _mNameLabel = [UILabel new];
    _mContentLabel = [UILabel new];
    [self sd_addSubviews:@[_mNameLabel,_mContentLabel]];
    
    _mNameLabel.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .minWidthIs(60);
    _mNameLabel.font = Font(14);
    _mNameLabel.textColor = PX_COLOR_HEX(@"666666");
    [_mNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _mContentLabel.sd_layout
        .leftSpaceToView(_mNameLabel, 10)
        .topEqualToView(_mNameLabel)
        .rightSpaceToView(self, 0)
        .autoHeightRatio(0);
    _mContentLabel.numberOfLines = 0;
    _mContentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _mContentLabel.font = Font(14);
    _mContentLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mContentLabel setMaxNumberOfLinesToShow:0];
}

- (void)setModel:(NSDictionary *)model{
    _mNameLabel.text = [model objectForKey:@"key"];
    _mContentLabel.text = [model objectForKey:@"value"];
    [self setupAutoHeightWithBottomView:_mContentLabel bottomMargin:0];
}

@end
