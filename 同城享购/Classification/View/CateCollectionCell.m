//
//  CateCollectionCell.m
//  同城享购
//
//  Created by Charles on 2018/2/25.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CateCollectionCell.h"

@implementation CateCollectionCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self px_setupView];
    }
    return self;
}

- (void)px_setupView{
    
    self.mNameLabel = ({
        UILabel *view = [[UILabel alloc] init];
        view.textColor = PX_COLOR_HEX(@"333333");
        view.textAlignment= NSTextAlignmentCenter;
        view.font = Font(15);
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(self, 5)
            .rightSpaceToView(self, 5)
            .heightIs(20)
            .bottomSpaceToView(self, 5);
        view;
    });
    
    self.mImageView = ({
        UIImageView *view = [[UIImageView alloc] init];
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(self, 5)
            .rightSpaceToView(self, 5)
            .topSpaceToView(self, 5)
            .bottomSpaceToView(self.mNameLabel, 5);
//        view.contentMode = UIViewContentModeCenter;
        view;
    });
}

- (void)setModel:(SecCateSecModel *)model{
    _model = model;
    [self.mImageView sd_setImageWithURL:[NSURL URLWithString:model.cate_logo] placeholderImage:nil];
//    self.mImageView.image = [UIImage imageWithColor:PX_RANDOM_COLOR];
    self.mNameLabel.text = model.cate_name;
}

@end
