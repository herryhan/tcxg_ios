//
//  OrderItemView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "OrderItemView.h"

@interface OrderItemView()
{
    UIImageView *_mLogImageView;
    UILabel *_mNameLabel;
    UILabel *_mPriceLabel;
}
@end

@implementation OrderItemView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    _mLogImageView = [UIImageView new];
    _mNameLabel = [UILabel new];
    _mPriceLabel = [UILabel new];
    [self sd_addSubviews:@[_mLogImageView,_mNameLabel,_mPriceLabel]];
    
    _mLogImageView.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 0)
        .widthIs(30)
        .heightEqualToWidth();
    
    _mNameLabel.sd_layout
        .leftSpaceToView(_mLogImageView, 5)
        .topEqualToView(_mLogImageView)
        .heightRatioToView(_mLogImageView, 1);
    _mNameLabel.font = Font(13);
    _mNameLabel.textColor = PX_COLOR_HEX(@"666666");
    [_mNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _mPriceLabel.sd_layout
        .leftSpaceToView(_mNameLabel, 5)
        .rightSpaceToView(self, 0)
        .topEqualToView(_mLogImageView)
        .heightRatioToView(_mLogImageView, 1);
    _mPriceLabel.textAlignment = NSTextAlignmentRight;
    _mPriceLabel.font = Font(13);
    _mPriceLabel.textColor = PX_COLOR_HEX(@"666666");
//    _mPriceLabel.isAttributedContent = YES;
    
}

- (void)setModel:(GoodsProducts *)model{
    [_mLogImageView sd_setImageWithURL:[NSURL URLWithString:model.order_logo] placeholderImage:nil];
    _mNameLabel.text = model.order_name;
    _mPriceLabel.text = [NSString stringWithFormat:@"%.2f x %ld",model.order_price,(long)model.order_count];
    [self setupAutoHeightWithBottomView:_mLogImageView bottomMargin:5];
}

- (NSMutableAttributedString *)getAttributeString:(NSString *)price num:(NSString *)num{
    NSString *string = [NSString stringWithFormat:@"%@ x %@",price,num];
    NSMutableAttributedString *syString = [[NSMutableAttributedString alloc] initWithString:string];
    
    return syString;
}
@end
