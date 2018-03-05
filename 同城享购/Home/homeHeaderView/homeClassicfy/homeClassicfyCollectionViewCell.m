//
//  homeClassicfyCollectionViewCell.m
//  同城享购
//
//  Created by 庄园 on 2017/11/9.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "homeClassicfyCollectionViewCell.h"

@interface homeClassicfyCollectionViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation homeClassicfyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:12.0];
        titleLabel.textColor = [UIColor lightGrayColor];
        [self addSubview:titleLabel];
        self.iconView = iconView;
        self.titleLabel = titleLabel;
       // self.backgroundColor = [UIColor blueColor];
    }
    return self;
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:imageName]];
}

- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.iconView.frame = CGRectMake((self.frame.size.width - (self.frame.size.height - 21-10))/2, 10, self.frame.size.height - 21-10, self.frame.size.height - 21-10);
    self.titleLabel.frame = CGRectMake(0, self.frame.size.height-21, self.frame.size.width, 21);
}


@end
