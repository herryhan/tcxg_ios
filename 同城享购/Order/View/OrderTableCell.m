//
//  OrderTableCell.m
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "OrderTableCell.h"

@interface OrderTableCell()
{
    UIImageView *_mAvatarImageView;//头像
    UILabel *_mShopNameLabel;//商店名称
    UILabel *_mCommentStateLabel;//评价状态
    UILabel *_mOrderStateLabel;//订单状态
    UILabel *_mPriceLabel;//价格
    UIButton *_mCommentOrderButton;//评论订单按钮
    UIButton *_mDeleteOrderButton;//删除订单按钮
    PXSingleLineView *_mTopLineView;//上划线
    PXSingleLineView *_mBottomLineView;//下划线
    OrderTableListView *_mOrderListView;//购买的商品
}
@end

@implementation OrderTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupView];
//        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupView{
    _mAvatarImageView    = [UIImageView new];
    _mShopNameLabel      = [UILabel new];
    _mCommentStateLabel  = [UILabel new];
    _mOrderStateLabel    = [UILabel new];
    _mPriceLabel         = [UILabel new];
    _mCommentOrderButton = [UIButton new];
    _mDeleteOrderButton  = [UIButton new];
    _mTopLineView        = [PXSingleLineView new];
    _mBottomLineView     = [PXSingleLineView new];
    _mOrderListView      = [OrderTableListView new];
    NSArray *views = @[_mAvatarImageView,_mShopNameLabel,_mCommentStateLabel,_mOrderStateLabel,_mTopLineView,_mOrderListView,_mPriceLabel,_mPriceLabel,_mBottomLineView,_mDeleteOrderButton,_mCommentOrderButton];
    [self.contentView sd_addSubviews:views];
    
    UIView *view = self.contentView;
    CGFloat padding = 15.0f;
    CGFloat margin = 10.0f;
    
    _mAvatarImageView.sd_layout
        .leftSpaceToView(view, padding)
        .topSpaceToView(view, 5)
        .widthIs(35)
        .heightEqualToWidth();
    
    _mShopNameLabel.sd_layout
        .leftSpaceToView(_mAvatarImageView, padding)
        .topEqualToView(_mAvatarImageView)
        .heightRatioToView(_mAvatarImageView, 1);
    [_mShopNameLabel setSingleLineAutoResizeWithMaxWidth:200];
    _mShopNameLabel.font = Font(15);
    _mShopNameLabel.textColor = PX_COLOR_HEX(@"333333");
    
    _mCommentStateLabel.sd_layout
        .rightSpaceToView(view, padding)
        .topEqualToView(_mAvatarImageView)
        .heightRatioToView(_mAvatarImageView, 1);
    [_mCommentStateLabel setSingleLineAutoResizeWithMaxWidth:200];
    _mCommentStateLabel.font = Font(15);
    _mCommentStateLabel.textColor = PX_COLOR_HEX(@"666666");
    
    _mOrderStateLabel.sd_layout
        .rightSpaceToView(_mCommentStateLabel, padding)
        .topEqualToView(_mAvatarImageView)
        .heightRatioToView(_mAvatarImageView, 1);
    _mCommentStateLabel.font = Font(15);
    _mCommentStateLabel.textColor = PX_COLOR_HEX(@"666666");
    
    _mTopLineView.sd_layout
        .leftEqualToView(_mAvatarImageView)
        .rightEqualToView(_mCommentStateLabel)
        .topSpaceToView(_mAvatarImageView, 5)
        .heightIs(.8f);
    
    _mOrderListView.sd_layout
        .leftSpaceToView(view, margin + padding)
        .topSpaceToView(_mTopLineView, 5)
        .rightSpaceToView(view, padding);
    
    _mPriceLabel.sd_layout
        .rightEqualToView(_mCommentStateLabel)
        .topSpaceToView(_mOrderListView, margin)
        .heightIs(35);
    _mPriceLabel.isAttributedContent = YES;
    [_mPriceLabel setSingleLineAutoResizeWithMaxWidth:200];
    _mPriceLabel.font = Font(14);
    _mPriceLabel.textColor = PX_COLOR_HEX(@"666666");
    
    _mBottomLineView.sd_layout
        .leftEqualToView(_mTopLineView)
        .rightEqualToView(_mTopLineView)
        .topSpaceToView(_mPriceLabel, margin)
        .heightIs(.8f);
    
    _mDeleteOrderButton.sd_layout
        .rightEqualToView(_mTopLineView)
        .topSpaceToView(_mBottomLineView, 5);
    _mDeleteOrderButton.titleLabel.font = Font(15);
    [_mDeleteOrderButton setTitle:@"删除订单" forState:UIControlStateNormal];
    [_mDeleteOrderButton setupAutoSizeWithHorizontalPadding:padding buttonHeight:30];
    [_mDeleteOrderButton setTitleColor:PX_COLOR_HEX(@"666666") forState:UIControlStateNormal];
    _mDeleteOrderButton.layer.masksToBounds = YES;
    _mDeleteOrderButton.layer.borderWidth = 1.0f;
    _mDeleteOrderButton.layer.borderColor = PX_COLOR_HEX(@"666666").CGColor;
    
    _mCommentOrderButton.sd_layout
        .rightSpaceToView(_mDeleteOrderButton, padding)
        .topEqualToView(_mDeleteOrderButton);
    [_mCommentOrderButton setTitleColor:PX_COLOR_HEX(@"666666") forState:UIControlStateNormal];
    [_mCommentOrderButton setTitle:@"评论订单" forState:UIControlStateNormal];
    _mCommentOrderButton.titleLabel.font = Font(15);
    [_mCommentOrderButton setupAutoSizeWithHorizontalPadding:padding buttonHeight:30];
    _mCommentOrderButton.layer.masksToBounds = YES;
    _mCommentOrderButton.layer.borderColor = PX_COLOR_HEX(@"666666").CGColor;
    _mCommentOrderButton.layer.borderWidth = 1.0f;
    
    __weak typeof(self) weakSelf = self;
    [_mCommentOrderButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf.delegate orderTableCell:weakSelf clickButtonType:OrderTableCellButtonAction_Comment];
    }];
    
    [_mDeleteOrderButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        [weakSelf.delegate orderTableCell:weakSelf clickButtonType:OrderTableCellButtonAction_Delete];
    }];
}

- (void)setModel:(GoodsOrderModel *)model{
    
    _mOrderListView.model = model.order_products;
    [_mAvatarImageView sd_setImageWithURL:[NSURL URLWithString:model.order_shopLogo] placeholderImage:nil];
    _mShopNameLabel.text = model.order_shopName;
    _mCommentStateLabel.text = model.order_stateDes;
    NSString *price = [NSString stringWithFormat:@"%.2f",model.order_money];
    _mPriceLabel.attributedText = [self getAttributeString:price];
    [self setupAutoHeightWithBottomView:_mDeleteOrderButton bottomMargin:5];
}

- (NSMutableAttributedString *)getAttributeString:(NSString *)price{
    NSString *string = [@"实付：￥" stringByAppendingString:price];
    NSMutableAttributedString *syString = [[NSMutableAttributedString alloc] initWithString:string];
    [syString addAttribute:NSFontAttributeName value:Font(13) range:[string rangeOfString:price]];
    return syString;
}

@end
