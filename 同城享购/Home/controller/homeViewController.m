//
//  homeViewController.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "homeViewController.h"
#import "hxwSearchBar.h"
#import "homeHeaderView.h"
#import "homeModel.h"
#import "homeTableViewCell.h"
#import "YYFPSLabel.h"
#import "NSObject+YYModel.h"
#import "nearShopTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "shopViewController.h"
#import "LoginViewController.h"
#import "UIViewController+BarButton.h"
#import "shopSearchViewController.h"
#import "citySelectedViewController.h"
#import "homeTopView.h"
#import "homeTopEffecialView.h"
#import "selectRecAddressViewController.h"
#import "keyWordSearchViewController.h"
#import "classfyBaseViewController.h"

@interface homeViewController ()<AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate, UITableViewDataSource>
{
    NSInteger currentPage;//当前页
    NSInteger currentClass;//当前选择的排序分类
}
@property (nonatomic,strong) hxwSearchBar *searchBar;//搜索框
@property (nonatomic,strong) homeHeaderView *homeHeaderView;//顶端view

@property (nonatomic,strong) NSMutableArray *dataArray;//数据源
@property (nonatomic,strong) UITableView *homeTableView;//tableview
@property (nonatomic, strong) YYFPSLabel *fpsLabel; //FPS流畅度检测
@property (nonatomic,strong) AMapLocationManager *locationManager;//高德地图类（用于获取地理位置）
@property (nonatomic,strong) UIButton *scanBtn;
@property (nonatomic,strong) UIButton *locationBtn;
@property (nonatomic, strong) AMapSearchAPI *search;

@property float lat;//经度
@property float lon;//纬度

@property (nonatomic,strong) homeTopEffecialView *homeTopView;
//保存当前 获取的周围地址
@property (nonatomic,strong)  NSMutableArray *addressAroundArray;

@end

@implementation homeViewController

- (NSMutableArray *)addressAroundArray{
    if (!_addressAroundArray) {
        _addressAroundArray = [[NSMutableArray alloc]init];
    }
    return _addressAroundArray;
}


- (homeTopEffecialView *)homeTopView{
    declareWeakSelf;
    if (!_homeTopView ) {
        _homeTopView = [[homeTopEffecialView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 105)];
        [_homeTopView setChangeLocatePress:^{
            selectRecAddressViewController *selectAddVc = [[selectRecAddressViewController alloc]init];
            selectAddVc.addressArray = weakSelf.addressAroundArray;
            selectAddVc.lat = weakSelf.lat;
            selectAddVc.lon = weakSelf.lon;
            [weakSelf.navigationController pushViewController:selectAddVc animated:YES];
            
            //处理位置选择返回值
            [selectAddVc setCallBackSelectedLocation:^(NSString *locateName, float selectLan, float selectLon) {
                weakSelf.homeTopView.locateNameLabel.text = locateName;
                weakSelf.lat = selectLan;
                weakSelf.lon = selectLon;
                [weakSelf searchLocationByCurrentLan:weakSelf.lat AndLon:weakSelf.lon];
            }];
        }];
        [_homeTopView setKeyWordSearch:^{
            
            keyWordSearchViewController *keyVc = [[keyWordSearchViewController alloc]init];
            keyVc.lat = weakSelf.lat;
            keyVc.lon = weakSelf.lon;
            [weakSelf.navigationController pushViewController:keyVc animated:YES];
            
        }];
        
    }
    return _homeTopView;
}

