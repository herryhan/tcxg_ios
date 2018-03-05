//
//  citySendViewController.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "citySendViewController.h"
#import "CitySendCellView.h"
#import "CitySendAddressView.h"
#import "AddressSelViewController.h"
#import "CitySendContacterView.h"
#import "CitySendDatePickView.h"
#import "CitySendExtraServiceView.h"
#import "CitySendBottomView.h"
#import "CitySendBannerView.h"

@interface citySendViewController ()<CitySendViewClickDelegate,CitySendAddressViewDelegate,UIScrollViewDelegate>

@property (nonatomic,strong) UIScrollView *vScrollView;
@property (nonatomic,strong) UIScrollView *hScrollView;

@property (nonatomic,strong) UIView *hSectionView;
@property (nonatomic,strong) UIView *fSectionView;
@property (nonatomic,strong) UIView *sSectionView;
@property (nonatomic,strong) UIView *tSectionView;

@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) NSMutableArray *cellSource;

@property (nonatomic,strong) CitySendAddressView *fAddressView;
@property (nonatomic,strong) CitySendAddressView *sAddressView;
@property (nonatomic,strong) CitySendAddressView *tAddressView;

//** bottomView */
@property (nonatomic,strong) CitySendBottomView * mBottomView;

//** keyBoardManager */
@property (nonatomic,weak) IQKeyboardManager * manager;
//** leftArrowButton */
@property (nonatomic,strong) UIButton * mLeftArrowButton;
//** rightArrowButton */
@property (nonatomic,strong) UIButton * mRightArrowButton;

@end

@implementation citySendViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    self.manager = manager;
    [self px_setupView];
    
}

- (void)setupArrowView{
    self.mLeftArrowButton = ({
        UIButton *view = [[UIButton alloc] init];
        [self.vScrollView addSubview:view];
        view.sd_layout
            .leftSpaceToView(self.vScrollView, 0)
            .topSpaceToView(self.vScrollView, 44.8)
            .bottomEqualToView(self.hScrollView)
            .widthIs(50);
        [view setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forState:UIControlStateNormal];
        [view setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"999999")] forState:UIControlStateDisabled];
        __weak typeof(self) weakSelf = self;
        [view addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            CGPoint point = weakSelf.hScrollView.contentOffset;
            [weakSelf.hScrollView setContentOffset:CGPointMake(point.x - PX_SCREEN_WIDTH, point.y) animated:YES];
        }];
        view;
    });
    
    self.mRightArrowButton = ({
        UIButton *view = [[UIButton alloc] init];
        [self.vScrollView addSubview:view];
        view.sd_layout
            .rightSpaceToView(self.vScrollView, 0)
            .topSpaceToView(self.vScrollView, 44.8)
            .bottomEqualToView(self.hScrollView)
            .widthIs(50);
        [view setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forState:UIControlStateNormal];
        [view setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"999999")] forState:UIControlStateDisabled];
        __weak typeof(self) weakSelf = self;
        [view addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
            CGPoint point = weakSelf.hScrollView.contentOffset;
            [weakSelf.hScrollView setContentOffset:CGPointMake(point.x + PX_SCREEN_WIDTH, point.y) animated:YES];
        }];
        view;
    });
    [self showLeftArrow:NO showRight:YES];
}

