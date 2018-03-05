//
//  EditeAddressSexSelectView.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "EditeAddressSexSelectView.h"

@interface EditeAddressSexSelectView()
{
    UIButton *_mManButton;
    UIButton *_mWomanButton;
}
@end

@implementation EditeAddressSexSelectView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    self.backgroundColor = PX_COLOR_HEX(@"ffffff");
    
    _mManButton = [UIButton new];
    _mWomanButton = [UIButton new];
    [self sd_addSubviews:@[_mManButton,_mWomanButton]];
    
    _mManButton.sd_layout
        .leftSpaceToView(self, 15)
        .topSpaceToView(self, 5)
        .bottomSpaceToView(self, 5)
        .widthIs(70);
    
    _mWomanButton.sd_layout
        .leftSpaceToView(_mManButton, 5)
        .topSpaceToView(self, 5)
        .bottomSpaceToView(self, 5)
        .widthIs(70);
    
    _mManButton.titleLabel.font = _mWomanButton.titleLabel.font = Font(15);
    [_mManButton setImage:PX_IMAGE_NAMED(@"select") forState:UIControlStateNormal];
    [_mManButton setImage:PX_IMAGE_NAMED(@"selected") forState:UIControlStateSelected];
    [_mManButton setTitle:@"先生" forState:UIControlStateNormal];
    [_mManButton setTitleColor:PX_COLOR_HEX(@"333333") forState:UIControlStateNormal];
    [_mWomanButton setImage:PX_IMAGE_NAMED(@"select") forState:UIControlStateNormal];
    [_mWomanButton setImage:PX_IMAGE_NAMED(@"selected") forState:UIControlStateSelected];
    [_mWomanButton setTitle:@"女士" forState:UIControlStateNormal];
    [_mWomanButton setTitleColor:PX_COLOR_HEX(@"333333") forState:UIControlStateNormal];
    
    _mManButton.selected = YES;
    _mWomanButton.selected = NO;
    
    __weak typeof(_mManButton) weakMan = _mManButton;
    _mManButton.didFinishAutoLayoutBlock = ^(CGRect frame) {
        [weakMan qpx_buttonImageAndTitle:UIButtonLeftImageTitle spacing:5];
    };
    
    __weak typeof(_mWomanButton) weakWoman = _mWomanButton;
    _mWomanButton.didFinishAutoLayoutBlock = ^(CGRect frame) {
        [weakWoman qpx_buttonImageAndTitle:UIButtonLeftImageTitle spacing:5];
    };
    
    __weak typeof(self) weakSelf = self;
    [_mManButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        sender.selected = YES;
        weakWoman.selected = NO;
        weakSelf.EditeAddressSexSelectBlock?weakSelf.EditeAddressSexSelectBlock(EditeAddressSex_Man):nil;
    }];
    
    [_mWomanButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(UIButton *sender) {
        sender.selected = YES;
        weakMan.selected = NO;
        weakSelf.EditeAddressSexSelectBlock?weakSelf.EditeAddressSexSelectBlock(EditeAddressSex_Woman):nil;
    }];
}

@end
