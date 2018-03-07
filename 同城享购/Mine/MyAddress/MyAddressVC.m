//
//  MyAddressVC.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "MyAddressVC.h"
#import "MyAddressCell.h"
#import "EditeAddressVC.h"

@interface MyAddressVC ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,UISearchDisplayDelegate,MyAddressCellDelegate,UIAlertViewDelegate>
//** tableView */
@property (nonatomic,weak) UITableView * mTableView;
//** searchBar */
@property (nonatomic,weak) UISearchBar * mSearchBar;
//** dataSource */
@property (nonatomic,strong) NSArray * dataSource;
//** searchDataSource */
@property (nonatomic,strong) NSArray * searchSource;
//** isSearchModel */
@property (nonatomic,assign) BOOL  isSearching;

@end

@implementation MyAddressVC

static NSString *cellId = @"cellId";

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:PX_COLOR_HEX(@"ffffff"),NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的地址";
    [self setupView];
    
}

- (void)setupView{
    //initTableView
    UITableView *tableView = [[UITableView alloc] init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [UIView new];
    tableView.separatorInset = UIEdgeInsetsZero;
    [tableView registerClass:[MyAddressCell class] forCellReuseIdentifier:cellId];
    tableView.mj_header = [PXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    [self.view addSubview:tableView];
    tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(40, 0, 50, 0));
    self.mTableView = tableView;
    
    //initSearchBar
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    searchBar.delegate = self;
    [self.view addSubview:searchBar];
    searchBar.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(self.view, 0)
        .bottomSpaceToView(self.mTableView, 0);
    self.mSearchBar = searchBar;
    [self beautifySearchBar];
    
    UIButton *addAddressButton = [UIButton new];
    [self.view addSubview:addAddressButton];
    addAddressButton.sd_layout
        .leftSpaceToView(self.view, 0)
        .topSpaceToView(tableView, 0)
        .rightSpaceToView(self.view, 0)
        .bottomSpaceToView(self.view, 0);
    addAddressButton.titleLabel.font = Font(16);
    [addAddressButton setTitle:@"新增地址" forState:UIControlStateNormal];
    [addAddressButton setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"2C6211")] forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [addAddressButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        EditeAddressVC *vc = [EditeAddressVC new];
        [weakSelf.navigationController pushViewController:vc animated:YES ];
    }];
    
    [tableView.mj_header beginRefreshing];
}

- (void)beautifySearchBar{
    self.mSearchBar.barStyle = UIBarStyleDefault;
    self.mSearchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.mSearchBar.backgroundImage = [UIImage imageWithColor:PX_COLOR_HEX(@"ffffff")];
    [self.mSearchBar setSearchFieldBackgroundImage:PX_IMAGE_NAMED(@"search_bg") forState:UIControlStateNormal];
    self.mSearchBar.placeholder = @"请输入姓名、手机号码、地址";
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    self.isSearching = searchText.length > 0;
    //匹配搜索结果
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"mine_tel CONTAINS %@ OR mine_pinyin CONTAINS[cd] %@ OR mine_name CONTAINS %@",searchText,searchText,searchText];
    self.searchSource = [self.dataSource filteredArrayUsingPredicate:predicate];
    //刷新列表
    [self.mTableView reloadData];
}

- (void)headerRefresh{
    [SVProgressHUD showWithStatus:@"加载中…"];
    NSDictionary *params = [NSDictionary dictionaryWithObjects:@[Uid,@"ios",@(1)] forKeys:@[@"uuid",@"os",@"locate"]];
    __weak typeof(self) weakSelf = self;
    [URLRequest postWithURL:@"address/list" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        responseObject = responseObject?[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]:nil;
        PXDALog(@"%@",responseObject);
        weakSelf.dataSource = [MyAddressModel mj_objectArrayWithKeyValuesArray:responseObject];
        [weakSelf.mTableView reloadData];
        [weakSelf.mTableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"加载失败"];
        [SVProgressHUD dismiss];
    }];
}

#pragma mark =====================MyAddressCellDelegate========================

- (void)addressCell:(MyAddressCell *)cell buttonClickType:(MyAddressCellButtonType)actionType{
    if (actionType == MyAddressCellButtonTyp_Edite) {
        //编辑地址
        EditeAddressVC *vc = [EditeAddressVC new];
        vc.model = cell.model;
        [self.navigationController pushViewController:vc animated:YES ];
    }else{
        //删除地址
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"您确定要删除该地址？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alertView.tag = [cell.model.mine_id integerValue];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //删除地址
        [SVProgressHUD showWithStatus:@"请稍候…"];
        [URLRequest postWithURL:@"address/del" params:@{@"uuid":Uid,@"locate":@(1),@"os":@"ios",@"channelId":@"",@"id":@(alertView.tag)} success:^(NSURLSessionDataTask *task, id responseObject) {
            responseObject = responseObject ? [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] : nil;
            if ([responseObject isEqualToString:@"\'ok\'"]) {
                //删除成功
                [SVProgressHUD dismiss];
                [self.mTableView.mj_header beginRefreshing];
            }else{
                [SVProgressHUD showErrorWithStatus:@"服务器打盹了……"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD showErrorWithStatus:@"服务器打盹了……"];
        }];
    }
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.isSearching ? self.searchSource.count : self.dataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyAddressCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[MyAddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = self.isSearching ? self.searchSource[indexPath.row] : self.dataSource[indexPath.row];
    cell.delegate = self;
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_SelMyAddressBlock) {
        [SVProgressHUD showWithStatus:@"请稍候……"];
        MyAddressModel *model = self.dataSource[indexPath.row];
        [URLRequest postWithURL:@"address" params:@{@"uuid":Uid,@"locate":@(1),@"channelId":@"",@"os":@"ios",@"id":model.mine_id} success:^(NSURLSessionDataTask *task, id responseObject) {
            responseObject = responseObject?[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]:nil;
            MyAddressModel *selModel = [MyAddressModel mj_objectWithKeyValues:responseObject];
            _SelMyAddressBlock(selModel);
            [SVProgressHUD dismiss];
            [self.navigationController popViewControllerAnimated:YES];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }else{
        //编辑地址
        EditeAddressVC *vc = [EditeAddressVC new];
        vc.model = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:vc animated:YES ];
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.isSearching ? self.searchSource[indexPath.row] : self.dataSource[indexPath.row];
    return [self.mTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[MyAddressCell class] contentViewWidth:PX_SCREEN_WIDTH];
}

@end