- (void)px_setupView{
    
    NSArray *array = [NSArray arrayWithObjects:
  @{@"title":@"1",@"weight":@"1\n4",@"vol":@"2\n3",@"three":@"3\n5"},
  @{@"title":@"2",@"weight":@"1\n4",@"vol":@"2\n3",@"three":@"3\n5"},
  @{@"title":@"3",@"weight":@"1\n4",@"vol":@"2\n3",@"three":@"3\n5"},
  @{@"title":@"4",@"weight":@"1\n4",@"vol":@"2\n3"}, nil];
    UIView *tempView = nil;
    for (NSDictionary *dict in array) {
        CitySendBannerView *view = [[CitySendBannerView alloc] init];
        view.mTitle = dict[@"title"];
        view.mLoadWeight = dict[@"weight"];
        view.mVolume = dict[@"vol"];
        if (dict[@"three"] != nil) view.mThreeHigh = dict[@"three"];
        view.mHaveThreeHigh = dict[@"three"] != nil;
        [self.hScrollView addSubview:view];
        if (tempView == nil){
            view.sd_layout
                .leftSpaceToView(self.hScrollView, 0)
                .topSpaceToView(self.hScrollView, 0)
                .bottomSpaceToView(self.hScrollView, 0)
                .widthIs(PX_SCREEN_WIDTH);
        }else{
            view.sd_layout
                .leftSpaceToView(tempView, 0)
                .topSpaceToView(self.hScrollView, 0)
                .bottomSpaceToView(self.hScrollView, 0)
                .widthIs(PX_SCREEN_WIDTH);
        }
        tempView = view;
        [self.hScrollView setupAutoContentSizeWithRightView:tempView rightMargin:0];
    }
    
    self.mBottomView.backgroundColor = PX_COLOR_HEX(@"ffffff");
    for (NSArray *arr in self.dataSource) {
        NSMutableArray *temp = [NSMutableArray new];
        for (NSDictionary *dict in arr) {
            UIView *backView = [self getViewFromDataSource:arr];
            CitySendCellView *cell = ({
                CitySendCellView *view = [[CitySendCellView alloc] init];
                [backView addSubview:view];
                view.nameLabel.text = [dict objectForKey:@"name"];
                view.contentLabel.text = [dict objectForKey:@"content"];
                view.backgroundColor = PX_COLOR_HEX(@"ffffff");
                view;
            });
            NSUInteger integer = [arr indexOfObject:dict];
            cell.sd_layout
                .leftSpaceToView(backView, 0)
                .rightSpaceToView(backView, 0)
                .topSpaceToView(integer==0?backView:[temp lastObject], .5)
                .heightIs(50);
            cell.delegate = self;
            [temp addObject:cell];
            [backView setupAutoHeightWithBottomView:cell bottomMargin:0];
            if (integer == 2) {
                cell.mImageView.image = [UIImage imageNamed:@"icon_pick_address_location"];
                cell.mTextView.wzb_placeholder = [dict objectForKey:@"content"];
                cell.mTextView.keyboardType = UIKeyboardTypeNumberPad;
            }
            if (integer == 0 && [self.dataSource indexOfObject:arr] == 2) {
                cell.mTextView.wzb_placeholder = [dict objectForKey:@"content"];
            }
        }
        [self.cellSource addObject:temp];
    }
    [self.vScrollView setupAutoContentSizeWithBottomView:self.tSectionView bottomMargin:10];
    
    self.fAddressView.delegate = self;
    self.sAddressView.delegate = self;
    self.sAddressView.topLineShow = YES;
    self.sAddressView.botLineShow = NO;
    
    [self setupArrowView];
    
}

- (void)addSubLineAtHSectionView{
    [UIView animateWithDuration:.3f animations:^{
        self.hSectionView.height == 100 ? ({
            self.hSectionView.sd_layout.heightIs(150);
            self.sAddressView.botLineShow = YES;
            self.tAddressView = [[CitySendAddressView alloc] init];
            [self.hSectionView addSubview:self.tAddressView];
            self.tAddressView.topLineShow = YES;
            self.tAddressView.botLineShow = NO;
            self.tAddressView.delegate = self;
            self.tAddressView.sd_layout
                .leftSpaceToView(self.hSectionView, 0)
                .rightSpaceToView(self.hSectionView, 0)
                .topSpaceToView(self.sAddressView, 0)
                .heightIs(50);
        }) : ({
            self.sAddressView.botLineShow = NO;
            [self.tAddressView removeFromSuperview];
            self.hSectionView.sd_layout.heightIs(100);
        });
    }];
}

- (UIView *)getViewFromDataSource:(NSArray *)array
{
    NSUInteger integer = [self.dataSource indexOfObject:array];
    if (integer == 0) return self.fSectionView;
    else if (integer == 1) return self.sSectionView;
    else return self.tSectionView;
}

#pragma mark ==========================Delegate======================================

- (void)citySendCellView:(CitySendCellView *)view didClickContentLabel:(UILabel *)label
{
    PXDALog(@"%s",__func__);
    if ([((CitySendCellView *)[((NSArray *)[self.cellSource objectAtIndex:0]) firstObject]).contentLabel isEqual:label] ||
        [((CitySendCellView *)[((NSArray *)[self.cellSource objectAtIndex:0]) lastObject]).contentLabel isEqual:label]) {
        //显示输入联系人
        [self.manager resignFirstResponder];
        [CitySendContacterView showCitySendContacterView:^(CitySendContacterInsert type, NSString *name, NSString *mobile) {
            if (type == CitySendContacterInsertConfirm) {
                label.attributedText = [self getAttributeString:name mobile:mobile];
            }
        }];
    }
    if ([((CitySendCellView *)[((NSArray *)[self.cellSource objectAtIndex:1]) firstObject]).contentLabel isEqual:label]) {
        //选取日期
        [self.manager resignFirstResponder];
        CitySendDatePickView *view = [[CitySendDatePickView alloc] initWithFrame:PX_SCREEN_BOUNDS];
        view.SelDateTime = ^(NSString *dateString, NSString *timeString) {
            label.attributedText = [self getAttributeString:dateString mobile:timeString];
        };
    }
    if ([((CitySendCellView *)[((NSArray *)[self.cellSource objectAtIndex:1]) objectAtIndex:1]).contentLabel isEqual:label]) {
        //选择额外需要
        [self.manager resignFirstResponder];
        CitySendExtraServiceView *view = [[CitySendExtraServiceView alloc] initWithFrame:PX_SCREEN_BOUNDS dataSource:@[@"1",@"2",@"3"]];
        view.ExtraServiceCallBack = ^(NSArray<NSNumber *> *array) {
            PXDALog(@"%@",array);
        };
    }
    
}

