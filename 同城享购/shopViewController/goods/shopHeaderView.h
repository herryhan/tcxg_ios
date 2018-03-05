//
//  shopHeaderView.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/13.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeModel.h"


@interface shopHeaderView : UIView<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *bulrImageView;
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *firstActivityLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UIButton *moreActivityBtn;
@property (nonatomic,strong) homeModel *model;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITableView *activityTableView;
@property (weak, nonatomic) IBOutlet UIImageView *noticeImageView;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@property (nonatomic,strong) NSMutableArray *dataArray;

- (void)closeTimer;
- (void)openTimer;

@property (strong, nonatomic) NSTimer *timer;
@property (strong, nonatomic) NSLock *mLock;
@property (strong, nonatomic) void(^showShopInfo)(void);

@end
