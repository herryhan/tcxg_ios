//
//  searchSubView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/11.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "hxwTagView.h"

@interface searchSubView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *hotSearchConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *historySearchConstraint;

@property (weak, nonatomic) IBOutlet UIView *hotView;
@property (weak, nonatomic) IBOutlet UIView *historyView;
@property (weak, nonatomic) IBOutlet hxwTagView *hotTagView;

@property(nonatomic, assign) CGSize intrinsicContentSize;
@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UILabel *historyLabel;
@property (weak, nonatomic) IBOutlet hxwTagView *historyTagView;
@property (weak, nonatomic) IBOutlet UIButton *clearBtn;

@property (nonatomic,strong) void(^clearHistorySearch)(void);
@property (weak, nonatomic) IBOutlet UIView *historyBgView;

@end
