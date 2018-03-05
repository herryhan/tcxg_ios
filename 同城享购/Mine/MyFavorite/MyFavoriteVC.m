//
//  MyFavoriteVC.m
//  同城享购
//
//  Created by qipx on 2018/3/2.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "MyFavoriteVC.h"

@interface MyFavoriteVC ()<UITableViewDelegate,UITableViewDataSource>
//** tableView */
@property (nonatomic,weak) UITableView * mTableView;
//** dataSource */
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation MyFavoriteVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:PX_COLOR_HEX(@"ffffff"),NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"我的收藏";
    
    [self setupView];
}

- (void)setupView{
    UITableView *view = [UITableView new];
    [self.view addSubview:view];
    view.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    view.delegate = self;
    view.dataSource = self;
    view.tableFooterView = [UIView new];
    [view registerClass:[UITableViewCell class] forCellReuseIdentifier:cellId];
    view.mj_header = [PXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    self.mTableView = view;
    [self.mTableView.mj_header beginRefreshing];
}

- (void)headerRefresh{
    [SVProgressHUD showWithStatus:@"加载中…"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.mTableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    });
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

static NSString *cellId = @"cellId";

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    
    return cell;
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSMutableArray *)dataSource{
    return PX_LAZY(_dataSource, ({
        NSMutableArray *array = [NSMutableArray new];
        array;
    }));
}

@end