- (NSMutableAttributedString *)getAttributeString:(NSString *)name mobile:(NSString *)mobile{
    NSString *string = [NSString stringWithFormat:@"%@-%@",name,mobile];
    NSMutableAttributedString *syString = [[NSMutableAttributedString alloc] initWithString:string];
    [syString addAttributes:[NSDictionary dictionaryWithObjects:@[Font(15),PX_COLOR_HEX(@"333333")]
                                forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]]
                                  range:[string rangeOfString:name]];
    [syString addAttributes:[NSDictionary dictionaryWithObjects:@[Font(12),PX_COLOR_HEX(@"666666")]
                                forKeys:@[NSFontAttributeName,NSForegroundColorAttributeName]]
                                  range:[string rangeOfString:mobile ]];
    return syString;
}

- (void)citySendAddressView:(CitySendAddressView *)addressView didSelectedAtNameLabel:(UILabel *)nameLabel clickAtView:(UIView *)view
{
    PXDALog(@"%s",__func__);
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        if ((!([self.fAddressView.nameLabel.text isEqualToString:@"请选择地址"]
              &&[self.sAddressView.nameLabel.text isEqualToString:@"请选择地址"]))
            &&[button.currentImage isEqual:PX_IMAGE_NAMED(@"加号")]) {
                [self addSubLineAtHSectionView];
        }
        if ([button.currentImage isEqual:PX_IMAGE_NAMED(@"减号")]) {
            [self addSubLineAtHSectionView];
        }
    }else{
        AddressSelViewController *vc = [[AddressSelViewController alloc] init];
        vc.SelAddress = ^(CLLocation *location, NSString *name, NSString *subName) {
            PXDALog(@"city-%@-%@-%.2f-%.2f",name,subName,location.coordinate.latitude,location.coordinate.longitude);
            nameLabel.attributedText = [self getAttributeString:name subName:subName];
        };
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (NSMutableAttributedString *)getAttributeString:(NSString *)name subName:(NSString *)subName{
    NSString *string = [NSString stringWithFormat:@"%@\n%@",name,subName];
    NSMutableAttributedString *syString = [[NSMutableAttributedString alloc] initWithString:string];
    [syString addAttribute:NSForegroundColorAttributeName value:PX_COLOR_HEX(@"333333") range:[string rangeOfString:name]];
    [syString addAttribute:NSFontAttributeName value:Font(15) range:[string rangeOfString:name]];
    [syString addAttribute:NSFontAttributeName value:Font(12) range:[string rangeOfString:subName]];
    [syString addAttribute:NSForegroundColorAttributeName value:PX_COLOR_HEX(@"666666") range:[string rangeOfString:subName]];
    return syString;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint point = scrollView.contentOffset;
    NSInteger page = point.x/PX_SCREEN_WIDTH;
    if (page == 0) {
        [self showLeftArrow:NO showRight:YES];
    }else if (page == 3) {
        [self showLeftArrow:YES showRight:NO];
    }else{
        [self showLeftArrow:YES showRight:YES];
    }
}

- (void)showLeftArrow:(BOOL)showLeft showRight:(BOOL)showRight{
    self.mLeftArrowButton.enabled = showLeft;
    self.mRightArrowButton.enabled = showRight;
}

#pragma mark ==========================LAZY======================================

- (UIScrollView *)vScrollView{
    if (!_vScrollView) {
        _vScrollView = ({
            UIScrollView *view = [[UIScrollView alloc] init];
            [self.view addSubview:view];
            view.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 100, 0));
            view.backgroundColor = PX_COLOR_HEX(@"dfdfdf");
            view.bounces = NO;
            view;
        });
    }
    return _vScrollView;
}

