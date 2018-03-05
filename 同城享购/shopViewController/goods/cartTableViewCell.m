//
//  cartTableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/22.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "cartTableViewCell.h"

@implementation cartTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self uiconfig];
}
- (void)uiconfig{
    self.goodsImageView.layer.cornerRadius = 5;
    self.goodsImageView.layer.masksToBounds = YES;
    self.goodsPriceLabel.textColor = UIColorFromRGBA(252, 71, 74, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
