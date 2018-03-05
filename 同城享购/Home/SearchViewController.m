//
//  SearchViewController.m
//  TFSearchBar
//
//  Created by TF_man on 16/5/18.
//  Copyright © 2016年 TF_man. All rights reserved.
//

//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//屏幕宽和高


#import "SearchViewController.h"
#import "TableViewCell.h"

@interface SearchViewController ()<UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) UIView *statusBar;

@property (strong, nonatomic) UISearchBar *searchBar;

@property (strong, nonatomic) NSMutableArray *allDataSource;/**<整个数据源*/

@property (strong, nonatomic) NSMutableArray *allData;/**<一维整个数*/

@property (strong, nonatomic) NSMutableArray *resultData;/**<一维查找的结果*/

@property (strong, nonatomic) NSMutableArray *indexDataSource;/**<索引数据源*/

@property (nonatomic,strong)UITableView *tv;

@property (nonatomic,strong)UITableView *tv2;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    // 设置导航栏左侧按钮
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 0, 40, 30);
    [leftBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = LeftBarButton;
    
    self.navigationItem.rightBarButtonItem = nil;
    
//    [self.tv setTableHeaderView:self.searchController.searchBar];
    
    //添加UITableView
    [self.view addSubview:self.tv2];

    //[self.view addSubview:self.searchBar];
    self.navigationItem.titleView = self.searchBar;
    
    //添加UITableView
    [self.view addSubview:self.tv];
    
//    self.tv.sectionIndexColor = [UIColor brownColor];
    self.tv.sectionIndexBackgroundColor = RGBA(235, 235, 235, 0);
//    self.tv.sectionIndexTrackingBackgroundColor = [UIColor blueColor];
    
    
    
    [self GetDataFromPlistFiles];
}



#pragma mark -------懒加载

- (UITableView *)tv{
    
    if (!_tv) {
        
        _tv = [[UITableView alloc]initWithFrame:CGRectMake(0, 104, kScreenWidth, kScreenHeight)];
        _tv.delegate = self;
        _tv.dataSource = self;
        
        
        [_tv registerClass:[TableViewCell class] forCellReuseIdentifier:@"TableViewCellID"];
        
        
    }
    
    return _tv;
}

- (UITableView *)tv2{
    
    if (!_tv2) {
        
        _tv2 = [[UITableView alloc]initWithFrame:CGRectMake(0, 104-44, kScreenWidth, kScreenHeight)];
        _tv2.delegate = self;
        _tv2.dataSource = self;
   
    }
    
    return _tv2;
}

#pragma mark -------从plist文件获取数据

- (void)GetDataFromPlistFiles{
    
    self.allDataSource = [NSMutableArray array];
    self.indexDataSource = [NSMutableArray array];
    self.allData = [NSMutableArray array];
    self.resultData = [NSMutableArray array];
    
    //
    NSString *plistPath2 = [[NSBundle mainBundle]pathForResource:@"Property List" ofType:@"plist"];
    NSDictionary *dic2 = [[NSDictionary alloc]initWithContentsOfFile:plistPath2];
    NSArray *arr2 = [dic2 allKeys];
    arr2 = [arr2 sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    
    for (NSString *str  in arr2) {
        
        [self.indexDataSource addObject:str];
        NSArray *array = dic2[str];
        [self.allDataSource addObject:array];

    }
    
    //所有的城市
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"cityDictionary" ofType:@"plist"];
    NSDictionary *dic = [[NSDictionary alloc]initWithContentsOfFile:plistPath];
    NSArray *arr = [dic allKeys];
    arr = [arr sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2){
        NSComparisonResult result = [obj1 compare:obj2];
        return result==NSOrderedDescending;
    }];
    for (NSString *str  in arr) {

        [self.indexDataSource addObject:str];
        NSArray *array = dic[str];
        [self.allDataSource addObject:array];
        [self.allData addObjectsFromArray:array];
     
    }
    
    [self.tv reloadData];
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, 44)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索";
        _searchBar.showsCancelButton = NO;
    }
    return _searchBar;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView == self.tv2) {
        
        return 1;
        
    }
    return self.allDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (tableView == self.tv2) {
        
        return self.resultData.count;
        
    }else{
        
        
        if (section > 2) {
            
            NSArray *array = self.allDataSource[section];
            
            return array.count;
            
        }else{
            
            return 1;
        }
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.tv2) {
        
        static NSString *cellID = @"cellID2";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        cell.textLabel.text = self.resultData[indexPath.row];
        
        return cell;
        
    }else{
        
        if (indexPath.section > 2) {
            
            static NSString *cellID = @"cellID";
            
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            
            if (!cell) {
                
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
                
            }
            NSArray *array = self.allDataSource[indexPath.section];
            cell.textLabel.text = array[indexPath.row];
            
            return cell;
            
        }else{
            
            TableViewCell*cell = [tableView dequeueReusableCellWithIdentifier:@"TableViewCellID" forIndexPath:indexPath];
           // cell.delegate = self;
            NSArray *array = self.allDataSource[indexPath.section];
          //  cell.cellArr = array;
            return cell;
        }
    }

}

