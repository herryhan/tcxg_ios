//
//  GoodsOrderInfoRiderView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoRiderView.h"
#import "GoodsInfoRiderItemView.h"

@interface GoodsOrderInfoRiderView()
{
    GoodsInfoRiderItemView *_mRiderView;
    UIButton *_mCallButton;
}
@end

@implementation GoodsOrderInfoRiderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = PX_COLOR_HEX(@"ffffff");
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    _mRiderView = [GoodsInfoRiderItemView new];
    _mCallButton = [UIButton new];
    [self sd_addSubviews:@[_mRiderView,_mCallButton]];
    
    CGFloat padding = 15.0f;
    CGFloat margin = 10.0f;
    
    _mRiderView.sd_layout
        .leftSpaceToView(self, padding)
        .topSpaceToView(self, padding)
        .rightSpaceToView(self, padding);
    
    _mCallButton.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(_mRiderView, margin)
        .heightIs(40);
    [_mCallButton setTitleColor:PX_COLOR_HEX(@"666666") forState:UIControlStateNormal];
    [_mCallButton setTitle:@"骑手电话" forState:UIControlStateNormal];
    [_mCallButton setImage:PX_IMAGE_NAMED(@"address") forState:UIControlStateNormal];
    _mCallButton.titleLabel.font = Font(15);
    
    __weak typeof(_mCallButton) weakButton = _mCallButton;
    _mCallButton.didFinishAutoLayoutBlock = ^(CGRect frame) {
        [weakButton qpx_buttonImageAndTitle:UIButtonLeftImageTitle spacing:10];
    };
    self.GoodsOrderInfoRiderButtonAction?self.GoodsOrderInfoRiderButtonAction():nil;
}

- (void)setModel:(NSDictionary *)model{
    _mRiderView.model = [NSDictionary dictionaryWithObjects:@[@"配送骑手",@"李世民\n13912345678"] forKeys:@[@"key",@"value"]];
    [self setupAutoHeightWithBottomView:_mCallButton bottomMargin:10];
}

@end
