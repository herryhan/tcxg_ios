//
//  myHeaderView.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/16.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@class myHeaderView;
@protocol MyHeaderViewDelegate
@optional
- (void)headerView:(myHeaderView *)headerView didClickAtView:(UIView *)view;
@end

@interface myHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIImageView *headerBgImageView;
@property (weak, nonatomic) IBOutlet UIButton *cashBtn;
@property (weak, nonatomic) IBOutlet UIButton *quanBtn;
@property (weak, nonatomic) IBOutlet UIView *quanView;
@property (weak, nonatomic) IBOutlet UIView *cashView;
@property (nonatomic,weak) id <MyHeaderViewDelegate> delegate;

@end
