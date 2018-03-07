//
//  SameCityOrderTableCell.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "SameCityOrderTableCell.h"

@interface SameCityOrderTableCell()
{
    UILabel *_mTimeLabel;
    UILabel *_mStateLabel;
    UIImageView *_mImageView;
    UILabel *_mAddressLabel;
    UILabel *_mPriceLabel;
    
    PXSingleLineView *_mTopLineView;
    PXSingleLineView *_mVerticalLineView;
    PXSingleLineView *_mBottomLineView;
}
@end

@implementation SameCityOrderTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIView *view = self.contentView;
    
    _mTimeLabel        = [UILabel new];
    _mStateLabel       = [UILabel new];
    _mImageView        = [UIImageView new];
    _mAddressLabel     = [UILabel new];
    _mPriceLabel       = [UILabel new];
    _mTopLineView      = [PXSingleLineView new];
    _mBottomLineView   = [PXSingleLineView new];
    _mVerticalLineView = [PXSingleLineView new];
    
    NSArray *views = [NSArray arrayWithObjects:_mTimeLabel,_mStateLabel,_mTopLineView,_mImageView,_mVerticalLineView,_mAddressLabel,_mBottomLineView,_mPriceLabel, nil];
    [view sd_addSubviews:views];
    
    CGFloat padding = 15.0f;
    CGFloat margin = 10.0f;
    
    _mTimeLabel.sd_layout
        .leftSpaceToView(view, padding)
        .topSpaceToView(view, 5)
        .heightIs(30);
    _mTimeLabel.font = Font(13);
    _mTimeLabel.textColor = PX_COLOR_HEX(@"666666");
    [_mTimeLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _mStateLabel.sd_layout
        .rightSpaceToView(view, padding)
        .topEqualToView(_mTimeLabel)
        .heightRatioToView(_mTimeLabel, 1);
    _mStateLabel.font = Font(15);
    _mStateLabel.textColor = PX_COLOR_HEX(@"666666");
    [_mStateLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _mTopLineView.sd_layout
        .leftEqualToView(_mTimeLabel)
        .rightEqualToView(_mStateLabel)
        .topSpaceToView(_mTimeLabel, 0)
        .heightIs(.5f);
    
    _mImageView.sd_layout
        .leftEqualToView(_mTimeLabel)
        .topSpaceToView(_mTopLineView, margin)
        .widthIs(60)
        .heightIs(50);
    _mImageView.image = PX_IMAGE_NAMED(@"star2");
    _mImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    _mVerticalLineView.sd_layout
        .leftSpaceToView(_mImageView, margin)
        .topEqualToView(_mImageView)
        .bottomEqualToView(_mImageView)
        .widthIs(.5f);
    
    _mAddressLabel.sd_layout
        .leftSpaceToView(_mVerticalLineView, margin)
        .rightEqualToView(_mStateLabel)
        .topEqualToView(_mImageView)
        .bottomEqualToView(_mImageView);
    _mAddressLabel.font = Font(13);
    _mAddressLabel.textColor = PX_COLOR_HEX(@"666666");
    _mAddressLabel.numberOfLines = 0;
    _mAddressLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _mAddressLabel.isAttributedContent = YES;
    
    _mBottomLineView.sd_layout
        .leftEqualToView(_mTimeLabel)
        .rightEqualToView(_mTopLineView)
        .topSpaceToView(_mImageView, margin)
        .heightIs(.5f);
    
    _mPriceLabel.sd_layout
        .leftEqualToView(_mTopLineView)
        .topSpaceToView(_mBottomLineView, margin)
        .heightIs(35);
    _mPriceLabel.textColor = PX_COLOR_HEX(@"D5172B");
    _mPriceLabel.font = Font(15);
    _mPriceLabel.isAttributedContent = YES;
    [_mPriceLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

- (void)setModel:(SameCityOrderModel *)model
{
    _mTimeLabel.text = model.order_time;
    _mStateLabel.text = model.order_stateDes;
    SameCityAddresse *address = [model.order_addresses firstObject];
    _mAddressLabel.text = [NSString stringWithFormat:@"%@\n%@",address.order_title,address.order_address];
    NSString *price = [NSString stringWithFormat:@"%.2f",model.order_money];
    _mPriceLabel.text = [@"实付：￥"  stringByAppendingString:price];
    
    [self setupAutoHeightWithBottomView:_mPriceLabel bottomMargin:10];
}

@end
