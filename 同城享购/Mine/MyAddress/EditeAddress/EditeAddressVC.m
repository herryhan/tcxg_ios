//
//  EditeAddressVC.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "EditeAddressVC.h"
#import "EditeAddressCellView.h"
#import "EditeAddressSexSelectView.h"
#import "AddressSelViewController.h"
#import "NSString+PX.h"

#define CellHeight 50.0f

@interface EditeAddressVC ()<EditeAddressCellViewDelegate>
{
    UIScrollView *_mScrollView;
    EditeAddressCellView *_mNameView;
    PXSingleLineView *_mNameLineView;
    EditeAddressSexSelectView *_mSexView;
    PXSingleLineView *_mSexLineView;
    EditeAddressCellView *_mTelView;
    EditeAddressCellView *_mAddressView;
    PXSingleLineView *_mAddressLineView;
    EditeAddressCellView *_mNumberView;
}
@end

@implementation EditeAddressVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:PX_COLOR_HEX(@"ffffff"),NSForegroundColorAttributeName, nil]];
    self.navigationController.navigationBar.tintColor = PX_COLOR_HEX(@"ffffff");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.model?@"编辑地址":@"新增地址";

    IQKeyboardManager *manager                  = [IQKeyboardManager sharedManager];
    manager.enable                              = YES;
    manager.shouldResignOnTouchOutside          = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar                   = NO;

    [self setupView];
}

- (void)setupView{
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction)];

    _mScrollView = [UIScrollView new];
    _mScrollView.backgroundColor = self.view.backgroundColor;
    [_mScrollView setShowsVerticalScrollIndicator:NO];
    [self.view addSubview:_mScrollView];
    _mScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    
    UILabel *contacterLabel = [UILabel new];
    UIView *fSectionView    = [UIView new];
    _mNameView              = [EditeAddressCellView new];
    _mNameLineView          = [PXSingleLineView new];
    _mSexView               = [EditeAddressSexSelectView new];
    _mSexLineView           = [PXSingleLineView new];
    _mTelView               = [EditeAddressCellView new];
    UILabel *addressLabel   = [UILabel new];
    UIView *sSectionView    = [UIView new];
    _mAddressView           = [EditeAddressCellView new];
    _mAddressLineView       = [PXSingleLineView new];
    _mNumberView            = [EditeAddressCellView new];
    NSArray *fSections = [NSArray arrayWithObjects:_mNameView,_mNameLineView,_mSexView,_mSexLineView,_mTelView, nil];
    NSArray *sSections = [NSArray arrayWithObjects:_mAddressView,_mAddressLineView,_mNumberView, nil];
    [fSectionView sd_addSubviews:fSections];
    [sSectionView sd_addSubviews:sSections];
    NSArray *views = [NSArray arrayWithObjects:contacterLabel,fSectionView,addressLabel,sSectionView, nil];
    [_mScrollView sd_addSubviews:views];
    
    CGFloat padding = 15.0f;
    
    contacterLabel.sd_layout
        .leftSpaceToView(_mScrollView, padding)
        .rightSpaceToView(_mScrollView, padding)
        .topSpaceToView(_mScrollView, 0)
        .heightIs(30);
    contacterLabel.text = @"联系人";
    contacterLabel.font = Font(15);
    contacterLabel.textColor = PX_COLOR_HEX(@"333333");
    
    fSectionView.sd_layout
        .leftSpaceToView(_mScrollView, 0)
        .rightSpaceToView(_mScrollView, 0)
        .topSpaceToView(contacterLabel, 0);
    fSectionView.backgroundColor = PX_COLOR_HEX(@"ffffff");
    
    _mNameView.sd_layout
        .leftSpaceToView(fSectionView, 0)
        .rightSpaceToView(fSectionView, 0)
        .topSpaceToView(fSectionView, 0)
        .heightIs(CellHeight);
    _mNameView.nameText = @"姓名：";
    _mNameView.mTextField.placeholder = @"请填写收货人的姓名";
    
    _mNameLineView.sd_layout
        .leftSpaceToView(fSectionView, 61)
        .rightSpaceToView(fSectionView, 0)
        .topSpaceToView(_mNameView, 0)
        .heightIs(.8f);
    
    _mSexView.sd_layout
        .leftEqualToView(_mNameLineView)
        .rightEqualToView(_mNameLineView)
        .topSpaceToView(_mNameLineView, 0)
        .heightIs(CellHeight);
    
    _mSexLineView.sd_layout
        .leftSpaceToView(fSectionView, padding)
        .rightSpaceToView(fSectionView, 0)
        .topSpaceToView(_mSexView, 0)
        .heightIs(.8f);
    
    _mTelView.sd_layout
        .leftEqualToView(_mNameView)
        .rightEqualToView(_mNameView)
        .topSpaceToView(_mSexLineView, 0)
        .heightIs(CellHeight);
    _mTelView.nameText = @"电话：";
    _mTelView.mTextField.placeholder = @"请填写收货手机号码";
    _mTelView.mTextField.keyboardType = UIKeyboardTypePhonePad;
    
    [fSectionView setupAutoHeightWithBottomView:_mTelView bottomMargin:0];
    
    addressLabel.sd_layout
        .leftEqualToView(contacterLabel)
        .rightEqualToView(contacterLabel)
        .topSpaceToView(fSectionView, 0)
        .heightIs(30);
    addressLabel.text = @"收货地址";
    addressLabel.font = Font(15);
    addressLabel.textColor = PX_COLOR_HEX(@"333333");
    
    sSectionView.sd_layout
        .leftEqualToView(fSectionView)
        .rightEqualToView(fSectionView)
        .topSpaceToView(addressLabel, 0);
    sSectionView.backgroundColor = PX_COLOR_HEX(@"ffffff");
    
    _mAddressView.sd_layout
        .leftSpaceToView(sSectionView, 0)
        .rightSpaceToView(sSectionView, 0)
        .topSpaceToView(sSectionView, 0)
        .heightIs(CellHeight);
    _mAddressView.nameText = @"小区/大厦/学校：";
    _mAddressView.mMapView.mMapLabel.text = @"点击选择";
    _mAddressView.mMapView.mMapLabel.textColor = PX_COLOR_HEX(@"666666");
    _mAddressView.minWidth = 117;
    _mAddressView.delegate = self;
    
    _mAddressLineView.sd_layout
        .leftSpaceToView(sSectionView,padding)
        .rightSpaceToView(sSectionView,0)
        .topSpaceToView(_mAddressView, 0)
        .heightIs(.8f);
    
    _mNumberView.sd_layout
        .leftEqualToView(_mNameView)
        .rightEqualToView(_mNameView)
        .topSpaceToView(_mAddressLineView, 0)
        .heightIs(CellHeight);
    _mNumberView.minWidth = 117;
    _mNumberView.nameText = @"楼号-门牌号：";
    _mNumberView.mTextField.placeholder = @"例：16号楼427室";
    [sSectionView setupAutoHeightWithBottomView:_mNumberView bottomMargin:0];
    
    [_mScrollView setupAutoContentSizeWithBottomView:_mNumberView bottomMargin:0];
    [self insertModel];
}

