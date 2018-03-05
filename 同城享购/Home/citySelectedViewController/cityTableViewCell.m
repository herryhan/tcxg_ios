//
//  cityTableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/30.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "cityTableViewCell.h"

@implementation cityTableViewCell

- (void)setCellArr:(NSArray *)cellArr{
    
    _cellArr = cellArr;
    CGFloat w = (kScreenWidth-30)/3;
    for (int i = 0; i < cellArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(15+i%3*w, 15+i/3*45, w-15, 30);
        [btn setTitle:cellArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.backgroundColor = [UIColor whiteColor];
        [self addSubview:btn];
    }
    
}

- (void)btnClick:(UIButton *)btn{
    
    //    NSLog(@"btnClick---%@",btn.titleLabel.text);
    [self.delegate TableViewSelectorIndix:btn.titleLabel.text];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