//右侧索引列表
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {

    if (tableView == self.tv) {
        
        NSMutableArray *mutArr = [NSMutableArray array];
        [mutArr addObjectsFromArray:(NSArray *)self.indexDataSource];
        [mutArr replaceObjectAtIndex:0 withObject:@"定位"];
        [mutArr replaceObjectAtIndex:1 withObject:@"最近"];
        [mutArr replaceObjectAtIndex:2 withObject:@"热门"];
        
        return mutArr;
    }else{
        
        return nil;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 取消选中状态
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (![cell isKindOfClass:[TableViewCell class]]) {
        
        [UIView animateWithDuration:0.5 animations:^{
            
            
            [_searchBar resignFirstResponder];
            
        } completion:^(BOOL finished) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
                if (self.succeed) {
                    self.succeed(cell.textLabel.text);
                }
                
            }];
        }];
        
        
    }

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.tv) {
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.backgroundColor = RGBA(235, 235, 235, 1);
        UILabel *lb = [UILabel new];
        lb.center = CGPointMake(25, 10);
        lb.text = self.indexDataSource[section];
        [lb sizeToFit];
        [view addSubview:lb];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
        
    if (indexPath.section > 2) {
        
        return 40;
        
    }else{
        
        NSArray *array = self.allDataSource[indexPath.section];
        return array.count/3*45+60;
        
    }
        
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (tableView == self.tv2) {
        
        return 0.001;
    }
    return 40;
}


#pragma mark - UISearchDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
//    self.allData
    [self.resultData removeAllObjects];
    //一维查找
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains [cd] %@", searchText];
    
    NSArray *filterdArray = [(NSArray *)self.allData filteredArrayUsingPredicate:predicate];
    
    [self.resultData addObjectsFromArray:filterdArray];
    
    [self.view bringSubviewToFront:self.tv2];
    [self.tv2 reloadData];
    
    
    
}


- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    
    
    //仅供参考
//   // self.statusBar = [[UIView alloc]initWithFrame:CGRectMake(0, 45, kScreenWidth, 21)];
//    self.statusBar.backgroundColor = RGBA(201, 201, 206, 1);
//    [self.view addSubview:self.statusBar];
//    [UIView animateWithDuration:0.3 animations:^{
//
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        self.tv.frame = CGRectMake(0, 104-44, kScreenWidth, kScreenHeight);
////        self.tv2.frame = CGRectMake(0, 104-44, kScreenWidth, kScreenHeight-22);
//        _searchBar.frame = CGRectMake(0, 20, kScreenWidth, 44);
//        self.statusBar.frame = CGRectMake(0, 0, kScreenWidth, 21);
//        _searchBar.showsCancelButton = YES;
//
//
//    }];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    _searchBar.showsCancelButton = NO;
    [_searchBar resignFirstResponder];
    _searchBar.text = @"";
    [UIView animateWithDuration:0.3 animations:^{
        
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        self.tv.frame = CGRectMake(0, 104, kScreenWidth, kScreenHeight);
        _searchBar.frame = CGRectMake(0, 64, kScreenWidth, 44);
        [self.statusBar removeFromSuperview];
        
        [self.view sendSubviewToBack:self.tv2];
    }];

}

- (void)cancelBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}

#pragma mark -------TFTableViewDlegate

- (void)TableViewSelectorIndix:(NSString *)str{
    
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (self.succeed) {
            self.succeed(str);
        }
        
    }];
    
}

@end
