//
//  shopBgInfoView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/3/3.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "shopBgInfoView.h"

@implementation shopBgInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
     
        [self configView];
        
    }
    return self;
}

- (void)configView{
    self.bulrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SafeAreaTopHeight+80)];
    [self addSubview:self.bulrImageView];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight+10, 80, 80)];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self addSubview:self.iconImageView];
    self.shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight+10+10, SCREEN_WIDTH-100, 20)];
    [self.shopNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    self.shopNameLabel.textColor = [UIColor whiteColor];
   
    [self addSubview:self.shopNameLabel];
    self.noticLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight+10+10+30, SCREEN_WIDTH-100, 20)];
    self.noticLabel.font = [UIFont systemFontOfSize:14];
    self.noticLabel.textColor = [UIColor lightGrayColor];
    
    //self.noticLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.noticLabel];
    
}
- (void)viewConfigWithModel:(homeModel *)model{
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    [self.bulrImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    // 生成特定样式的模糊效果
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [effectView setFrame:self.bulrImageView.frame];
    [self.bulrImageView  addSubview:effectView];
    
    self.shopNameLabel.text = model.name;
    //self.noticLabel.text = model.notice;
    
}
@end
