//
//  selectRecAddressViewController.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "selectRecAddressViewController.h"
#import "UIViewController+BarButton.h"
#import "citySelectView.h"
#import "nearAddressModel.h"
#import "searchResultTableViewCell.h"
#import "LoginViewController.h"


@interface selectRecAddressViewController ()<AMapLocationManagerDelegate,AMapSearchDelegate,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) citySelectView *cityView;
@property (nonatomic, strong) UITableView *aroundTableView;
@property (nonatomic, strong) UITableView *searchTableView;
@property (nonatomic, strong) UIView *aroundSectionView;
@property (nonatomic, strong) UIView *aroundHeaderView;
@property (nonatomic, strong) UIView *maskView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) NSMutableArray *searchKeyResArray;//搜索结果的array

@property (nonatomic,strong) AMapLocationManager *locationManager;//高德地图类（用于获取地理位置）
@property (nonatomic, strong) AMapSearchAPI *search;
@property BOOL isHideSearchTableView;

@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;//系统小菊花

@end

@implementation selectRecAddressViewController

- (UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
        //设置小菊花的frame
       _activityIndicator.frame= CGRectMake(self.view.centerX-30, self.view.centerY-30-100, 60, 60);
        _activityIndicator.layer.cornerRadius = 5;
        _activityIndicator.layer.masksToBounds = YES;
        //设置小菊花颜色
        _activityIndicator.color = [UIColor whiteColor];
        //设置背景颜色
        _activityIndicator.backgroundColor = UIColorFromRGBA(224, 224, 224,1);
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
        _activityIndicator.hidesWhenStopped = NO;
        [self.view addSubview:_activityIndicator];
    }
    return _activityIndicator;
}

- (NSMutableArray *)searchKeyResArray{
    if (!_searchKeyResArray) {
        _searchKeyResArray = [[NSMutableArray alloc]init];
    }
    return _searchKeyResArray;
}

- (UITableView *)searchTableView{
    
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, SCREEN_WIDTH, SCREEN_HEIGHT-50-SafeAreaTopHeight) style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
    }
    return _searchTableView;
    
}
- (UIView *)maskView{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-SafeAreaTopHeight)];
        _maskView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideMaskView)];
        [_maskView addGestureRecognizer:tapGes];
    }
    return _maskView;
}

- (void)hideMaskView{
    [self.cityView.addressSearchBar resignFirstResponder];
    [self.maskView removeFromSuperview];
    [self.cityView.addressSearchBar setShowsCancelButton:NO animated:YES];
}

- (UIView *)aroundHeaderView{
    if (!_aroundHeaderView) {
        _aroundHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
        _aroundHeaderView.backgroundColor = UIColorFromRGBA(244, 244, 244, 1);
        UIButton *selectCurrentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [selectCurrentBtn setImage:[UIImage imageNamed:@"icon_locate_current"] forState:UIControlStateNormal];
        [selectCurrentBtn setTitle:@" 点击定位当前地址" forState:UIControlStateNormal];
        [selectCurrentBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        selectCurrentBtn.backgroundColor = [UIColor whiteColor];
        selectCurrentBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        selectCurrentBtn.frame =CGRectMake(0,10, SCREEN_WIDTH, 40);
        [selectCurrentBtn addTarget:self action:@selector(getCurrentLocation) forControlEvents:UIControlEventTouchUpInside];
        
        [_aroundHeaderView addSubview:selectCurrentBtn];
    }
    return _aroundHeaderView;
}

//获取当前位置
- (void)getCurrentLocation{
    
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
        _CallBackSelectedLocation(regeocode.POIName,location.coordinate.latitude,location.coordinate.longitude);
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (UIView *)aroundSectionView{
    
    if (!_aroundSectionView) {
        _aroundSectionView = [[UIView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, 40)];
        _aroundSectionView.backgroundColor = UIColorFromRGBA(244, 244, 244, 1);
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(12, 12, 16*7/8, 16)];
        [image setImage:[UIImage imageNamed:@"icon_location_address"]];
        [_aroundSectionView addSubview:image];
        UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(image.frame)+10, 10, 100, 20)];
        title.text = @"附近地址";
        title.font = [UIFont systemFontOfSize:14];
        title.textColor = UIColorFromRGBA(104, 104, 104, 1);
        [_aroundSectionView addSubview:title];
    }
    return _aroundSectionView;
}

- (UITableView *)aroundTableView{
    if (!_aroundTableView) {
        _aroundTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT-40-SafeAreaTopHeight) style:UITableViewStylePlain];
        _aroundTableView.delegate = self;
        _aroundTableView.dataSource = self;
        _aroundTableView.backgroundColor = UIColorFromRGBA(244, 244, 244, 1);
        _aroundTableView.separatorColor = UIColorFromRGBA(239, 239, 239, 1);
        [_aroundTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"around"];
        
    }
    return _aroundTableView;
}
- (citySelectView *)cityView{
    if (!_cityView) {
        _cityView = [[citySelectView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
        _cityView.addressSearchBar.delegate  =self;
    }
    return _cityView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isHideSearchTableView = NO;
    //初始化地图
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor whiteColor] andSize:CGSizeMake(1, 1)] forBarMetrics:UIBarMetricsDefault];
    
    [self contitle:@"选择收货地址" WithColor:[UIColor blackColor]];
    [self uiconfig];
}

