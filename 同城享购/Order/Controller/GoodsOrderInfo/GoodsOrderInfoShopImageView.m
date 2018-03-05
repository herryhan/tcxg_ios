//
//  GoodsOrderInfoShopImageView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoShopImageView.h"

@interface GoodsOrderInfoShopImageView()
{
    UIView *_mBackView;
    UILabel *_mNumLabel;
}
@end

@implementation GoodsOrderInfoShopImageView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _mBackView = [UIView new];
    _mNumLabel = [UILabel new];
    [self addSubview:_mBackView];
    [_mBackView addSubview:_mNumLabel];
    
    _mBackView.sd_layout
        .leftSpaceToView(self, 0)
        .bottomSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(18);
    _mBackView.backgroundColor = [UIColor colorWithHexString:@"333333" alpha:.4];
    
    _mNumLabel.sd_layout
        .leftSpaceToView(_mBackView, 10)
        .rightSpaceToView(_mBackView, 10)
        .topSpaceToView(_mBackView, 0)
        .bottomSpaceToView(_mBackView, 0);
    _mNumLabel.textColor = PX_COLOR_HEX(@"ffffff");
    _mNumLabel.textAlignment = NSTextAlignmentRight;
    _mNumLabel.font = Font(12);
}

- (void)setNum:(NSString *)num{
    _mNumLabel.text = [@"x" stringByAppendingString:num];
}

@end
