//
//  classfyBaseViewController.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/15.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "classfyBaseViewController.h"
#import "homeModel.h"
#import "homeTableViewCell.h"
#import "YYFPSLabel.h"
#import "NSObject+YYModel.h"
#import "nearShopTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "shopViewController.h"
#import "classSearchView.h"
#import "UIViewController+BarButton.h"
#import "classHeadView.h"
#import "subClassView.h"
#import "subClassModel.h"

@interface classfyBaseViewController ()<AMapLocationManagerDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSInteger currentPage;
}
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) UITableView *homeTableView;
@property (nonatomic,strong) YYFPSLabel *fpsLabel;
@property (nonatomic,strong) AMapLocationManager *locationManager;
@property (nonatomic,strong) NSMutableDictionary *cellHeightDic;
@property (nonatomic,strong) classSearchView *classSearchView;
@property (nonatomic,strong) classHeadView *classHeadView;
@property (nonatomic,strong) subClassView *subClassView;
@property (nonatomic,strong) UIView *tableHeadView;
@property (nonatomic,strong) UIImageView *classThemeImageView;

@property float lat;
@property float lon;
@property CGFloat currentContentOffset;
@property CGFloat lastContentOffset;
@property CGFloat currentY;

@property BOOL isAsHeadView;//判断此时的subclassview 是否作为tableview的headerview
@property BOOL isPullOnView;

@end

@implementation classfyBaseViewController

//主题图片
- (UIImageView *)classThemeImageView{
    if (!_classThemeImageView) {
        _classThemeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight+55, SCREEN_WIDTH-20, 120)];
        _classThemeImageView.backgroundColor = [UIColor redColor];
        _classThemeImageView.layer.cornerRadius = 5;
        _classThemeImageView.layer.masksToBounds = YES;
        _classSearchView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _classThemeImageView;
}

//headview
- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight+55+138+130+5)];
        _tableHeadView.backgroundColor = [UIColor whiteColor];
    }
    return _tableHeadView;
}
//子分类
- (subClassView *)subClassView{
    if (!_subClassView) {
        _subClassView = [[subClassView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+55+130, SCREEN_WIDTH, 138)];
    }
    return _subClassView;
}

//头部
- (classHeadView *)classHeadView{
    if (!_classHeadView) {
        _classHeadView = [[classHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
    }
    return _classHeadView;
}

- (classSearchView *)classSearchView{
    if (!_classSearchView) {
        _classSearchView = [[classSearchView alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight+10, SCREEN_WIDTH-20, 35)];
        _classSearchView.backgroundColor = UIColorFromRGBA(230, 230, 230, 0.7);
        _classSearchView.layer.cornerRadius = 5;
    }
    return _classSearchView;
}

- (NSMutableDictionary *)cellHeightDic{
    if (!_cellHeightDic) {
        _cellHeightDic = [[NSMutableDictionary alloc]init];
    }
    return _cellHeightDic;
}

- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (UITableView *)homeTableView{
    
    if (!_homeTableView) {
        _homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _homeTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//iPhoneX这里是88
            _homeTableView.scrollIndicatorInsets = _homeTableView.contentInset;
        }else{
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        [_homeTableView registerClass:[nearShopTableViewCell class] forCellReuseIdentifier:@"nearShopTableViewCell"];
       // [_homeTableView settab :SafeAreaTopHeight+55];
        [self.view addSubview:_homeTableView];
    }
    return _homeTableView;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}
- (void)setLeftBar{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(10, SafeAreaTopHeight-7-30, 30, 30);
    [backBtn setImage:[UIImage imageNamed:@"icon_default_back_gray"] forState:UIControlStateNormal];
    [self.view addSubview:backBtn];
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];
    self.isAsHeadView = YES;
    self.isPullOnView = NO;
    self.currentY = SafeAreaTopHeight+55+130;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.classHeadView.classNameLabel.text = self.classfyName;
    [self.tableHeadView addSubview:self.subClassView];
    [self.tableHeadView addSubview:self.classThemeImageView];
    [self.homeTableView setTableHeaderView:self.tableHeadView];
    
   
//    [self.view addSubview:self.classThemeImageView];
//    [self.view addSubview:self.subClassView];
    [self.view addSubview:self.classHeadView];
    [self.view addSubview: self.classSearchView];
    
    [SVProgressHUD show];
    [self setLeftBar];
    [self getLocationData];
    [self getAdPictureRequest];
    [self getSubClass];
    currentPage = 1;
    [self settingRefresh];
    
}

//获取地理位置
- (void)getLocationData{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout =2;
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%lf ", location.coordinate.latitude);
        self.lat = location.coordinate.latitude;
        self.lon = location.coordinate.longitude;
        
        [self requestData];
        // [self.homeTableView.mj_header beginRefreshing];
        
    }];
}

