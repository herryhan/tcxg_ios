//
//  AddressSelViewController.m
//  同城享购
//
//  Created by Charles on 2018/2/25.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "AddressSelViewController.h"
#import <MAMapKit/MAMapKit.h>
#import "AddressTableCell.h"

@interface AddressSelViewController ()<UITableViewDelegate,UITableViewDataSource,MAMapViewDelegate,AMapSearchDelegate>
@property (nonatomic,strong) MAMapView *mapView;
@property (nonatomic,strong) UITableView *mTableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,strong) CLLocation *currentLocation;
@property (nonatomic,strong) AMapSearchAPI *searchMap;
@property (nonatomic,strong) MAPointAnnotation *mPointAnnotation;
@property (nonatomic,strong) CLLocation *centerLocation;
@end

@implementation AddressSelViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;//跟踪用户
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    ///初始化地图
    MAMapView *mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, PX_SCREEN_WIDTH, 300)];
    mapView.delegate = self;
    mapView.scaleOrigin = CGPointMake(mapView.scaleOrigin.x, 22);
    mapView.compassOrigin = CGPointMake(mapView.compassOrigin.x, 22);
    mapView.showsCompass = NO;
    mapView.zoomLevel = 16;
    ///把地图添加至view
    [self.view addSubview:mapView];
    self.mapView = mapView;
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    _mPointAnnotation = pointAnnotation;
    [self px_initPin:mapView.centerCoordinate];

    mapView.centerCoordinate = mapView.userLocation.location.coordinate;
    
    [self initSearch];
    
}

#pragma mark ==========================MAMapViewDelegate======================================

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    //实时经纬度
    _currentLocation = [userLocation.location copy];
    [self initAction];
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
    PXDALog(@"====== ====== ====== ======");
    [self px_initPin:mapView.centerCoordinate];
}

// 绘制大头针
- (void)px_initPin:(CLLocationCoordinate2D )location{
    _mPointAnnotation.coordinate = location;
    _mPointAnnotation.lockedToScreen = NO;
    _mPointAnnotation.lockedScreenPoint = CGPointMake(_mapView.centerX, _mapView.centerY);
    [_mapView addAnnotation:_mPointAnnotation];
    _centerLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    [self initSearchs];
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view{
    if ([view.annotation isKindOfClass:[MAUserLocation class]]) {
        [self initAction];
    }
}

- (void)initAction{
    if (_currentLocation) {
        AMapReGeocodeSearchRequest *req = [[AMapReGeocodeSearchRequest alloc] init];
        req.location = [AMapGeoPoint locationWithLatitude:_currentLocation.coordinate.latitude longitude:_currentLocation.coordinate.longitude];
        [_searchMap AMapReGoecodeSearch:req];
    }
}

- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response{
    NSString *str = response.regeocode.addressComponent.city;
    if (str.length == 0) {
        str = response.regeocode.addressComponent.province;
    }
    _mapView.userLocation.title = str;
    _mapView.userLocation.subtitle = response.regeocode.formattedAddress;
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.pinColor = MAPinAnnotationColorRed;
        return annotationView;
    }
    return nil;
}

- (void)initSearch{
    _searchMap = [[AMapSearchAPI alloc] init];
    _searchMap.delegate = self;
}

- (void)initSearchs{
    if (_currentLocation == nil || _searchMap == nil) {
        return;
    }
    AMapPOIAroundSearchRequest *req = [[AMapPOIAroundSearchRequest alloc] init];
    req.location = [AMapGeoPoint locationWithLatitude:_centerLocation.coordinate.latitude longitude:_centerLocation.coordinate.longitude];
    req.types = @"商务住宅";
    req.sortrule = 0;
    req.radius = 1000;
    req.requireExtension = YES;
    [_searchMap AMapPOIAroundSearch:req];
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0) {
        return;
    }
    for (AMapPOI *poi in response.pois) {
        PXDALog(@"POI-search_name === %@",poi.name);
    }
    _dataSource = [NSMutableArray arrayWithArray:response.pois];
    [self.mTableView reloadData];
}

# pragma UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

static NSString *cellId = @"cellId";

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
    if (!cell) {
        cell = [[AddressTableCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
    }
    AMapPOI *poi = [self.dataSource objectAtIndex:indexPath.row];
    cell.poi = poi;
    return cell;
}

# pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AddressTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _SelAddress?({
        _SelAddress(cell.location,cell.nameLabel.text,cell.subNameLabel.text);
        [self.navigationController popViewControllerAnimated:YES];
    }):nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}

#pragma Create UITableView

- (UITableView *)mTableView{
    if (!_mTableView) {
        self.mTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.mapView.bottom, PX_SCREEN_WIDTH, PX_SCREEN_HEIGHT - self.mapView.bottom)];
    }
    _mTableView.delegate = self;
    _mTableView.dataSource = self;
    [_mTableView registerClass:[AddressTableCell class] forCellReuseIdentifier:cellId];
    _mTableView.separatorInset = UIEdgeInsetsZero;
    [self.view addSubview:_mTableView];
    return _mTableView;
}

- (NSMutableArray *)dataSource{
    return PX_LAZY(_dataSource, @[].mutableCopy);
}

@end
