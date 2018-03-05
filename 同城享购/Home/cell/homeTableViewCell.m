//
//  homeTableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "homeTableViewCell.h"
#import "activityLabelView.h"
#import "activityModel.h"

@implementation homeTableViewCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(homeModel *)model{
    
    _model = model;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.shopNameLabel.text = model.name;
    if ([model.vip integerValue] == 0) {
        [self.isAuthImage setImage:[UIImage imageNamed:@"auth0"]];
    }else{
        [self.isAuthImage setImage:[UIImage imageNamed:@"auth1"]];
    }
    if ([model.singleDay integerValue] == 1) {
        [self.singleImageView setImage:[UIImage imageNamed:@"singler"]];
    }
    self.sendSlogoLabel.layer.borderWidth = 0.5;
    self.sendSlogoLabel.layer.borderColor =UIColorFromRGBA(68, 195, 34, 1).CGColor;
    self.sendSlogoLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
    
    switch ([model.score integerValue]) {
        case 0:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank0"]];
            break;
        case 1:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank1"]];
            break;
        case 2:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank2"]];
            break;
        case 3:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank3"]];
            break;
        case 4:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank4"]];
            break;
            
        case 5:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank5"]];
            break;
        default:
            break;
    }
    
    NSLog(@"dustabce:%@",model.distance);
    
    self.distanceLabel.text = [NSString stringWithFormat:@"起送价:35元 | 距离:%@ km | 免费配送",model.distance];
    self.addressLabel.text = model.address;
    if (model.products.count!=0) {
        
        [self.imageView1 sd_setImageWithURL:[NSURL URLWithString:model.products[0][@"logo"]]];
        [self.imageView2 sd_setImageWithURL:[NSURL URLWithString:model.products[1][@"logo"]]];
        [self.imageView3 sd_setImageWithURL:[NSURL URLWithString:model.products[2][@"logo"]]];
        [self.imageView4 sd_setImageWithURL:[NSURL URLWithString:model.products[3][@"logo"]]];
    }
  
    if (model.actives.count!=0) {
        self.activityContraint.constant = 34*model.actives.count;
    }
    for (int i = 0 ; i<model.actives.count; i++) {
        activityLabelView *lab = [[activityLabelView alloc]initWithFrame:CGRectMake(0, 34*i, SCREEN_WIDTH-83, 34)];
        //activityModel *actModel = model.actives[i];
        [lab setValueWithDic:model.actives[i]];
        
        [self.activityView addSubview:lab];
    }
    self.salesCount.text = [NSString stringWithFormat:@"月售%@单",model.monthSells];
    //self.activityContraint.constant = 100;
    
}
@end
