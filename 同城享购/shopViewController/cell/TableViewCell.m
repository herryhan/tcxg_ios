//
//  TableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/14.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
    
  // self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIColor *color =  [[UIColor alloc]initWithRed:255 green:255 blue:255 alpha:1];
    //通过RGB来定义自己的颜色
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.frame];
    self.selectedBackgroundView.backgroundColor = color;
    
}

- (void)setGoodsTypeModel:(goodsType *)goodsTypeModel{
    
    _goodsTypeModel = goodsTypeModel;
    
    self.typeNameLabel.text = goodsTypeModel.name;
    self.typeNameLabel.textColor = UIColorFromRGBA(104, 104, 104, 1);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    if (selected) {
        self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    }
}

@end
