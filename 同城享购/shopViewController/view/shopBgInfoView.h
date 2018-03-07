//
//  shopBgInfoView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/3/3.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeModel.h"

@interface shopBgInfoView : UIView

@property (nonatomic,strong) UIImageView *iconImageView;
@property (nonatomic,strong) UILabel *shopNameLabel;
@property (nonatomic,strong) UILabel *noticLabel;
@property (nonatomic,strong) UIImageView *bulrImageView;
@property (nonatomic,strong) UILabel *shopNameLabelTwo;

@property (nonatomic,strong) UIScrollView *infoScroller;
@property (nonatomic,strong) UIView *actView;
@property (nonatomic,strong) UIView *sendInfoView;
@property (nonatomic,strong) UIView *noticeView;

- (void)viewConfigWithModel:(homeModel *)model;

@end