- (void)insertModel{
    if (self.model) {
        //填充已有数据
        _mNameView.mTextField.text = self.model.mine_name;
        _mTelView.mTextField.text = self.model.mine_tel;
        _mAddressView.mMapView.mMapLabel.text = self.model.mine_address;
        _mAddressView.mMapView.mMapLabel.textColor = PX_COLOR_HEX(@"333333");
        _mNumberView.mTextField.text = self.model.mine_number;
    }
}

-(void)editeAddressCellView:(EditeAddressCellView *)cell clickMapView:(EditeAddressMapView *)mapView{
    //选择地址
    PXDALog(@"%s",__func__);
    AddressSelViewController *vc = [AddressSelViewController new];
    vc.SelAddress = ^(CLLocation *location, NSString *name, NSString *subName) {
        PXDALog(@"%@--%@",name,subName);
        mapView.mMapLabel.text = name;
        mapView.mMapLabel.textColor = PX_COLOR_HEX(@"333333");
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)saveAction{
    
    if (!_mNameView.mTextField.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的姓名"];
        return;
    }
    if (![_mTelView.mTextField.text px_checkPhoneNum]) {
        [SVProgressHUD showErrorWithStatus:@"请输入收货手机号码，以便配送员联系您"];
        return;
    }
    if ([_mAddressView.mMapView.mMapLabel.text isEqualToString:@"点击选择"]) {
        [SVProgressHUD showErrorWithStatus:@"请选择您的位置，以便配送员找到您"];
        return;
    }
    if (!_mNumberView.mTextField.text) {
        [SVProgressHUD showErrorWithStatus:@"请输入楼号-门牌号，以便配送员找到您"];
        return;
    }
    //保存地址
    
    
}

@end