- (void)settingRefresh{
    declareWeakSelf;
    //下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [weakSelf requestData];
    }];
    self.homeTableView.mj_header = header;
    
    //上拉加载更多
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
    self.homeTableView.mj_footer = footer;
    
}

-(void)loadMoreData{
    currentPage = currentPage+1;
    [self requestData];
}

//获取子分类
- (void)getSubClass{

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"typeId"] = self.classfyId;
    params[@"uuid"] = Uid;
    params[@"channelId"] = @"534523464545";
    params[@"os"] = @"ios";
    params[@"locate"] = @"1";
    [URLRequest postWithURL:@"subtype/list" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"subclass:%@",[cityShoppingTool jsonConvertToDic:responseObject]);
        NSMutableArray *subclassArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[subClassModel class] json:[cityShoppingTool jsonConvertToDic:responseObject]]];
    
        for (int i = 0; i<subclassArray.count; i++) {
            subClassModel *model = subclassArray[i];
            if (i == 0) {
                model.isSelected = YES;
            }else{
                model.isSelected = NO;
            }
            [subclassArray replaceObjectAtIndex:i withObject:model];
        }
        
        [self.subClassView setSubClassArrayData:subclassArray];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//该分类下的广告位
- (void)getAdPictureRequest{

    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    params[@"typeId"] = self.classfyId;
    params[@"uuid"] = Uid;
    params[@"channelId"] = @"534523464545";
    params[@"os"] = @"ios";
    params[@"locate"] = @"1";
    [URLRequest postWithURL:@"type/ad" params:params success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",[cityShoppingTool jsonConvertToDic:responseObject]);
        [self.classThemeImageView sd_setImageWithURL:[NSURL URLWithString:[cityShoppingTool jsonConvertToDic:responseObject][@"adPic"]]];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
//该分类下的商家
- (void)requestData{
    
    NSString *requestUrl = [NSString stringWithFormat:@"http://ha.tongchengxianggou.com/api/shop/list?locate=1&max=10&la=%lf&lo=%lf&page=%ld&orderby=%ld&typeId=%@",self.lat,self.lon,currentPage,[self.orderByNum integerValue],self.classfyId];
    
    [URLRequest getWithURL:requestUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"df:%@",[cityShoppingTool jsonConvertToDic:responseObject]);
        if (currentPage == 1) {
            [self.dataArray removeAllObjects];
            self.dataArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[homeModel class] json:[cityShoppingTool jsonConvertToDic:responseObject][@"list"]]];
            [self.homeTableView.mj_header endRefreshing];
            [MBProgressHUD hideHUD];
        }else{
            
            NSArray * tempArray = [NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[homeModel class] json:[cityShoppingTool jsonConvertToDic:responseObject][@"list"]]];
            [self.dataArray addObjectsFromArray:tempArray];
            if (tempArray.count == 0) {
                
                [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
            }else{
                [self.homeTableView.mj_footer endRefreshing];
            }
        }
        
        [self.homeTableView fd_reloadDataWithoutInvalidateIndexPathHeightCache];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [MBProgressHUD hideHUD];
        [self.homeTableView.mj_header endRefreshing];
        
    }];
    
}
//tableViewDelegate
// 设置单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