-(homeHeaderView *)homeHeaderView{
    
    declareWeakSelf;
    if (!_homeHeaderView) {
        _homeHeaderView = [[homeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210+SCREEN_WIDTH/5*2+10+10+200+10+91+10+100)];

        //点击分类排序的block（此处代码可以优化）
        [_homeHeaderView.nearShopView setSum:^(NSInteger index) {
            NSLog(@"first");
            currentPage = 1;
            currentClass =1;
      
            [weakSelf requestData];
        }];
        [_homeHeaderView.nearShopView setTopSale:^(NSInteger index) {
            currentPage = 1;
            currentClass = 2;
            NSLog(@"two");
            [weakSelf requestData];
        }];
        [_homeHeaderView.nearShopView setQunlity:^(NSInteger index) {
            currentPage = 1;
            currentClass = 3;
            NSLog(@"three");
            [weakSelf requestData];
        }];
        [_homeHeaderView.nearShopView setDistance:^(NSInteger index) {
            currentClass = 4;
            currentPage = 1;
            NSLog(@"four");
            [weakSelf requestData];
        }];
        
        //选择分类的class的block
        [_homeHeaderView setSelectedClassfy:^(NSNumber *classfyId,NSString *classfyName) {
            classfyBaseViewController *classfyVc = [[classfyBaseViewController alloc]init];
            classfyVc.classfyName = classfyName;
            classfyVc.classfyId = classfyId;
            
            [weakSelf.navigationController pushViewController:classfyVc animated:YES];
        }];
    }
    return _homeHeaderView;
}
//懒加载数据源
- (NSMutableArray *)dataArray{
    
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}

//懒加载tableview

- (UITableView *)homeTableView{
    
    if (!_homeTableView) {
       _homeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0 , SCREEN_WIDTH, SCREEN_HEIGHT-SafeAreaBottomHeight) style:UITableViewStylePlain];
        if (@available(iOS 11.0, *)) {
            _homeTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _homeTableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);//iPhoneX这里是88
            _homeTableView.scrollIndicatorInsets = _homeTableView.contentInset;
        }else{
            self.edgesForExtendedLayout = UIRectEdgeNone;
        }
        _homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _homeTableView.tag = 2001;
        _homeTableView.delegate = self;
        _homeTableView.dataSource = self;
        
        [_homeTableView registerClass:[nearShopTableViewCell class] forCellReuseIdentifier:@"nearShopTableViewCell"];
        
    }
    return _homeTableView;
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad{
    
    [super viewDidLoad];

    //初始化AMAP search
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    //定位
    [self getLocationData];
    currentPage = 1;
    currentClass = 1;

    self.homeTableView.tableHeaderView = self.homeHeaderView;
    [self settingRefresh];
    [self.view addSubview:self.homeTableView];
    [self.view addSubview:self.homeTopView];

}

//获取地理位置
- (void)getLocationData{
    
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    // 带逆地理信息的一次定位（返回坐标和地址信息）
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    //   定位超时时间，最低2s，此处设置为10s
    self.locationManager.locationTimeout =2;
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        NSLog(@"reg:%@",regeocode.POIName);
        self.homeTopView.locateNameLabel.text = regeocode.POIName;
        NSLog(@"location:%lf ", location.coordinate.latitude);
        self.lat = location.coordinate.latitude;
        self.lon = location.coordinate.longitude;
        [self requestData];
        
        [self searchLocationByCurrentLan:self.lat AndLon:self.lon];
    }];
}
#pragma 当前位置下的周边搜索
- (void)searchLocationByCurrentLan:(float)currentLat AndLon:(float)currentLon{
    
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    request.location            = [AMapGeoPoint locationWithLatitude:currentLat longitude:currentLon];
    /* 按照距离排序. */
    request.sortrule            = 0;
    request.requireExtension    = YES;
    request.types = @"商务住宅";
    [self.search AMapPOIAroundSearch:request];
}

