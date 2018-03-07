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
#import "GoodsOrderInfoModel.h"

@interface GoodsOrderInfoVC ()
{
    UIScrollView *_mScrollView;
    UIView *_mBackView;
    
    GoodsOrderInfoHeadView *_mHeaderView;//头部
    GoodsOrderInfoShopView *_mShopView;//商家详情
    GoodsOrderInfoRiderView *_mRiderView;//骑手详情
    GoodsOrderInfoServiceView *_mServiceView;//客服详情
}
@property (nonatomic,strong) GoodsOrderInfoModel *insetModel;
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
    
    
    
    [self loadData];
}

- (void)loadData{
    [SVProgressHUD showWithStatus:@"请稍候……"];
    [URLRequest postWithURL:@"order" params:@{@"uuid":Uid,@"os":@"ios",@"channelId":@"5637447362195603251",@"locate":@(1),@"id":@(self.model.order_id)} success:^(NSURLSessionDataTask *task, id responseObject) {
        responseObject = responseObject?[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]:nil;
        self.insetModel = [GoodsOrderInfoModel mj_objectWithKeyValues:responseObject];
        [self setupView];
        [self insetData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"服务器打盹了"];
    }];
}

- (void)insetData{

    _mHeaderView.model = self.insetModel;
    _mShopView.model =  self.insetModel;
    _mRiderView.model = [NSString stringWithFormat:@"%@  %@",self.insetModel.model_driverName,self.insetModel.model_driverTel];
    _mServiceView.model = [NSDictionary dictionaryWithObjects:@[self.insetModel.model_no,self.insetModel.model_expectTime,[NSString stringWithFormat:@"%@  %@\n%@",self.insetModel.model_realname,self.insetModel.model_tel,self.insetModel.model_address]] forKeys:@[@"no",@"time",@"address"]];
    __weak typeof(self) weakSelf = self;
    
    _mShopView.GoodsOrderInfoShopButtonAction = ^{
        [weakSelf callMobileWithPhomeNumber:weakSelf.insetModel.model_shopTel];
    };
    
    _mRiderView.GoodsOrderInfoRiderButtonAction = ^{
        [weakSelf callMobileWithPhomeNumber:weakSelf.insetModel.model_driverTel];
    };
    
    _mServiceView.GoodsOrderInfoServiceButtonAction = ^{
        [weakSelf callMobileWithPhomeNumber:weakSelf.insetModel.model_serviceTel];
    };
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
    CGFloat margin = 10.0f;
    
    UIView *view         = [UIView new];
    view.backgroundColor = self.view.backgroundColor;
    view.sd_cornerRadius = @(10);
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
    __weak typeof(self) weakSelf = self;
    _mHeaderView.GoodsOrderInfoHeadViewButtonAction = ^(UIButton *sender) {
        GoodsCommentVC *vc = [GoodsCommentVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    };
    
    _mShopView.sd_layout
        .leftEqualToView(_mHeaderView)
        .rightEqualToView(_mHeaderView)
        .topSpaceToView(_mHeaderView, margin);
    
    
    _mRiderView.sd_layout
        .leftEqualToView(_mHeaderView)
        .rightEqualToView(_mHeaderView)
        .topSpaceToView(_mShopView, margin);
    
    
    _mServiceView.sd_layout
        .leftEqualToView(_mHeaderView)
        .rightEqualToView(_mHeaderView)
        .topSpaceToView(_mRiderView, margin);
    
    [view setupAutoHeightWithBottomView:_mServiceView bottomMargin:0];
    
    [_mScrollView setupAutoContentSizeWithBottomView:view bottomMargin:padding];
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
