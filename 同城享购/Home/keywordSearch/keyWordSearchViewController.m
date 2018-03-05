//
//  keyWordSearchViewController.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/9.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "keyWordSearchViewController.h"
#import "UIViewController+BarButton.h"
#import "searchView.h"
#import "searchSubView.h"
#import "BGFMDB.h"
#import "homeModel.h"
#import "homeTableViewCell.h"
#import "YYFPSLabel.h"
#import "NSObject+YYModel.h"
#import "nearShopTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "searchByClassView.h"

@interface keyWordSearchViewController ()<UITextFieldDelegate,UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) searchView *searchView;
@property (nonatomic,strong) searchSubView *subSearchView;
@property (nonatomic,strong) NSMutableArray *hotsArray;
@property (nonatomic,strong) NSMutableArray *historyArray;
@property (nonatomic,strong) UIScrollView *contentScrollView;

@property (nonatomic,strong) NSMutableArray *searchResultArray;
@property (nonatomic,strong) UITableView *searchResultTableView;
@property (nonatomic,strong) searchByClassView *BtnClassView;
@property NSInteger classTag;

@end

@implementation keyWordSearchViewController 

- (searchByClassView *)BtnClassView{
    declareWeakSelf;
    if (!_BtnClassView) {
        _BtnClassView = [[searchByClassView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        [_BtnClassView setOrderTag:^(NSInteger tag) {
            NSLog(@"%ld",tag);
            weakSelf.classTag = tag;
            [weakSelf getSearchByKeyWords:weakSelf.searchView.contentText.text andSortType:tag-100];
        }];
    }
    return _BtnClassView;
}

- (UITableView *)searchResultTableView{
    
    if (!_searchResultTableView) {
        
        _searchResultTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight-40) style:UITableViewStylePlain];
        _searchResultTableView.delegate = self;
        _searchResultTableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _searchResultTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            //_searchResultTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//iPhoneX这里是88
            _searchResultTableView.scrollIndicatorInsets = _searchResultTableView.contentInset;
        }else{
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        _searchResultTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

        [_searchResultTableView registerClass:[nearShopTableViewCell class] forCellReuseIdentifier:@"nearShopTableViewCell"];
    }
    return _searchResultTableView;
}

- (NSMutableArray *)searchResultArray{
    if (!_searchResultArray) {
        _searchResultArray = [[NSMutableArray alloc]init];
    }
    return _searchResultArray;
}

- (UIScrollView *)contentScrollView{
    if (!_contentScrollView) {
        
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight)];
      //  _contentScrollView.backgroundColor = [UIColor clearColor];
        _contentScrollView.delegate = self;
        
    }
    return _contentScrollView;
}

- (NSMutableArray *)historyArray{
    
    if (!_historyArray) {
        _historyArray = [[NSMutableArray alloc]init];
    }
    return _historyArray;
    
}

- (NSMutableArray *)hotsArray{
    
    if (!_hotsArray) {
        _hotsArray = [[NSMutableArray alloc]init];
    }
    return _hotsArray;
    
}

- (searchSubView *)subSearchView{
    declareWeakSelf;
    if (!_subSearchView) {
        
        _subSearchView = [[searchSubView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_subSearchView setClearHistorySearch:^{
            NSLog(@"sffw");
            [NSArray bg_clearArrayWithName:@"historyArray"];
            [weakSelf configHistory];
            [weakSelf.searchView.contentText resignFirstResponder];
        }];
    }
    return _subSearchView;
}

- (searchView *)searchView{
    if (!_searchView) {
        
        _searchView = [[searchView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-44*2, 30)];
        _searchView.intrinsicContentSize = CGSizeMake(SCREEN_WIDTH-44*2, 30);
        _searchView.contentText.delegate = self;
    }
    return _searchView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(247, 247, 247, 1);
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:UIColorFromRGBA(250, 250, 250, 1) andSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    [self configBarItem];
    [self getHotList];
    
    [self.view addSubview:self.contentScrollView];
    self.contentScrollView.hidden = YES;
    [self.view addSubview:self.searchResultTableView];
    self.searchResultTableView.hidden = YES;
    [self.view addSubview:self.BtnClassView];
    self.BtnClassView.hidden = YES;
    [self.searchView.contentText addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}
- (void)configHistory{
    [self.historyArray removeAllObjects];
    [self.historyArray addObjectsFromArray:[NSArray bg_arrayWithName:@"historyArray"]];
    if (self.historyArray.count == 0) {
      //  [self.historyArray addObject:@"无搜索历史"];
        self.subSearchView.historyBgView.hidden = YES;
    }else{
        self.subSearchView.historyBgView.hidden = NO;
        [self.subSearchView.historyTagView setTagArray:self.historyArray];
    }
    if(self.subSearchView.hotSearchConstraint.constant+self.subSearchView.historySearchConstraint.constant+20 >SCREEN_HEIGHT-SafeAreaTopHeight) {
        
        self.contentScrollView.contentSize =CGSizeMake(SCREEN_WIDTH, self.subSearchView.hotSearchConstraint.constant+self.subSearchView.historySearchConstraint.constant+20);
        
    }else{
        self.contentScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaTopHeight+1);
    }
    self.subSearchView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.subSearchView.hotSearchConstraint.constant+self.subSearchView.historySearchConstraint.constant+20);
}

