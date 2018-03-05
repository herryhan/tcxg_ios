//
//  GoodsCommentVC.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsCommentVC.h"
#import "GoodsCommentTextView.h"
#import <UITextView-WZB/UITextView+WZB.h>
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface GoodsCommentVC ()<GoodsCommentTextViewDelegate>
{
    UIScrollView *_mScrollView;
    GoodsCommentTextView *_mShopCommentView;
    GoodsCommentTextView *_mRiderCommentView;
    UIButton *_mSubmitButton;
}
//** shopCommentText */
@property (nonatomic,copy) NSString * mShopCommentText;
//** riderCommentText */
@property (nonatomic,copy) NSString * mRiderCommentText;
//** shopStarRate */
@property (nonatomic,assign) NSInteger  mShopStarRate;
//** riderStarRate */
@property (nonatomic,assign) NSInteger  mRiderStarRate;
@end

@implementation GoodsCommentVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:PX_COLOR_HEX(@"ffffff"),NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"发布评价";
    
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    [self setupView];
}

- (void)setupView{
    _mScrollView = [UIScrollView new];
    [self.view addSubview:_mScrollView];
    _mScrollView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 50, 0));
    
    _mShopCommentView = [GoodsCommentTextView new];
    _mRiderCommentView = [GoodsCommentTextView new];
    [_mScrollView sd_addSubviews:@[_mShopCommentView,_mRiderCommentView]];
    
    _mShopCommentView.sd_layout
        .leftSpaceToView(_mScrollView, 0)
        .topSpaceToView(_mScrollView, 0)
        .rightSpaceToView(_mScrollView, 0);
    
    _mRiderCommentView.sd_layout
        .leftEqualToView(_mShopCommentView)
        .rightEqualToView(_mShopCommentView)
        .topSpaceToView(_mShopCommentView, 15);
    
    _mShopCommentView.mNameLabel.text = @"评论商家";
    _mShopCommentView.mTextView.wzb_placeholder = @"请填写对商家的评论，啦啦啦啦啦";
    _mShopCommentView.delegate = self;
    
    _mRiderCommentView.mNameLabel.text = @"评论骑手";
    _mRiderCommentView.mTextView.wzb_placeholder = @"请填写对骑手的评论，啦啦啦啦啦";
    _mRiderCommentView.delegate = self;
    
    [_mScrollView setupAutoContentSizeWithBottomView:_mRiderCommentView bottomMargin:15];
    
    UIView *backView = [UIView new];
    [self.view addSubview:backView];
    backView.backgroundColor = PX_COLOR_HEX(@"ffffff");
    backView.sd_layout
        .leftSpaceToView(self.view, 0)
        .rightSpaceToView(self.view, 0)
        .topSpaceToView(_mScrollView, 0)
        .bottomSpaceToView(self.view, 0);
    
    _mSubmitButton = [[UIButton alloc] init];
    [backView addSubview:_mSubmitButton];
    _mSubmitButton.sd_layout
        .rightSpaceToView(backView, 0)
        .topSpaceToView(backView, 0)
        .bottomSpaceToView(backView, 0);
    _mSubmitButton.titleLabel.font = Font(15);
    [_mSubmitButton setTitle:@"提交评价" forState:UIControlStateNormal];
    [_mSubmitButton setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"#2C6211")] forState:UIControlStateNormal];
    [_mSubmitButton setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"999999")] forState:UIControlStateDisabled];
    [_mSubmitButton setTitleColor:PX_COLOR_HEX(@"ffffff") forState:UIControlStateNormal];
    [_mSubmitButton setupAutoSizeWithHorizontalPadding:25 buttonHeight:50];
    
    _mSubmitButton.enabled = NO;
}

- (void)commentTextView:(GoodsCommentTextView *)view starRate:(CGFloat)starRate commentText:(NSString *)text{
    PXDALog(@"%@======%.2f",text,starRate);
    if (view == _mShopCommentView) {
        self.mShopStarRate = ceilf(starRate);
        self.mShopCommentText = text;
    }else{
        self.mRiderStarRate = ceilf(starRate);
        self.mRiderCommentText = text;
    }
    if (self.mShopStarRate > 0 && self.mRiderStarRate > 0 &&
        self.mShopCommentText.length > 0 && self.mRiderCommentText.length > 0) {
        _mSubmitButton.enabled = YES;
    }else{
        _mSubmitButton.enabled = NO;
    }
}

@end
