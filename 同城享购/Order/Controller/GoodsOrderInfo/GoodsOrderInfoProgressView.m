//
//  GoodsOrderInfoProgressView.m
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsOrderInfoProgressView.h"

@interface GoodsOrderInfoProgressView()
{
    UIView *_mLineView;
}
//** itemsSource */
@property (nonatomic,strong) NSMutableArray * itemsSource;
//** labelsSource */
@property (nonatomic,strong) NSMutableArray * labelsSource;
@end

@implementation GoodsOrderInfoProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    //6个点
    _mLineView = [UIView new];
    [self addSubview:_mLineView];
    
    _mLineView.sd_layout
        .leftSpaceToView(self, 15)
        .rightSpaceToView(self, 15)
        .centerYEqualToView(self)
        .heightIs(1);
    _mLineView.backgroundColor = PX_COLOR_HEX(@"efefef");
    
    UIView *backView = [UIView new];
    [self addSubview:backView];
    backView.sd_layout
        .leftSpaceToView(self ,12)
        .rightSpaceToView(self,12)
        .topSpaceToView(_mLineView, -3);
    for (NSInteger index = 0; index < 6; index ++) {
        UIView *view = [UIView new];
        [backView addSubview:view];
        view.sd_layout.heightIs(6);
        view.sd_cornerRadiusFromHeightRatio = @(.5);
        view.backgroundColor = PX_COLOR_HEX(@"666666");
        [self.itemsSource addObject:view];
    }
    [backView setupAutoMarginFlowItems:[self.itemsSource copy] withPerRowItemsCount:6 itemWidth:6 verticalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    
    NSArray *texts = [NSArray arrayWithObjects:@"等待付款",@"订单已提交",@"商家接单",@"骑手取货",@"骑手派送",@"已完成", nil];
    for (NSInteger index = 0; index < 6; index ++) {
        UILabel *view = [UILabel new];
        view.font = Font(10);
        view.textAlignment = NSTextAlignmentCenter;
        view.textColor = PX_COLOR_HEX(@"999999");
        [self addSubview:view];
        CGFloat width = (PX_SCREEN_WIDTH - 90)/5;
        CGFloat pointX = (PX_SCREEN_WIDTH - 90)/5 * index + 15;
        
        if (index % 2 == 0) {
            //0-2-4
            view.sd_layout
                .topSpaceToView(backView, 0)
                .centerXIs(pointX)
                .widthIs(width*2)
                .heightIs(25);
        }else{
            //1-3-5
            view.sd_layout
                .bottomSpaceToView(backView, -0)
                .centerXIs(pointX)
                .widthIs(width*2)
                .heightIs(25);
        }
        view.text = [texts objectAtIndex:index];
        [self.labelsSource addObject:view];
    }
}

- (void)setProgress:(NSInteger)progress{
    UILabel *textLabel = [self.labelsSource objectAtIndex:5];//获得文字label
    UIView *circleView = [self.itemsSource objectAtIndex:5];//获取圆点
    
    //绘制圆环
    UIBezierPath * path = [UIBezierPath bezierPath];

    CGFloat pointX = (PX_SCREEN_WIDTH - 90)/5 * progress + 3;
    [path addArcWithCenter:CGPointMake(pointX, 3) radius:6 startAngle:M_PI endAngle:3*M_PI clockwise:TRUE];
    
    CAShapeLayer * pathLayer = [CAShapeLayer layer];
    pathLayer.path = path.CGPath;
    pathLayer.strokeColor = [PX_COLOR_HEX(@"57e038") CGColor];//画线颜色
    pathLayer.fillColor = [[UIColor clearColor]CGColor];//填充颜色
    pathLayer.lineJoin = kCALineJoinRound;
    pathLayer.lineWidth = 1.0f;
    [circleView.superview.layer addSublayer:pathLayer];
    
    pathLayer.strokeStart = 0;
    pathLayer.strokeEnd = 2 * M_PI;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.duration = 2.f;
    animation.fromValue = @(0);
    animation.toValue = @(1);
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [pathLayer addAnimation:animation forKey:@""];
    
    [UIView animateWithDuration:2.0f animations:^{
        textLabel.textColor = PX_COLOR_HEX(@"57e038");
        circleView.backgroundColor = PX_COLOR_HEX(@"57e038");
    }];
    
}

- (NSMutableArray *)itemsSource{
    return PX_LAZY(_itemsSource, ({
        NSMutableArray *array = [NSMutableArray new];
        array;
    }));
}

- (NSMutableArray *)labelsSource{
    return PX_LAZY(_labelsSource, ({
        NSMutableArray *array = [NSMutableArray new];
        array;
    }));
}

@end