- (void)settingRefresh{
    declareWeakSelf;
    //下拉刷新
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        currentPage = 1;
        [weakSelf requestData];
    }];
    NSMutableArray *pullImagesArray = [[NSMutableArray alloc]init];
    NSMutableArray *refreshingArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i<3; i++) {
        [pullImagesArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"帧数%d",i+2]]];
    }
    for (int i= 0; i<8; i++) {
        [refreshingArray addObject:[UIImage imageNamed:[NSString stringWithFormat:@"帧数%d",i+1]]];
        
    }
    header.lastUpdatedTimeLabel.hidden = YES;
    header.stateLabel.hidden = YES;
    [header setImages:pullImagesArray forState:MJRefreshStatePulling];
    [header setImages:refreshingArray forState:MJRefreshStateRefreshing];
    self.homeTableView.mj_header = header;
    
    //上拉加载更多
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    //footer.refreshingTitleHidden = YES;
    [footer setTitle:@"我可是有底线的哦" forState:MJRefreshStateNoMoreData];
    self.homeTableView.mj_footer = footer;
    
}
-(void)loadMoreData{
    
    currentPage = currentPage+1;
    [self requestData];
    
}
- (void)requestData{


    NSString *requestUrl = [NSString stringWithFormat:@"http://ha.tongchengxianggou.com/api/shop/list?locate=1&max=10&la=%lf&lo=%lf&page=%ld&orderby=%ld",self.lat,self.lon,currentPage,currentClass];
    
    [URLRequest getWithURL:requestUrl params:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        if (currentPage == 1) {
            [self.dataArray removeAllObjects];
            NSLog(@"homeDate:%@",[cityShoppingTool jsonConvertToDic:responseObject][@"list"]);
             self.dataArray =[NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[homeModel class] json:[cityShoppingTool jsonConvertToDic:responseObject][@"list"]]];
            [self.homeTableView reloadData];
            [self.homeTableView.mj_header endRefreshing];
           
        }else{
            
            NSMutableArray *feedList = [NSMutableArray array];
            
            feedList = [NSMutableArray arrayWithArray:[NSArray modelArrayWithClass:[homeModel class] json:[cityShoppingTool jsonConvertToDic:responseObject][@"list"]]];
            
            NSMutableArray *indexPaths = [NSMutableArray array];
            [feedList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(self.dataArray.count + idx) inSection:0];
                [indexPaths addObject:indexPath];
                
            }];
            
            [self.dataArray addObjectsFromArray:feedList];
            [self.homeTableView beginUpdates];
            [self.homeTableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationFade];
            [self.homeTableView endUpdates];
            
            [self.homeTableView.mj_footer endRefreshing];
            
            if (feedList.count == 0) {

                [self.homeTableView.mj_footer endRefreshingWithNoMoreData];
                
            }else{
                
                [self.homeTableView.mj_footer endRefreshing];
                
            }
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@",error);
        [self.homeTableView.mj_header endRefreshing];
        
    }];
}

- (void)configWithSearchBar{
    
    self.searchBar = [[hxwSearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 90, 30)];
    self.searchBar.placeholder = @"搜索周边的商家商品";
    self.searchBar.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bannerImageDeatail)];
    [self.searchBar addGestureRecognizer:tapGes];
    
    self.searchBar.searBarColor = [UIColorFromRGBA(244, 244, 248, 1) colorWithAlphaComponent:0.5];
    self.searchBar.textColor = [UIColor whiteColor];
    self.searchBar.searBarFont = [UIFont systemFontOfSize:15.0];
    self.searchBar.placeholdesColor = [UIColor colorWithRed:255 / 255.0 green:218 / 255.0 blue:69 / 255.0 alpha:1];
    self.searchBar.placeholdesFont = [UIFont systemFontOfSize:15.0];

    self.navigationItem.titleView = self.searchBar;
    
    if(@available(ios 11,*)){
        
        [self addRightBarButtonWithFirstImage:[UIImage imageNamed:@"scan"] WithTitle:@" 扫码" action:@selector(bannerImageDeatail)];
        [self addLeftBarButtonWithImage:[UIImage imageNamed:@"下拉"] WithTitle:@"淮安" action:@selector(bannerImageDeatail)];
        
    }else{
        //扫描
        self.scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.scanBtn setImage:[UIImage imageNamed:@"scan"] forState:UIControlStateNormal];
         self.scanBtn.frame = CGRectMake(0, 0, 70, 30);
        self.scanBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.scanBtn setTitle:@" 扫码" forState:UIControlStateNormal];
        [self.scanBtn addTarget:self action:@selector(bannerImageDeatail) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView: self.scanBtn];
        self.navigationItem.rightBarButtonItem = rightBarItem;
        //定位
        self.locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.locationBtn setImage:[UIImage imageNamed:@"下拉"] forState:UIControlStateNormal];
        self.locationBtn.frame = CGRectMake(0, 0, 70, 30);
        self.locationBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.locationBtn setTitle:@"淮安" forState:UIControlStateNormal];
        [self.locationBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, -self.locationBtn.imageView.image.size.width, 0, self.locationBtn.imageView.image.size.width)];
        [self.locationBtn setImageEdgeInsets:UIEdgeInsetsMake(0, self.locationBtn.titleLabel.bounds.size.width, 0, -self.locationBtn.titleLabel.bounds.size.width)];
        
        [self.locationBtn addTarget:self action:@selector(bannerImageDeatail) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc]initWithCustomView: self.locationBtn];
        self.navigationItem.leftBarButtonItem = leftBarItem;
    }
}