// 设置单元格
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    nearShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"nearShopTableViewCell" forIndexPath:indexPath];
    
    cell.model = self.dataArray[indexPath.row];
    if (indexPath.section == self.dataArray.count-1) {
        [self loadMoreData];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat cellHeight;
//    NSNumber* cellHeightNumber = [self.cellHeightDic objectForKey:@(indexPath.row)];
//    if (cellHeightNumber) {//判断是否缓存了该cell的高度
//        cellHeight = [cellHeightNumber floatValue];
//    }else{
        cellHeight =[tableView fd_heightForCellWithIdentifier:@"nearShopTableViewCell" cacheByIndexPath:indexPath configuration:^(nearShopTableViewCell * cell) {
            
            cell.model = self.dataArray[indexPath.row];
    
//
       }];//通过类方法获取cell高度
    //     [self.cellHeightDic  setObject:@(cellHeight) forKey:@(indexPath.row)];//以indexPath为key存储cell高度
    //  }
    return cellHeight;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    shopViewController *shopView = [[shopViewController alloc]init];
    shopView.shopModel = self.dataArray[indexPath.row];
    
    shopView.lat = self.lat;
    shopView.lon = self.lon;
    
    [self.navigationController pushViewController:shopView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%lf",scrollView.contentOffset.y);

    if (scrollView.contentOffset.y>55+130+98) {
        if (!self.isAsHeadView) {
            NSLog(@"shengqi le ");
            [self.subClassView removeFromSuperview];
            self.subClassView.frame = CGRectMake(0, SafeAreaTopHeight-98, SCREEN_WIDTH, 138);
            [self.view insertSubview:self.subClassView aboveSubview:self.homeTableView];
            self.isAsHeadView = YES;
        }
        if (self.lastContentOffset - scrollView.contentOffset.y >=5) {
                [UIView animateWithDuration:0.2 animations:^{
                     self.subClassView.frame = CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 138);
                }];
             self.currentY = SafeAreaTopHeight;
            }
        if (scrollView.contentOffset.y - self.lastContentOffset >=5) {
                [UIView animateWithDuration:0.2 animations:^{
                    self.subClassView.frame = CGRectMake(0, SafeAreaTopHeight - 98, SCREEN_WIDTH, 138);
                }];
            
        }
       
       // [self.view addSubview:self.subClassView];
    }else{
        if (self.isAsHeadView) {
            if (self.currentY == SafeAreaTopHeight) {
                if (scrollView.contentOffset.y<=55+130) {
                    [self.subClassView removeFromSuperview];
                    self.subClassView.frame = CGRectMake(0, SafeAreaTopHeight+55+130, SCREEN_WIDTH, 138);
                    [self.tableHeadView addSubview:self.subClassView];
                    self.currentY = SafeAreaTopHeight+55+130;
                    self.isAsHeadView = NO;
                }
            }else{
                [self.subClassView removeFromSuperview];
                self.subClassView.frame = CGRectMake(0, SafeAreaTopHeight+55+130, SCREEN_WIDTH, 138);
                [self.tableHeadView addSubview:self.subClassView];
                self.currentY = SafeAreaTopHeight+55+130;
                self.isAsHeadView = NO;
            }
            
        }

    }
//
    if (scrollView.contentOffset.y>=0) {
        if (scrollView.contentOffset.y>=47) {
            [UIView animateWithDuration:0.2f animations:^{
                 self.classSearchView.frame = CGRectMake(10+47*0.8+3,SafeAreaTopHeight+10-47, SCREEN_WIDTH-20-47*0.8-3, 30);
            }];
            self.classHeadView.alpha = 1;
        }else{
           // [UIView animateWithDuration:0.2f animations:^{
               self.classSearchView.frame = CGRectMake(10+scrollView.contentOffset.y*0.8,SafeAreaTopHeight+10-scrollView.contentOffset.y, SCREEN_WIDTH-20-scrollView.contentOffset.y*0.8, 35-scrollView.contentOffset.y/47*5);
          //  }];
        }
        self.classHeadView.classNameLabel.alpha = 1-scrollView.contentOffset.y/40;
        if (scrollView.contentOffset.y==0) {
            self.classHeadView.alpha = 1;
        }
    }else{
       // [UIView animateWithDuration:0.2f animations:^{
         self.classSearchView.frame = CGRectMake(10,SafeAreaTopHeight+10-scrollView.contentOffset.y, SCREEN_WIDTH-20, 35);
         self.classHeadView.alpha = 1+scrollView.contentOffset.y/40;
      //  }];
    }
}
-(void)scrollViewWillBeginDragging:(UIScrollView*)scrollView{
    
    self.lastContentOffset = scrollView.contentOffset.y;
    NSLog(@"eferfr:%lf",scrollView.contentOffset.y);
    
}
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    
}

@end
