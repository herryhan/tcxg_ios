//
//  subClassCollectionViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "subClassCollectionViewCell.h"

@implementation subClassCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self uiconfig];
}

- (void)uiconfig{
    //UIColorFromRGBA(68, 195, 34, 1)
    self.classImageView.layer.cornerRadius = 23;
    self.classImageView.layer.masksToBounds = YES;
    self.bottomView.backgroundColor = [UIColor whiteColor];
    self.imageBgView.layer.borderWidth = 2;
    self.imageBgView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.imageBgView.layer.cornerRadius = 27;
    self.imageBgView.layer.masksToBounds = YES;
}

- (void)configWithModel:(subClassModel *)model{
    NSLog(@"ddfffff:%@",model.name);
    [self.classImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.classNameLabel.text = model.name;
    if (model.isSelected) {
        self.bottomView.backgroundColor = UIColorFromRGBA(68, 195, 34, 1);
        self.imageBgView.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
        
    }else{
        self.bottomView.backgroundColor = [UIColor whiteColor];
        self.imageBgView.layer.borderColor = [UIColor whiteColor].CGColor;
    }
}


@end