- (void)getHotList{
    [URLRequest postWithURL:@"search/list" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"%@",responseObject);
        NSLog(@"%@",[cityShoppingTool jsonConvertToDic:responseObject]);
        [self.hotsArray addObjectsFromArray:[cityShoppingTool jsonConvertToDic:responseObject][@"hots"]];
        [self.subSearchView.hotTagView setTagArray:self.hotsArray];
        self.contentScrollView.hidden = NO;
        [self configHistory];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)configBarItem{
    
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"icon_default_back_gray"] action:@selector(back)];
    [self addRightBarButtonItemWithTitle:@"搜索" andWidth:44 action:@selector(search)];
    self.navigationItem.titleView = self.searchView;
    [self.contentScrollView addSubview:self.subSearchView];
   
}
- (void)search{
    [self.searchView.contentText resignFirstResponder];
    NSString *searchString;
    BOOL isExist = NO;
    
    if (self.searchView.contentText.text.length == 0) {
        searchString = self.searchView.contentText.placeholder;
    }else{
        searchString = self.searchView.contentText.text;
    }
    
    for (NSString *keyString in [NSArray bg_arrayWithName:@"historyArray"]) {
        if ([keyString isEqualToString:searchString]) {
            isExist = YES;
            break;
        }
    }
    if (!isExist){
        [NSArray bg_addObjectWithName:@"historyArray" object:searchString];
    }
    [self configHistory];
    [self getSearchByKeyWords:searchString andSortType:self.classTag-100];
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleDefault;
    
}
- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

   // [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma textdelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.searchView.contentText resignFirstResponder];
    NSString *searchString;
    BOOL isExist = NO;
    
    if (textField.text.length == 0) {
        searchString = textField.placeholder;
    }else{
        searchString = textField.text;
    }

    for (NSString *keyString in [NSArray bg_arrayWithName:@"historyArray"]) {
            if ([keyString isEqualToString:searchString]) {
                isExist = YES;
                break;
            }
    }
    if (!isExist){
         [NSArray bg_addObjectWithName:@"historyArray" object:searchString];
    }
    
    [self configHistory];
    [self getSearchByKeyWords:searchString andSortType:0];
    
    return YES;
}
- (void)getSearchByKeyWords:(NSString *)keywords andSortType:(NSInteger)type{
    [SVProgressHUD show];
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"max"] = @(10);
    parmas[@"la"] = @(self.lat);
    parmas[@"lo"] = @(self.lon);
    parmas[@"keywords"] = keywords;
    parmas[@"uuid"] = [keepUserInfoHandle readUserInfoWith:1];
    parmas[@"channelId"] = @"";
    parmas[@"os"] = @"ios";
    parmas[@"locate"] = @(1);
    parmas[@"orderby"] = @(type);
    
    [URLRequest postWithURL:@"shop/search" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",[cityShoppingTool jsonConvertToDic:responseObject]);
        [SVProgressHUD dismiss];
        [self.searchResultArray removeAllObjects];
        self.searchResultArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[homeModel class] json:[cityShoppingTool jsonConvertToDic:responseObject][@"list"]]];
        [self.searchResultTableView reloadData];
        self.searchResultTableView.hidden = NO;
        self.BtnClassView.hidden = NO;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}
- (BOOL)becomeFirstResponder
{

    [super becomeFirstResponder];

    return [self.searchView.contentText becomeFirstResponder];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchView.contentText resignFirstResponder];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.searchView.contentText resignFirstResponder];
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    self.searchResultTableView.hidden = YES;
    self.BtnClassView.hidden = YES;
    return YES;
}

-(void)textFieldDidChange :(UITextField *)theTextField{
    if (theTextField.text.length == 0) {
        self.searchResultTableView.hidden= YES;
        self.BtnClassView.hidden = YES;
        [self.BtnClassView resetSelected];
    }
}

#pragma mark tableviewDelegate
//tableViewDelegate
// 设置单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.searchResultArray.count;
}

// 设置单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    nearShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearShopTableViewCell" forIndexPath:indexPath];
    cell.model = self.searchResultArray[indexPath.row];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [tableView fd_heightForCellWithIdentifier:@"nearShopTableViewCell" cacheByIndexPath:indexPath configuration:^(nearShopTableViewCell * cell){
        
        cell.model = self.searchResultArray[indexPath.row];
        
    }] ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//        shopViewController *shopView = [[shopViewController alloc]init];
//        shopView.shopModel = self.dataArray[indexPath.row];
//
//        shopView.lat = self.lat;
//        shopView.lon = self.lon;
//
//        [self.navigationController pushViewController:shopView animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
