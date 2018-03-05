//
//  MyAddressCell.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "MyAddressCell.h"

@interface MyAddressCell()
{
    UILabel *_mNameLabel;
    UILabel *_mAddressLabel;
    UIButton *_mEditeButton;
    UIButton *_mDeleteButton;
}
@end

@implementation MyAddressCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    _mNameLabel = [UILabel new];
    _mAddressLabel = [UILabel new];
    _mEditeButton = [UIButton new];
    _mDeleteButton = [UIButton new];
    NSArray *views = [NSArray arrayWithObjects:_mDeleteButton,_mEditeButton,_mNameLabel,_mAddressLabel, nil];
    [self.contentView sd_addSubviews:views];
    
    UIView *view = self.contentView;
    
    CGFloat padding = 15.0f;
    CGFloat margin = 10.0f;
    
    _mDeleteButton.sd_layout
        .rightSpaceToView(view, padding)
        .centerYEqualToView(view)
        .widthIs(40)
        .heightEqualToWidth();
    [_mDeleteButton setBackgroundImage:[UIImage imageWithColor:PX_RANDOM_COLOR] forState:UIControlStateNormal];
    
    _mEditeButton.sd_layout
        .rightSpaceToView(_mDeleteButton, margin)
        .topEqualToView(_mDeleteButton)
        .bottomEqualToView(_mDeleteButton)
        .widthEqualToHeight();
    [_mEditeButton setBackgroundImage:[UIImage imageWithColor:PX_RANDOM_COLOR] forState:UIControlStateNormal];
    
    _mNameLabel.sd_layout
        .leftSpaceToView(view, padding)
        .topSpaceToView(view, margin)
        .maxWidthIs(PX_SCREEN_WIDTH-_mEditeButton.mj_x-margin)
        .autoHeightRatio(0);
    _mNameLabel.font = Font(15);
    _mNameLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _mAddressLabel.sd_layout
        .leftEqualToView(_mNameLabel)
        .topSpaceToView(_mNameLabel, 0)
        .rightSpaceToView(_mEditeButton, margin);
    _mAddressLabel.font = Font(15);
    _mAddressLabel.textColor = PX_COLOR_HEX(@"333333");
    [_mAddressLabel setMaxNumberOfLinesToShow:0];
    
    __weak typeof(self) weakSelf = self;
    [_mDeleteButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (weakSelf.delegate) {
            [weakSelf.delegate addressCell:weakSelf buttonClickType:MyAddressCellButtonType_Del];
        }
    }];
    
    [_mEditeButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        if (weakSelf.delegate) {
            [weakSelf.delegate addressCell:weakSelf buttonClickType:MyAddressCellButtonTyp_Edite];
        }
    }];
}

- (void)setModel:(MyAddressModel *)model{
    _model = model;
    _mNameLabel.text = [NSString stringWithFormat:@"%@\t%@",model.mine_name,model.mine_tel];
    _mAddressLabel.text = [model.mine_address stringByAppendingString:model.mine_number];
    [self setupAutoHeightWithBottomView:_mAddressLabel bottomMargin:10];
}

@end
