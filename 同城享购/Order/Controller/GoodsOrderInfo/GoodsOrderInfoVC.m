//
//  GoodsOrderInfoVC.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoVC.h"
#import "GoodsOrderInfoHeadView.h"
#import "GoodsOrderInfoShopView.h"
#import "GoodsOrderInfoRiderView.h"
#import "GoodsOrderInfoServiceView.h"
#import "GoodsCommentVC.h"

@interface GoodsOrderInfoVC ()
{
    UIScrollView *_mScrollView;
    UIView *_mBackView;
    
    GoodsOrderInfoHeadView *_mHeaderView;//头部
    GoodsOrderInfoShopView *_mShopView;//商家详情
    GoodsOrderInfoRiderView *_mRiderView;//骑手详情
    GoodsOrderInfoServiceView *_mServiceView;//客服详情
}
@end

@implementation GoodsOrderInfoVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    [self setupView];
    
}

- (void)setupView{
    
    _mBackView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, PX_SCREEN_WIDTH, 160)];
    _mBackView.backgroundColor = PX_COLOR_HEX(@"57e038");
    [self.view addSubview:_mBackView];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    [_mBackView addSubview:titleLabel];
    titleLabel.sd_layout.spaceToSuperView(UIEdgeInsetsMake(34, 44, 76, 44));
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    titleLabel.textColor = PX_COLOR_HEX(@"ffffff");
    titleLabel.text = @"订单详情";
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    _mScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [_mScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_mScrollView];
    _mScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
    
    CGFloat padding = 15.0f;
    
    UIView *view         = [UIView new];
    view.backgroundColor = self.view.backgroundColor;
    [_mScrollView addSubview:view];
    view.sd_layout
        .leftSpaceToView(_mScrollView, padding)
        .rightSpaceToView(_mScrollView, padding)
        .topSpaceToView(_mScrollView, 0);
    
    _mHeaderView  = [GoodsOrderInfoHeadView new];
    _mShopView    = [GoodsOrderInfoShopView new];
    _mRiderView   = [GoodsOrderInfoRiderView new];
    _mServiceView = [GoodsOrderInfoServiceView new];
    [view sd_addSubviews:@[_mHeaderView,_mShopView,_mRiderView,_mServiceView]];
    
    _mHeaderView.sd_layout
        .leftSpaceToView(view, 0)
        .rightSpaceToView(view, 0)
        .topSpaceToView(view, 0);
    _mHeaderView.model = self.model;
    __weak typeof(self) weakSelf = self;
    _mHeaderView.GoodsOrderInfoHeadViewButtonAction = ^(UIButton *sender) {
        GoodsCommentVC *vc = [GoodsCommentVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    _mShopView.sd_layout
        .leftEqualToView(_mHeaderView)
        .rightEqualToView(_mHeaderView)
        .topSpaceToView(_mHeaderView, padding);
    _mShopView.model = self.model;
    _mShopView.GoodsOrderInfoShopButtonAction = ^{
        [weakSelf callMobileWithPhomeNumber:@"0517-10086"];
    };
    
    _mRiderView.sd_layout
        .leftEqualToView(_mHeaderView)
        .rightEqualToView(_mHeaderView)
        .topSpaceToView(_mShopView, padding);
    _mRiderView.model = nil;
    _mRiderView.GoodsOrderInfoRiderButtonAction = ^{
        [weakSelf callMobileWithPhomeNumber:@"0517-10010"];
    };
    
    _mServiceView.sd_layout
        .leftEqualToView(_mHeaderView)
        .rightEqualToView(_mHeaderView)
        .topSpaceToView(_mRiderView, padding);
    _mServiceView.model = nil;
    _mServiceView.GoodsOrderInfoServiceButtonAction = ^{
        [weakSelf callMobileWithPhomeNumber:@"0517-10000"];
    };
    
    [view setupAutoHeightWithBottomView:_mServiceView bottomMargin:padding];
    
    [_mScrollView setupAutoContentSizeWithBottomView:view bottomMargin:0];
}

- (void)callMobileWithPhomeNumber:(NSString *)phomeNumber{
    NSString *callPhone = [NSString stringWithFormat:@"telprompt://%@", phomeNumber];
    if (@available(iOS 10.0, *)) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone] options:@{} completionHandler:nil];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callPhone]];
    }
}

@end
