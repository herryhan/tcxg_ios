//
//  myViewController.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "myViewController.h"
#import "myHeaderView.h"
#import "MyWebVC.h"
#import "MyAddressVC.h"
#import "MyFavoriteVC.h"

@interface myViewController ()<UITableViewDelegate,UITableViewDataSource,MyHeaderViewDelegate>

@property (nonatomic,strong) UITableView *mytTableView;
@property (nonatomic,strong) NSArray *imageArray;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) myHeaderView *headerView;

@end

@implementation myViewController
-(myHeaderView *)headerView{
    
    if (!_headerView) {
        _headerView = [[myHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
        CGRect rect =  _headerView.headerBgImageView.frame;
        rect.size.width = SCREEN_WIDTH;
        _headerView.delegate = self;
        _headerView.headerBgImageView.frame = rect;
    }
    return _headerView;
    
}
- (UITableView *)mytTableView{
    if (!_mytTableView) {
        _mytTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight) style:UITableViewStyleGrouped];
        _mytTableView.delegate = self;
        _mytTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _mytTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            // _homeTableView.contentInset = UIEdgeInsetsMake(SafeAreaTopHeight, 0, SafeAreaBottomHeight, 0);//iPhoneX这里是88
            _mytTableView.scrollIndicatorInsets = _mytTableView.contentInset;
        }
        [_mytTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];
        _mytTableView.separatorInset = UIEdgeInsetsMake(0,10, 0, 0);
    }
    return _mytTableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.imageArray = @[@[@"mycollect",@"myorder",@"myaddress"],@[@"mybuiness",@"mydriver"],@[@"user"]];
    self.titleArray = @[@[@"我的收藏",@"我的订单",@"我的地址"],@[@"商家入驻",@"骑手招募"],@[@"账户切换"]];
    [self.mytTableView setTableHeaderView:self.headerView];
    
    [self.view addSubview:self.mytTableView];
    
    [self.mytTableView reloadData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section ==0 ) {
        return 3;
    }else if (section == 1){
        return 2;
    }else{
        return 1;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.section][indexPath.row];
    cell.textLabel.textColor = UIColorFromRGBA(143, 145, 144, 1);
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image = [UIImage imageNamed:self.imageArray[indexPath.section][indexPath.row]];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //@[@[@"我的收藏",@"我的订单",@"我的地址"],@[@"商家入驻",@"骑手招募"],@[@"账户切换"]];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            //我的收藏
            MyFavoriteVC *vc = [MyFavoriteVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if (indexPath.row == 1) {
            //我的订单
            [self.tabBarController setSelectedIndex:3];
        }
        if (indexPath.row == 2) {
            MyAddressVC *vc = [MyAddressVC new];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    if (indexPath.section == 1) {
        MyWebVC *vc = [MyWebVC new];
        vc.title = self.titleArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if (indexPath.section == 2) {
        //账号切换
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.05;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint point = scrollView.contentOffset;
    if (point.y <= 0) {
        CGRect rect = [self.mytTableView viewWithTag:101].frame;
        rect.origin.y = point.y;
        rect.size.height = -point.y+150;
        [self.mytTableView viewWithTag:101].frame = rect;
    }
}

#pragma mark =====================MyHeaderViewDelegate========================

- (void)headerView:(myHeaderView *)headerView didClickAtView:(UIView *)view{
    if (view==headerView.quanView) {
        //代金券
        PXDALog(@"代金券---%s",__func__);
    }else{
        //钱包余额
        PXDALog(@"钱包余额------%s",__func__);
    }
}

@end
