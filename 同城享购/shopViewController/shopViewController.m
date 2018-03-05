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


@interface shopViewController ()

@property (nonatomic,strong) shopHeaderView *headerView;
@property (nonatomic,strong) NSDictionary *cartsDict;

@property (nonatomic,strong) UIScrollView *bgScrollerView;
@property (nonatomic,strong) shopBgInfoView *bgInfoView;

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
    
    if (!_bgScrollerView) {
        
        _bgScrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight)];
        _bgScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight+120);
    }
    return _bgScrollerView;
    
}

-(NSDictionary *)cartsDict{
    if (!_cartsDict) {
        _cartsDict = [[NSDictionary alloc] init];
    }
    return _cartsDict;
}



- (void)getCartData{

    [MBProgressHUD showMessage:@""];
    [URLRequest getWithURL:[NSString stringWithFormat:@"http://ha.tongchengxianggou.com/api/cart/list?id=%@&uuid=%@",self.shopModel.id,Uid] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        self.cartsDict = [cityShoppingTool jsonConvertToDic:responseObject];
       //  NSLog(@"%@",);
       
        [self settingVC];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view addSubview:self.bgInfoView];
    [self.bgInfoView viewConfigWithModel:self.shopModel];
   // self.headerView.model = self.shopModel;
  //  [self.shopInfoViewCustom configWith:self.shopModel];
    
    [self getCartData];
    [self.view addSubview:self.bgScrollerView];
    
}

- (void)settingVC{
     self.bgInfoView.noticLabel.text = self.cartsDict[@"notice"];
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
    [self.bgScrollerView addSubview:self.hxwSegView];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
