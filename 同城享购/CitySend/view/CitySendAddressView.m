//
//  CitySendAddressView.m
//  同城享购
//
//  Created by Charles on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CitySendAddressView.h"

@implementation CitySendAddressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self px_setupView];
    }
    return self;
}

- (void)px_setupView{
    self.nameLabel.text = @"请选择地址";
    self.nameLabel.numberOfLines = 0;
    self.nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    self.nameLabel.isAttributedContent = YES;
    self.topLineView.hidden = YES;
    self.botLineView.hidden = NO;
    self.tagImageView.image = [UIImage imageWithColor:PX_RANDOM_COLOR];
    __weak typeof(self) weakSelf = self;
    [self.adButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        PXDALog(@"%s ---- adBookBtn",__func__);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.delegate citySendAddressView:strongSelf didSelectedAtNameLabel:strongSelf.nameLabel clickAtView:strongSelf.adButton];
    }];
    [self.addBookBtn addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        PXDALog(@"%s ---- addBookBtn",__func__);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.delegate citySendAddressView:strongSelf didSelectedAtNameLabel:strongSelf.nameLabel clickAtView:strongSelf.addBookBtn];
    }];
    [self.nameLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        PXDALog(@"%s ---- nameLabel",__func__);
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.delegate citySendAddressView:strongSelf didSelectedAtNameLabel:strongSelf.nameLabel clickAtView:strongSelf.nameLabel];
    }]];
}

- (void)setTopLineShow:(BOOL)topLineShow{
    _topLineShow = topLineShow;
    self.topLineView.hidden = !topLineShow;
}

- (void)setBotLineShow:(BOOL)botLineShow{
    _botLineShow = botLineShow;
    self.botLineView.hidden = !botLineShow;
}

- (UIImageView *)tagImageView{
    if (!_tagImageView) {
        _tagImageView =({
            UIImageView *view = [[UIImageView alloc] init];
            [self addSubview:view];
            view.sd_layout
                .leftSpaceToView(self, 10)
                .centerYEqualToView(self)
                .widthIs(8)
                .heightEqualToWidth();
            view.image = [UIImage imageWithColor:PX_RANDOM_COLOR];
            view.sd_cornerRadiusFromHeightRatio = @(.5f);
            view;
        });
    }
    return _tagImageView;
}

- (UIView *)topLineView{
    if (!_topLineView) {
        _topLineView = ({
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            [self insertSubview:view belowSubview:self.tagImageView];
            view.sd_layout
                .centerXEqualToView(self.tagImageView)
                .widthIs(.8f)
                .topSpaceToView(self, 0)
                .heightRatioToView(self, .5f);
            view.backgroundColor = PX_COLOR_HEX(@"999999");
            view;
        });
    }
    return _topLineView;
}

- (UIView *)botLineView{
    if (!_botLineView) {
        _botLineView = ({
            UIView *view = [[UIView alloc] init];
            [self addSubview:view];
            [self insertSubview:view belowSubview:self.tagImageView];
            view.sd_layout
                .centerXEqualToView(self.tagImageView)
                .widthIs(.8f)
                .bottomSpaceToView(self, 0)
                .heightRatioToView(self, .5f);
            view.backgroundColor = PX_COLOR_HEX(@"999999");
            view;
        });
    }
    return _botLineView;
}

- (UIButton *)adButton{
    if (!_adButton) {
        _adButton = ({
            UIButton *view = [[UIButton alloc] init];
            [self addSubview:view];
            view.sd_layout
                .rightSpaceToView(self, 5)
                .topSpaceToView(self, 5)
                .bottomSpaceToView(self, 5)
                .widthEqualToHeight();
            [view setImage:[UIImage imageNamed:@"加号"] forState:UIControlStateNormal];
            view;
        });
    }
    return _adButton;
}

- (UIButton *)addBookBtn{
    if (!_addBookBtn) {
        _addBookBtn = ({
            UIButton *view = [[UIButton alloc] init];
            [self addSubview:view];
            view.sd_layout
                .rightSpaceToView(self.adButton, 5)
                .topEqualToView(self.adButton)
                .bottomEqualToView(self.adButton)
                .widthEqualToHeight();
            [view  setImage:[UIImage imageNamed:@"减号"] forState:UIControlStateNormal];
            view;
        });
    }
    return _addBookBtn;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *view = [[UILabel alloc] init];
            [self addSubview:view];
            view.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 23, 0, 75));
            view.textColor = PX_COLOR_HEX(@"333333");
            view.font = [UIFont systemFontOfSize:15];
            view.userInteractionEnabled = YES;
            view;
        });
    }
    return _nameLabel;
}

@end
