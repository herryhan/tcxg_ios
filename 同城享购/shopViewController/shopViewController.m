//
//  shopViewController.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/13.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "shopViewController.h"
#import "goodsViewController.h"
#import "shopCommentViewController.h"
#import "aboutShopViewController.h"

#import "homeModel.h"
#import "shopBasicInfoModel.h"
#import "cartModel.h"

#import "UIViewController+BarButton.h"

#import "shopBgInfoView.h"


@interface shopViewController ()<UIScrollViewDelegate>

@property (nonatomic,strong) shopHeaderView *headerView;
@property (nonatomic,strong) NSDictionary *cartsDict;

@property (nonatomic,strong) UIScrollView *shopScrollerView;
@property (nonatomic,strong) shopBgInfoView *bgInfoView;
@property (nonatomic,strong) UIView *testView;

@end

@implementation shopViewController

- (UIStatusBarStyle)preferredStatusBarStyle
{

    return UIStatusBarStyleLightContent;

}

- (shopBgInfoView *)bgInfoView{
    if (!_bgInfoView) {
        _bgInfoView = [[shopBgInfoView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _bgInfoView;
}
- (UIScrollView *)bgScrollerView{
    
    if (!_shopScrollerView) {
        
        _shopScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight)];
        _shopScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight+120+100);
        _shopScrollerView.delegate = self;
        _shopScrollerView.showsVerticalScrollIndicator = NO;
        self.testView = [[UIView alloc]initWithFrame:CGRectMake(0, 80+20+5/2+20, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-(+80+20+5/2+20))];
        self.testView.backgroundColor = [UIColor redColor];
        [_shopScrollerView addSubview:self.testView];
    }
    return _shopScrollerView;
    
}

-(NSDictionary *)cartsDict{
    if (!_cartsDict) {
        _cartsDict = [[NSDictionary alloc] init];
    }
    return _cartsDict;
}


//获取购物车的数据
- (void)getCartData{

    [MBProgressHUD showMessage:@""];
    [URLRequest getWithURL:[NSString stringWithFormat:@"http://ha.tongchengxianggou.com/api/cart/list?id=%@&uuid=%@",self.shopModel.id,Uid] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.cartsDict = [cityShoppingTool jsonConvertToDic:responseObject];
        NSLog(@"%@",self.cartsDict);
       
        [self settingVC];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.bgInfoView];
    [self.bgInfoView viewConfigWithModel:self.shopModel];
   // [self getCartData];
    [self.view addSubview:self.bgScrollerView];
}

- (void)settingVC{
    // self.bgInfoView.noticLabel.text = self.cartsDict[@"notice"];
    NSLog(@"notice:%@",self.cartsDict);
    goodsViewController *goodsVC= [[goodsViewController alloc]init];
    goodsVC.fatherVc = self;
    goodsVC.shopCartDict = self.cartsDict;
    
    
    goodsVC.lat = self.lat;
    goodsVC.lon = self.lon;
    goodsVC.shopModel = self.shopModel;
    
    shopCommentViewController *shopVC = [[shopCommentViewController alloc]init];
    
    aboutShopViewController *aboutVC = [[aboutShopViewController alloc]init];
    NSArray *controllers = @[goodsVC,shopVC,aboutVC];
    NSArray *titileArray = @[@"商品",@"评价",@"商家"];
    self.hxwSegView = [[hxwSegmentView alloc] initWithFrame:CGRectMake(0, 120, SCREEN_WIDTH, SCREEN_HEIGHT-120-SafeAreaTopHeight) buttonName:titileArray contrllers:controllers parentController:self];
    self.hxwSegView.backgroundColor = [UIColor redColor];
    //[self.bgScrollerView addSubview:self.hxwSegView];
}

- (void)collectPress{
    NSLog(@"收藏了");
}
- (void)scanPress{
    NSLog(@"扫描了");
}

- (void) searchBarPress{
    
}
- (void)backPress{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.shopScrollerView) {
        self.testView.frame = CGRectMake(0, 80+20+5/2+20-scrollView.contentOffset.y, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-(+80+20+5/2+20));
        
        if (scrollView.contentOffset.y<=0 &&scrollView.contentOffset.y>=-60) {
            [self.bgInfoView.infoScroller setContentOffset:CGPointMake(0, 60+scrollView.contentOffset.y)];
            self.bgInfoView.iconImageView.frame = CGRectMake(10+(SCREEN_WIDTH/2 -50)/60*(-scrollView.contentOffset.y), SafeAreaTopHeight+10-scrollView.contentOffset.y/6, 80, 80);
            self.bgInfoView.shopNameLabel.alpha = 1+scrollView.contentOffset.y/50;
            self.bgInfoView.noticLabel.alpha = 1+scrollView.contentOffset.y/50;
            self.bgInfoView.shopNameLabelTwo.alpha = 0;
        }else if(scrollView.contentOffset.y<-60){
            self.bgInfoView.shopNameLabelTwo.alpha = -(scrollView.contentOffset.y + 60)/10;
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"vef");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
