//
//  GoodsOrderInfoShopView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoShopView.h"
#import "GoodsOrderInfoShopImageView.h"
#import "GoodsOrderInfoItemView.h"

@interface GoodsOrderInfoShopView()
{
    UILabel *_mShopNameLabel;
    UIScrollView *_mScrollView;
    UILabel *_mNumWeightLabel;
    PXSingleLineView *_mTopLineView;
    UIView *_mPriceView;
    PXSingleLineView *_mMidLineView;
    UIView *_mDiscountView;
    PXSingleLineView *_mBottomLineView;
    UIButton *_mCallButton;
}
@end

@implementation GoodsOrderInfoShopView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = PX_COLOR_HEX(@"ffffff");
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _mShopNameLabel = [UILabel new];
    _mScrollView = [UIScrollView new];
    _mNumWeightLabel = [UILabel new];
    _mTopLineView = [PXSingleLineView new];
    _mPriceView = [UIView new];
    _mMidLineView = [PXSingleLineView new];
    _mDiscountView = [UIView new];
    _mBottomLineView = [PXSingleLineView new];
    _mCallButton = [UIButton new];
    NSArray *views = [NSArray arrayWithObjects:_mShopNameLabel,_mScrollView,_mNumWeightLabel,_mTopLineView,_mPriceView,_mMidLineView,_mDiscountView,_mBottomLineView,_mCallButton, nil];
    [self sd_addSubviews:views];
    
    CGFloat padding = 15.0f;
    CGFloat margin = 10.0f;
    
    _mShopNameLabel.sd_layout
        .leftSpaceToView(self, padding)
        .topSpaceToView(self, padding)
        .rightSpaceToView(self, padding);
    _mShopNameLabel.font = Font(17);
    _mShopNameLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mShopNameLabel setMaxNumberOfLinesToShow:0];
    
    _mScrollView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(_mShopNameLabel, padding)
        .heightIs(60);
    _mScrollView.bounces = NO;
    [_mScrollView setShowsHorizontalScrollIndicator:NO];
    
    _mNumWeightLabel.sd_layout
        .leftSpaceToView(self, padding)
        .topSpaceToView(_mScrollView, margin)
        .autoHeightRatio(0);
    _mNumWeightLabel.font = Font(13);
    _mNumWeightLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mNumWeightLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _mTopLineView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(_mNumWeightLabel, margin)
        .heightIs(.8f);
    
    _mPriceView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(_mTopLineView, margin);
    
    _mMidLineView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .heightIs(.8f)
        .topSpaceToView(_mPriceView, margin);
    
    _mDiscountView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(_mMidLineView, margin);
    
    _mBottomLineView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(_mDiscountView, margin)
        .heightIs(.8f);
    
    _mCallButton.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(_mBottomLineView, margin)
        .heightIs(40);
    [_mCallButton setTitleColor:PX_COLOR_HEX(@"666666") forState:UIControlStateNormal];
    [_mCallButton setTitle:@"商家电话" forState:UIControlStateNormal];
    [_mCallButton setImage:PX_IMAGE_NAMED(@"address") forState:UIControlStateNormal];
    _mCallButton.titleLabel.font = Font(15);
    
    __weak typeof(_mCallButton) weakButton = _mCallButton;
    _mCallButton.didFinishAutoLayoutBlock = ^(CGRect frame) {
        [weakButton qpx_buttonImageAndTitle:UIButtonLeftImageTitle spacing:10];
    };
    QPXWeak_Self(self);
    [_mCallButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        weakself.GoodsOrderInfoShopButtonAction?weakself.GoodsOrderInfoShopButtonAction():nil;
    }];
}

- (void)setModel:(GoodsOrderInfoModel *)model{
    
    _mShopNameLabel.text = model.model_shopName;
    UIView *lastView = nil;
    for (GoodsOrderInfoProducts *product in model.model_products) {
        GoodsOrderInfoShopImageView *view = [GoodsOrderInfoShopImageView new];
        [_mScrollView addSubview:view];
        view.sd_layout
        .leftSpaceToView(lastView, lastView==nil?0:10)
            .topSpaceToView(_mScrollView, 0)
            .bottomSpaceToView(_mScrollView, 0)
            .widthEqualToHeight();
        lastView = view;
        view.sd_cornerRadius = @(5);
        [view sd_setImageWithURL:[NSURL URLWithString:product.model_logo] placeholderImage:nil];
        view.num = [NSString stringWithFormat:@"%zd",product.model_count];
    }
    
    _mNumWeightLabel.text = [NSString stringWithFormat:@"共%zd件，%.2fkg",model.model_count,model.model_weight];//@"共1件，0.05kg";
    
    NSArray *priceModel = [NSArray arrayWithObjects:
                           [NSDictionary dictionaryWithObjects:@[@"商品金额",[NSString stringWithFormat:@"￥%.2f",model.model_money]] forKeys:@[@"key",@"value"]],
                           [NSDictionary dictionaryWithObjects:@[@"配送费",[NSString stringWithFormat:@"￥%.2f",model.model_fee]] forKeys:@[@"key",@"value"]], nil];
    NSArray *discountModel = [NSArray arrayWithObjects:
                              [NSDictionary dictionaryWithObjects:@[@"应付金额",[NSString stringWithFormat:@"￥%.2f",model.model_payMoney]] forKeys:@[@"key",@"value"]],
                              [NSDictionary dictionaryWithObjects:@[@"优惠金额",[NSString stringWithFormat:@"￥%.2f",model.model_discountMoney]] forKeys:@[@"key",@"value"]], nil];
    UIView *priceTemp = nil;
    UIView *discountTemp = nil;
    for (NSInteger index = 0 ; index < 2; index ++) {
        //mPriceView
        GoodsOrderInfoItemView *priceView = [GoodsOrderInfoItemView new];
        [_mPriceView addSubview:priceView];
        priceView.sd_layout
            .leftSpaceToView(_mPriceView, 0)
            .rightSpaceToView(_mPriceView, 0)
            .topSpaceToView(priceTemp, 0);
        priceView.model = [priceModel objectAtIndex:index];
        priceTemp = priceView;
        [_mPriceView setupAutoHeightWithBottomView:priceTemp bottomMargin:0];
        
        //mDiscountView
        GoodsOrderInfoItemView *discountView = [GoodsOrderInfoItemView new];
        [_mDiscountView addSubview:discountView];
        discountView.sd_layout
            .leftSpaceToView(_mDiscountView, 0)
            .rightSpaceToView(_mDiscountView, 0)
            .topSpaceToView(discountTemp, 0);
        discountView.model = [discountModel objectAtIndex:index];
        discountTemp = discountView;
        [_mDiscountView setupAutoHeightWithBottomView:discountTemp bottomMargin:0];
    }
    
    [self setupAutoHeightWithBottomView:_mCallButton bottomMargin:10];
    
}

@end