- (UIScrollView *)hScrollView{
    if (!_hScrollView) {
        _hScrollView = ({
            UIScrollView *view = [[UIScrollView alloc] init];
            [self.vScrollView addSubview:view];
            view.sd_layout
                .leftSpaceToView(self.vScrollView, 0)
                .topSpaceToView(self.vScrollView, -20)
                .rightSpaceToView(self.vScrollView, 0)
                .heightIs(250);
            view.pagingEnabled = YES;
            view.showsHorizontalScrollIndicator = NO;
            view.delegate = self;
            view.bounces = NO;
            view;
        });
    }
    return _hScrollView;
}

- (UIView *)hSectionView{
    if (!_hSectionView) {
        _hSectionView = ({
            UIView *view = [[UIView alloc] init];
            [self.vScrollView addSubview:view];
            view.sd_layout
                .leftSpaceToView(self.vScrollView, 0)
                .rightSpaceToView(self.vScrollView, 0)
                .topSpaceToView(self.hScrollView, 10)
                .heightIs(100);
            view.backgroundColor = PX_COLOR_HEX(@"ffffff");
            view;
        });
    }
    return _hSectionView;
}

- (UIView *)fSectionView{
    if (!_fSectionView) {
        _fSectionView = ({
            UIView *view = [[UIView alloc] init];
            [self.vScrollView addSubview:view];
            view.sd_layout
                .leftSpaceToView(self.vScrollView, 0)
                .rightSpaceToView(self.vScrollView, 0)
                .topSpaceToView(self.hSectionView, 10)
                .heightIs(100);
            view;
        });
    }
    return _fSectionView;
}

- (UIView *)sSectionView{
    if (!_sSectionView) {
        _sSectionView = ({
            UIView *view = [[UIView alloc] init];
            [self.vScrollView addSubview:view];
            view.sd_layout
                .leftSpaceToView(self.vScrollView, 0)
                .rightSpaceToView(self.vScrollView, 0)
                .topSpaceToView(self.fSectionView, 10)
                .heightIs(100);
            view;
        });
    }
    return _sSectionView;
}

- (UIView *)tSectionView{
    if (!_tSectionView) {
        _tSectionView = ({
            UIView *view = [[UIView alloc] init];
            [self.vScrollView addSubview:view];
            view.sd_layout
                .leftSpaceToView(self.vScrollView, 0)
                .rightSpaceToView(self.vScrollView, 0)
                .topSpaceToView(self.sSectionView, 10)
                .heightIs(100);
            view;
        });
    }
    return _tSectionView;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        NSArray *fArray = [NSArray arrayWithObjects:@{@"name":@"寄件联系人",@"content":@"选择寄件人"},@{@"name":@"收件联系人",@"content":@"选择收件联系人"}, nil];
        NSArray *sArray = [NSArray arrayWithObjects:@{@"name":@"取货时间",@"content":@"选择取货时间"},@{@"name":@"额外需求",@"content":@"是否需要搬运/返程服务"},@{@"name":@"货物重量",@"content":@"1"}, nil];
        NSArray *tArray = [NSArray arrayWithObjects:@{@"name":@"订单备注",@"content":@"如货物类型及跟车人数"}, nil];
        _dataSource = [NSArray arrayWithObjects:fArray,sArray,tArray, nil];
    }
    return _dataSource;
}

- (NSMutableArray *)cellSource{
    if (!_cellSource) {
        _cellSource = [NSMutableArray new];
    }
    return _cellSource;
}

- (CitySendAddressView *)fAddressView{
    return PX_LAZY(_fAddressView, ({
        _fAddressView = [[CitySendAddressView alloc] init];
        [self.hSectionView addSubview:_fAddressView];
        _fAddressView.sd_layout
            .leftSpaceToView(self.hSectionView, 0)
            .rightSpaceToView(self.hSectionView, 0)
            .topSpaceToView(self.hSectionView, 0)
            .heightIs(50);
        _fAddressView;
    }));
}

- (CitySendAddressView *)sAddressView{
    return PX_LAZY(_sAddressView, ({
        _sAddressView = [[CitySendAddressView alloc] init];
        [self.hSectionView addSubview:_sAddressView];
        _sAddressView.sd_layout
            .leftSpaceToView(self.hSectionView, 0)
            .rightSpaceToView(self.hSectionView, 0)
            .topSpaceToView(self.fAddressView, 0)
            .heightIs(50);
        _sAddressView;
    }));
}

- (CitySendBottomView *)mBottomView{
    return PX_LAZY(_mBottomView, ({
        CitySendBottomView *view = [[CitySendBottomView alloc] init];
        [self.view addSubview:view];
        view.sd_layout
            .leftSpaceToView(self.view, 0)
            .topSpaceToView(self.vScrollView, 0)
            .bottomSpaceToView(self.view, 50)
            .rightSpaceToView(self.view, 0);
        view;
    }));
}

@end
