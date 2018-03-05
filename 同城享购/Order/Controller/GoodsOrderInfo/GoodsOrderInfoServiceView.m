//
//  GoodsOrderInfoServiceView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoServiceView.h"
#import "GoodsInfoRiderItemView.h"

@interface GoodsOrderInfoServiceView()
{
    GoodsInfoRiderItemView *_mOrderIdView;
    GoodsInfoRiderItemView *_mHopeTimeView;
    GoodsInfoRiderItemView *_mAddressView;
    UIButton *_mCallButton;
}
@end

@implementation GoodsOrderInfoServiceView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = PX_COLOR_HEX(@"ffffff");
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    _mOrderIdView = [GoodsInfoRiderItemView new];
    _mHopeTimeView = [GoodsInfoRiderItemView new];
    _mAddressView = [GoodsInfoRiderItemView new];
    _mCallButton = [UIButton new];
    [self sd_addSubviews:@[_mOrderIdView,_mHopeTimeView,_mAddressView,_mCallButton]];
    
    CGFloat padding = 15.0f;
    CGFloat margin = 10.0f;
    
    _mOrderIdView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(self, padding);
    
    _mHopeTimeView.sd_layout
        .leftEqualToView(_mOrderIdView)
        .rightEqualToView(_mOrderIdView)
        .topSpaceToView(_mOrderIdView, margin);
    
    _mAddressView.sd_layout
        .leftEqualToView(_mOrderIdView)
        .rightEqualToView(_mOrderIdView)
        .topSpaceToView(_mHopeTimeView, margin);
    
    _mCallButton.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(_mAddressView, margin)
    .heightIs(40);
    [_mCallButton setTitleColor:PX_COLOR_HEX(@"666666") forState:UIControlStateNormal];
    [_mCallButton setTitle:@"客服电话" forState:UIControlStateNormal];
    [_mCallButton setImage:PX_IMAGE_NAMED(@"address") forState:UIControlStateNormal];
    _mCallButton.titleLabel.font = Font(15);
    
    __weak typeof(_mCallButton) weakButton = _mCallButton;
    _mCallButton.didFinishAutoLayoutBlock = ^(CGRect frame) {
        [weakButton qpx_buttonImageAndTitle:UIButtonLeftImageTitle spacing:10];
    };
    self.GoodsOrderInfoServiceButtonAction?self.GoodsOrderInfoServiceButtonAction():nil;
}

- (void)setModel:(NSDictionary *)model{
    _mOrderIdView.model = [NSDictionary dictionaryWithObjects:@[@"订单号",@"139123456789012345678"] forKeys:@[@"key",@"value"]];
    _mHopeTimeView.model = [NSDictionary dictionaryWithObjects:@[@"期望时间",@"2018-03-01 12：00"] forKeys:@[@"key",@"value"]];
    _mAddressView.model = [NSDictionary dictionaryWithObjects:@[@"配送地址",@"奥巴马 13987654321\n苏宁生活广场写字楼-西北门13楼"] forKeys:@[@"key",@"value"]];
    [self setupAutoHeightWithBottomView:_mCallButton bottomMargin:10];
}

@end
