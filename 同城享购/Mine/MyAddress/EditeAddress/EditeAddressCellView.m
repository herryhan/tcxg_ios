//
//  EditeAddressCellView.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "EditeAddressCellView.h"

@interface EditeAddressCellView()
{
    UILabel *_mNameLabel;
}
@end

@implementation EditeAddressCellView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
    self.backgroundColor = PX_COLOR_HEX(@"ffffff");
    _mNameLabel = [UILabel new];
    [self addSubview:_mNameLabel];
    _mNameLabel.sd_layout
        .leftSpaceToView(self, 15)
        .topSpaceToView(self, 10)
        .bottomSpaceToView(self, 10);
    _mNameLabel.font = Font(15);
    _mNameLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
}

- (void)setMinWidth:(CGFloat)minWidth{
    _mNameLabel.sd_layout.minWidthIs(minWidth);
    [_mNameLabel updateLayout];
}

- (CGFloat)minWidth{
    return _mNameLabel.width_sd;
}

- (void)setNameText:(NSString *)nameText{
    _mNameLabel.text = nameText;
}

- (UITextField *)mTextField{
    return PX_LAZY(_mTextField, ({
        UITextField *view = [UITextField new];
        [self addSubview:view];
        view.font = Font(15);
        view.textColor = PX_COLOR_HEX(@"333333");
        view.sd_layout
            .leftSpaceToView(_mNameLabel, 0)
            .rightSpaceToView(self, 15)
            .topEqualToView(_mNameLabel)
            .bottomEqualToView(_mNameLabel);
        view;
    }));
}

- (EditeAddressMapView *)mMapView{
    return PX_LAZY(_mMapView, ({
        EditeAddressMapView *view = [EditeAddressMapView new];
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(_mNameLabel, 0)
            .rightSpaceToView(self, 15)
            .topEqualToView(_mNameLabel)
            .bottomEqualToView(_mNameLabel);
        __weak typeof(self) weakSelf = self;
        __weak typeof(view) weakView = view;
        self.userInteractionEnabled = YES;
        view.userInteractionEnabled = YES;
        _mNameLabel.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            weakSelf.delegate?[weakSelf.delegate editeAddressCellView:weakSelf clickMapView:weakView]:nil;
        }]];
        view;
    }));
}

@end
