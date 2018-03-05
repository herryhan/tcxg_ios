//
//  showActivityTableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/13.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "showActivityTableViewCell.h"

@implementation showActivityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self uiconfig];
}
- (void)uiconfig{
    self.activityTypeLabel.backgroundColor = [UIColor redColor];
    self.backgroundColor = [UIColor clearColor];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)modelConfigWithModel:(showActivityModel *)model{
    self.activityTypeLabel.text = model.type;
    self.activityContent.text = model.name;

}
@end
