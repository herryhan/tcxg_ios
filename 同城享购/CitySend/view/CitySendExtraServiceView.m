//
//  CitySendExtraServiceView.m
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CitySendExtraServiceView.h"

@interface CitySendExtraServiceView()
@property (nonatomic,strong) NSArray <NSString *>* dataSource;
@end

@implementation CitySendExtraServiceView

- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray<NSString *> *)dataSource{
    if (self = [super initWithFrame:frame]) {
        self.dataSource = dataSource;
        [self px_setupView];
    }
    return self;
}

- (void)px_setupView{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    self.backgroundColor = [UIColor colorWithHexString:@"333333" alpha:.4];
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, PX_SCREEN_HEIGHT, PX_SCREEN_WIDTH, 0)];
    [self addSubview:backView];
    backView.backgroundColor = PX_COLOR_HEX(@"ffffff");
    UIView *temp = nil;
    NSMutableArray *tempArray = [NSMutableArray new];
    for (NSString *str in self.dataSource) {
        CitySendExtraServiceCellView *cell = [[CitySendExtraServiceCellView alloc] initWithFrame:CGRectMake(0, temp==nil?0:temp.bottom, PX_SCREEN_WIDTH, 50)];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(15, cell.bottom, PX_SCREEN_WIDTH - 30, .8f)];
        lineView.backgroundColor = PX_COLOR_HEX(@"dadada");
        [backView addSubview:cell];
        [backView addSubview:lineView];
        cell.mLabel.text = str;
        temp = lineView;
        [tempArray addObject:cell];
    }
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(15, temp.bottom + 5, PX_SCREEN_WIDTH - 30, 40)];
    [backView addSubview:button];
    button.backgroundColor = PX_COLOR_HEX(@"57e038");
    backView.height = button.bottom + 10;
    [button setTitle:@"确 定" forState:UIControlStateNormal];
    button.titleLabel.font = Font(18);
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        NSMutableArray *arr = [NSMutableArray new];
        for (CitySendExtraServiceCellView *cell in tempArray) {
            if (cell.mButton.selected) [arr addObject:@([tempArray indexOfObject:cell])];
        }
        self.ExtraServiceCallBack?self.ExtraServiceCallBack(arr):nil;
        [self hide:backView];
    }];
    
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        [self hide:backView];
    }]];
    
    [self showAnimation:backView];
}

- (void)showAnimation:(UIView *)view{
    [UIView animateWithDuration:.5f animations:^{
        view.top = PX_SCREEN_HEIGHT - view.height;
    }];
}

- (void)hide:(UIView *)view{
    [UIView animateWithDuration:.5f animations:^{
        view.top = PX_SCREEN_HEIGHT;
    } completion:^(BOOL finished) {
        [self removeAllSubviews];
        [self removeFromSuperview];
    }];
}

@end

@implementation CitySendExtraServiceCellView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIImageView *imgv = [[UIImageView alloc] init];
    [self addSubview:imgv];
    imgv.sd_layout
        .rightSpaceToView(self, 5)
        .centerYEqualToView(self)
        .widthIs(30)
        .heightEqualToWidth();
    imgv.image = PX_IMAGE_NAMED(@"减号");
    self.mImageView = imgv;
    
    UILabel *label = [[UILabel alloc] init];
    [self addSubview:label];
    label.sd_layout
        .leftSpaceToView(self, 15)
        .rightSpaceToView(self.mImageView, 10)
        .topSpaceToView(self, 5)
        .bottomSpaceToView(self, 5);
    label.font = Font(15);
    label.textColor = PX_COLOR_HEX(@"333333");
    self.mLabel = label;
    
    UIButton *button = [[UIButton alloc] init];
    [self addSubview:button];
    button.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    self.mButton = button;
    __weak typeof(button) btn = button;
    __weak typeof(imgv) img = imgv;
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        btn.selected = !btn.selected;
        img.image = btn.selected?PX_IMAGE_NAMED(@"加号"):PX_IMAGE_NAMED(@"减号");
    }];
}

@end
