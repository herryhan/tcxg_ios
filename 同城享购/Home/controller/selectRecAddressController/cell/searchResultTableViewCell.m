//
//  searchResultTableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/2.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "searchResultTableViewCell.h"

@implementation searchResultTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.addressLabel.textColor = UIColorFromRGBA(50, 50, 50, 1);
    // Initialization code
}
- (void)uiconfigWith:(AMapPOI *)poi{
    self.addressLabel.text = poi.name;
    self.adressDetaillLabel.text = poi.address;
    self.distanceLabel.text = [NSString stringWithFormat:@"距离%0.1f千米",poi.distance/1000.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
