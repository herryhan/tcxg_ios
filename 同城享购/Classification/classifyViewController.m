//
//  classifyViewController.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "classifyViewController.h"
#import "CateModel.h"
#import "CateCollectionCell.h"
#import "CateCollectionHeaderview.h"

@interface classifyViewController ()<UITableViewDataSource,UITableViewDelegate,UICollectionViewDelegate,
UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UIView *_backView;
    UIView *_lightView;
}
@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) UICollectionView *mCollectionView;
@property (nonatomic,strong) NSArray *classSource;
@property (nonatomic,strong) NSMutableArray *goodSource;

@end

@implementation classifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self getData];
    self.navigationItem.title = @"分类";
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:PX_COLOR_HEX(@"ffffff"),NSForegroundColorAttributeName, nil]];
}

- (void)getData{
    //获取顶级分类接口
    [SVProgressHUD show];
    [URLRequest postWithURL:@"type/new/list" params:@{@"uuid":Uid,@"os":@"ios",@"locate":@(1)} success:^(NSURLSessionDataTask *task, id responseObject) {
        responseObject = responseObject?[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]:nil;
        NSArray *array = [responseObject objectForKey:@"list"];
        self.classSource = [CateModel mj_objectArrayWithKeyValuesArray:array];
        [self.mTableView reloadData];
        [self.mTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        [self tableView:self.mTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        PXDALog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"服务器打盹了，请稍后……"];
    }];
}

# pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.classSource.count;
}

static NSString *tableViewCellId = @"tableViewCell";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableViewCellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellId];
    }
    CateModel *model = [self.classSource objectAtIndex:indexPath.row];
    cell.textLabel.font =Font(15);
    cell.textLabel.textColor = PX_COLOR_HEX(@"333333");
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.text = model.cate_name;
    return cell;
}

# pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *view = cell.selectedBackgroundView;
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 1, view.width, view.height-2)];
    _backView.backgroundColor = PX_COLOR_HEX(@"ffffff");
    _lightView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 8, 48)];
    _lightView.backgroundColor = PX_COLOR_HEX(@"57e038");
    [view addSubview:_backView];
    [_backView addSubview:_lightView];
    CateModel *model = [self.classSource objectAtIndex:indexPath.row];
    [self getCollectionData:model];
}

- (void)getCollectionData:(CateModel *)model{
    [SVProgressHUD show];
    [URLRequest postWithURL:@"subtype/new/list" params:@{@"uuid":Uid,@"id":@(model.cate_id)} success:^(NSURLSessionDataTask *task, id responseObject) {
        responseObject = responseObject?[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]:nil;
        NSArray *array = [responseObject objectForKey:@"list"];
        self.goodSource = [NSMutableArray arrayWithArray:[SecCateModel mj_objectArrayWithKeyValuesArray:array]];
        [self.mCollectionView reloadData];
        [SVProgressHUD dismiss];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        PXDALog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"服务器打盹了，请稍后……"];
    }];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

-(UITableView *)mTableView{
    return PX_LAZY(_mTableView, ({
        _mTableView = [[UITableView alloc] init];
        [self.view addSubview:_mTableView];
        _mTableView.sd_layout
            .leftSpaceToView(self.view, 0)
            .topSpaceToView(self.view, 0)
            .bottomSpaceToView(self.view, 0)
            .widthIs(100);
        _mTableView.delegate = self;
        _mTableView.dataSource = self;
        _mTableView.separatorInset = UIEdgeInsetsZero;
        _mTableView.tableFooterView = [UIView new];
        _mTableView.backgroundColor = PX_COLOR_HEX(@"efefef");
        [_mTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:tableViewCellId];
        _mTableView;
    }));
}

#pragma UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.goodSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    SecCateModel *model = [self.goodSource objectAtIndex:section];
    return model.cate_list.count;
}

static NSString *collectionCellId = @"collectionCell";

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CateCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:collectionCellId forIndexPath:indexPath];
    SecCateModel *kmodel = [self.goodSource objectAtIndex:indexPath.section];
    SecCateSecModel *model = [kmodel.cate_list objectAtIndex:indexPath.row];
    cell.model = model;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *view = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CateCollectionHeaderview *v = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellid" forIndexPath:indexPath];
        SecCateModel *model = [self.goodSource objectAtIndex:indexPath.section];
        v.name = model.cate_name;
        view = v;
    }
    return view;
}

- (UICollectionView *)mCollectionView{
    return PX_LAZY(_mCollectionView, ({
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        _mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [self.view addSubview:_mCollectionView];
        _mCollectionView.sd_layout
            .leftSpaceToView(self.mTableView, 0)
            .rightSpaceToView(self.view, 0)
            .topSpaceToView(self.view, 0)
            .bottomSpaceToView(self.view, 0);
        _mCollectionView.delegate = self;
        _mCollectionView.dataSource = self;
        _mCollectionView.backgroundColor = PX_COLOR_HEX(@"ffffff");
        [_mCollectionView registerClass:[CateCollectionCell class] forCellWithReuseIdentifier:collectionCellId];
        [_mCollectionView registerClass:[CateCollectionHeaderview class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"cellid"];
        _mCollectionView;
    }));
}

- (NSMutableArray *)goodSource{
    if (!_goodSource) {
        _goodSource = [NSMutableArray new];
    }
    return _goodSource;
}

#pragma UICollectionDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    CateCollectionCell *cell = (CateCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    SecCateSecModel *model = cell.model;
    PXDALog(@"%@",model);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(collectionView.width, 30);
}

@end