- (void)uiconfig{
    //设置左右item
    [self addLeftBarButtonWithImage:[UIImage imageNamed:@"icon_default_back_gray"] action:@selector(back)];
    [self addRightBarButtonItemWithTitle:@"新增地址" andWidth:88 action:@selector(addNewRecAddress)];
    
    //城市选择
    [self.view addSubview:self.cityView];
    self.cancelBtn = [UIButton new];
    //设置选择当前位置
    [self.aroundTableView setTableHeaderView:self.aroundHeaderView];
    [self.view addSubview:self.aroundTableView];
    [self.aroundTableView reloadData];
//    [self.view addSubview:self.selectCurrentBtn];
}
- (void)addNewRecAddress{
    
     LoginViewController *xgLoginVc = [[LoginViewController alloc]init];
  
    [self.navigationController presentViewController:xgLoginVc animated:YES completion:^{
    
    }];
    
}
- (void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleDefault;
    
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];

    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.aroundTableView) {
        return self.addressArray.count;
    }else{
        return self.searchKeyResArray.count;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.aroundTableView) {
        return 40;
    }else{
        return 60;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.aroundTableView) {
        static NSString *cellID = @"around";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
            
        }
        AMapPOI *poi = self.addressArray[indexPath.row];
        cell.textLabel.text = poi.name;
        cell.textLabel.textColor = UIColorFromRGBA(50, 50, 50, 1);
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        return cell;
    }else{
        static NSString *cellid=@"resCll";
        searchResultTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"searchResultTableViewCell" owner:self options:nil].firstObject;
        }
        [cell uiconfigWith:self.searchKeyResArray[indexPath.row]];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.aroundTableView) {
        //设置附近的返回值
        AMapPOI *poi =self.addressArray[indexPath.row];
        _CallBackSelectedLocation(poi.name,poi.location.latitude,poi.location.longitude);
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        AMapPOI *poi =self.searchKeyResArray[indexPath.row];
        _CallBackSelectedLocation(poi.name,poi.location.latitude,poi.location.longitude);
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.aroundTableView) {
        return self.aroundSectionView;
    }else{
        return nil;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView == self.aroundTableView) {
        return 40;
    }else{
        return 0.01;
    }
}

#pragma mark - UISearchDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    NSLog(@"A");
    // 这个方法来遍历其子视图, 找到cancel按钮
    if (searchText.length!=0) {
        [self.cancelBtn setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
        self.isHideSearchTableView = NO;
        [self.activityIndicator startAnimating];
        [self searchWithText:searchText];
    }else{
        
        [self.cancelBtn setTitleColor:UIColorFromRGBA(220, 220, 220, 1) forState:UIControlStateNormal];
        [self.searchTableView removeFromSuperview];
        [self.view addSubview:self.maskView];
        self.isHideSearchTableView = YES;

    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{

    if (self.cityView.addressSearchBar.text.length!=0) {
        [self.cancelBtn setTitleColor:UIColorFromRGBA(68, 195, 34, 1) forState:UIControlStateNormal];
    }else{
        [self.cancelBtn setTitleColor:UIColorFromRGBA(220, 220, 220, 1) forState:UIControlStateNormal];
    }
    [self.view addSubview:self.maskView];
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.cityView.addressSearchBar setShowsCancelButton:YES animated:YES];
    self.cancelBtn = [self.cityView.addressSearchBar valueForKeyPath:@"cancelButton"];
    self.cancelBtn.enabled = YES;
    [self.cancelBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:UIColorFromRGBA(220, 220, 220, 1) forState:UIControlStateNormal];
    return YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"ffffff");
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self.cityView.addressSearchBar resignFirstResponder];
    [self.cityView.addressSearchBar setShowsCancelButton:NO animated:YES];
    [self searchWithText:searchBar.text];

}

//搜索关键字
- (void)searchWithText:(NSString *)text{
 
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.keywords            = text;
    request.city                = @"淮安";
    request.requireExtension    = YES;
    request.sortrule = 0;
    request.cityLimit           = YES;
    [self.search AMapPOIKeywordsSearch:request];
    
}

#pragma mark poi

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
    {
        return;
        
    }else{
        [self.searchKeyResArray removeAllObjects];
        for (int i = 0; i<response.pois.count; i++) {
            AMapPOI *poi = response.pois[i];
            MKMapPoint point1 = MKMapPointForCoordinate(CLLocationCoordinate2DMake(self.lat,self.lon));
            
            MKMapPoint point2 = MKMapPointForCoordinate(CLLocationCoordinate2DMake(poi.location.latitude,poi.location.longitude));
            CLLocationDistance distance = MKMetersBetweenMapPoints(point1,point2);
            
            poi.distance = distance*10/10;
            
            [self.searchKeyResArray addObject:poi];
            
            for (int i=0; i<self.searchKeyResArray.count; i++) {
                
                for (int j=i+1; j<self.searchKeyResArray.count; j++) {
                    AMapPOI *poi1 = self.searchKeyResArray[i];
                    AMapPOI *poi2 = self.searchKeyResArray[j];
                    
                    if (poi1.distance>poi2.distance) {
                        
                        [self.searchKeyResArray exchangeObjectAtIndex:i withObjectAtIndex:j];
                        
                    }
                }
            }
            NSLog(@"%f",distance/1000);
        }
        [self.searchTableView reloadData];
        
        if (!self.isHideSearchTableView){
            [self.view addSubview:self.searchTableView];
            [self.maskView removeFromSuperview];
            self.isHideSearchTableView = !self.isHideSearchTableView;
        }
    }
}

@end
