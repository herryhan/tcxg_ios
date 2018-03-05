//
//  OrderListVC.m
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "OrderListVC.h"
#import "OrderTableCell.h"
#import "GoodsOrderInfoVC.h"
#import "GoodsCommentVC.h"

@interface OrderListVC ()<UITableViewDelegate,UITableViewDataSource,OrderTableCellDelegate>
//** tableView */
@property (nonatomic,weak) UITableView * mTableView;
//** datsSoure */
@property (nonatomic,strong) NSMutableArray * dataSource;
@end

@implementation OrderListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = PX_COLOR_HEX(@"ffffff");
    PXSingleLineView *lineView = [[PXSingleLineView alloc] initWithFrame:CGRectMake(0, 0, PX_SCREEN_WIDTH, .8f)];
    [self.view addSubview:lineView];
    [self setupView];
}

static NSString *cellId = @"cell";

- (void)setupView{
    UITableView *view = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    view.delegate = self;
    view.dataSource = self;
    [view registerClass:[OrderTableCell class] forCellReuseIdentifier:cellId];
    view.tableFooterView = [UIView new];
    view.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:view];
    view.sd_layout.spaceToSuperView(UIEdgeInsetsMake(44, 0, 0, 0));
    view.mj_header = [PXRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
    view.mj_footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefresh)];
    self.mTableView = view;
    [self.mTableView.mj_header beginRefreshing];
}

- (void)headerRefresh{
    NSString *URLString = @"order/list";
    NSDictionary *params = @{@"uuid":Uid,
                             @"locate":@"1",
                             @"os":@"ios",
                             @"type":@(_type),
                             @"channelId":@"5637447362195603251"};
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    [URLRequest postWithURL:URLString params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        responseObject = responseObject?[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]:nil;
        PXDALog(@"%@",responseObject);
        NSArray *array = [GoodsOrderModel mj_objectArrayWithKeyValuesArray:responseObject];
        weakSelf.dataSource = [NSMutableArray arrayWithArray:array];
        [weakSelf.mTableView reloadData];
        [weakSelf.mTableView.mj_header endRefreshing];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        PXDALog(@"%@",error);
    }];
}

- (void)footerRefresh{
    __weak typeof(self) weakSelf = self;
    [SVProgressHUD show];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakSelf.mTableView.mj_footer endRefreshing];
        [SVProgressHUD dismiss];
    });
}

#pragma mark UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[OrderTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.model = [self.dataSource objectAtIndex:indexPath.section];
    cell.delegate = self;
    return cell;
}

#pragma mark =====================OrderTableCellDelegate========================

- (void)orderTableCell:(OrderTableCell *)cell clickButtonType:(OrderTableCellButtonAction)buttonType{
    PXDALog(@"%s",__func__);
    if (buttonType == OrderTableCellButtonAction_Delete) {
        [SVProgressHUD showErrorWithStatus:@"删除订单"];
    }else{
        GoodsCommentVC *vc = [GoodsCommentVC new];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark UITableViewDelegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    GoodsOrderInfoVC *vc = [[GoodsOrderInfoVC alloc] init];
    vc.model = [self.dataSource objectAtIndex:indexPath.section];
    [self.navigationController pushViewController:vc animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    id model = self.dataSource[indexPath.section];
    return [self.mTableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[OrderTableCell class] contentViewWidth:PX_SCREEN_WIDTH];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5.0f;
}

#pragma mark LAZY
- (NSMutableArray *)dataSource{
    return PX_LAZY(_dataSource, ({
        NSMutableArray *array = [NSMutableArray new];
        array;
    }));
}


@end
