//
//  goodsTableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/14.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "goodsTableViewCell.h"

@implementation goodsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.subBtn.hidden = YES;
    self.countLabel.hidden = YES;
    
}
- (void)setModel:(goodsInfoModel *)model{
    
    _model = model;
    [self.goodsImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.goodsNameLabel.text = model.name;
    self.goodsPrice.text =[NSString stringWithFormat:@"¥%0.2lf",[model.price floatValue]];
    self.numCount = [model.count integerValue];
    NSLog(@"ddddd %ld",self.numCount);
    [self showOrderNumbers:[model.count integerValue]];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (IBAction)plusBtn:(UIButton *)sender {

     self.block(self.numCount, YES);

}
- (IBAction)subBtn:(id)sender {

    self.block(self.numCount, NO);

}

-(void)showOrderNumbers:(NSUInteger)count
{
    self.countLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)count];
    if (self.numCount > 0)
    {
        [self.subBtn setHidden:NO];
        [self.countLabel setHidden:NO];
    }
    else
    {
        [self.subBtn setHidden:YES];
        [self.countLabel setHidden:YES];
    }
}

@end