- (void)bannerImageDeatail{
    
    citySelectedViewController *searchV = [[citySelectedViewController alloc]init];
    UINavigationController *naV = [[UINavigationController alloc]initWithRootViewController:searchV];
    [self presentViewController:naV animated:YES completion:nil];
    
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
   
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [tableView fd_heightForCellWithIdentifier:@"nearShopTableViewCell" cacheByIndexPath:indexPath configuration:^(nearShopTableViewCell * cell){
        
        cell.model = self.dataArray[indexPath.row];
        
    }] ;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    LoginViewController *loginVc = [[LoginViewController alloc]init];
//    [self presentViewController:loginVc animated:YES completion:^{
//
//    }];
    
    shopViewController *shopView = [[shopViewController alloc]init];
    shopView.shopModel = self.dataArray[indexPath.row];

    shopView.lat = self.lat;
    shopView.lon = self.lon;

    [self.navigationController pushViewController:shopView animated:YES];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSLog(@"%lf",scrollView.contentOffset.y);

    if (scrollView.contentOffset.y <= 0) {

        self.homeTopView.frame = CGRectMake(0,-scrollView.contentOffset.y  , SCREEN_WIDTH, 105);
        self.homeTopView.themeImageView.alpha = 1;
        self.homeTopView.locateBgView.alpha = 1;

    }else{
        if (scrollView.contentOffset.y<=105-SafeAreaTopHeight) {
             self.homeTopView.frame = CGRectMake(0,-scrollView.contentOffset.y, SCREEN_WIDTH, 105);
        self.homeTopView.locateBgView.alpha = 1 - scrollView.contentOffset.y/40;

        }else{
            self.homeTopView.locateBgView.alpha = 1 - scrollView.contentOffset.y/40;
//            if (scrollView.contentOffset.y>105-SafeAreaTopHeight && scrollView.contentOffset.y<105-SafeAreaTopHeight+5) {
//                self.homeTopView.searchBarHeightConstraint.constant =35- (scrollView.contentOffset.y - (105-SafeAreaTopHeight));
//                [self.homeTopView.searchBarBgView layoutIfNeeded];
//            }
            self.homeTopView.frame = CGRectMake(0,-(105-SafeAreaTopHeight), SCREEN_WIDTH, 105);
        }
        self.homeTopView.themeImageView.alpha =  1 - scrollView.contentOffset.y/10;
    }
    
    //    if (scrollView.contentOffset.y < topConstraint) {
//        self.navigationItem.titleView.hidden = YES;
//       // self.navigationItem.rightBarButtonItem.customView.hidden = YES;
//        if(@available(ios 11,*)){
//            self.navigationItem.rightBarButtonItem.customView.hidden = YES;
//            self.navigationItem.leftBarButtonItem.customView.hidden = YES;
//
//        }else{
//            self.scanBtn.hidden = YES;
//            self.locationBtn.hidden = YES;
//        }
//
//        self.navView.alpha = 0;
//    }else{
//        self.navView.alpha = scrollView.contentOffset.y/SafeAreaTopHeight;
//        self.navigationItem.titleView.hidden = NO;
//        if(@available(ios 11,*)){
//            self.navigationItem.rightBarButtonItem.customView.hidden = NO;
//            self.navigationItem.leftBarButtonItem.customView.hidden = NO;
//        }else{
//            self.scanBtn.hidden = NO;
//            self.locationBtn.hidden = NO;
//        }
//
//    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
    }else{
        [self.addressAroundArray removeAllObjects];
        for (int i = 0; i<response.pois.count; i++) {
            AMapPOI *poi = response.pois[i];
            [self.addressAroundArray addObject:poi];
            NSLog(@"test:%@",poi.name);
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleDefault;
    
}
@end
