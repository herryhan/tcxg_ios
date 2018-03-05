//
//  bottomView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/15.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "bottomView.h"

@implementation bottomView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"bottom" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self uiconfig];
            }
        }
    }
    
    return self;
}
//-(void)setBadgeValue:(NSInteger)badgeValue{
//
//    _badgeValue = badgeValue;
//    if (badgeValue>0) {
//        self.badgeView.hidden = NO;
//    }
//    else{
//        self.badgeView.hidden = YES;
//    }
//    self.badgeView.textLabel.text = [NSString stringWithFormat:@"%lu",(unsigned long)badgeValue];
//}
- (void)uiconfig{
    
    self.bottomBgView.backgroundColor =UIColorFromRGBA(68, 171, 35, 1);
    self.sureBtn.backgroundColor = UIColorFromRGBA(69, 184, 34, 1);

    self.badgeView = [[BadgeView alloc] initWithFrame:CGRectMake(self.cartBtn.frame.size.width - 18, 5, 18, 18) withString:nil];
    [self.cartBtn addSubview:self.badgeView];
    [self.cartBtn addTarget:self action:@selector(shoppCartClick) forControlEvents:UIControlEventTouchUpInside];
    self.open = YES;
    
    self.overLayView = [[overLayView alloc]initWithFrame:CGRectMake(0, -(SCREEN_HEIGHT-45), SCREEN_WIDTH, SCREEN_HEIGHT-45)];
    [self addSubview:self.overLayView];
    self.overLayView.hidden = YES;

    self.goodsCartView = [[cartView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    [self addSubview:self.goodsCartView];
    [self sendSubviewToBack:self.goodsCartView];
    
}

#pragma mark 结算
- (void)payclick:(id)sender {
    
    
}

#pragma  mark 点击购物车

- (void)shoppCartClick {
    
    if (self.badgeValue<0) {
        [self.cartBtn setUserInteractionEnabled:NO];
        return;
    }
    _showCartView(self.open);
}

- (void)configDataWith:(NSDictionary *)dic{
    
    if ([dic[@"count"] intValue]>0) {
        self.badgeView.hidden = NO;
        NSLog(@"dd");
    }
    else{
        self.badgeView.hidden = YES;
        NSLog(@"ee");
    }
    self.badgeView.textLabel.text = [NSString stringWithFormat:@"%@",dic[@"count"]];
    self.sumPriceLabel.text = [NSString stringWithFormat:@"¥%@",dic[@"money"]];
}


@end
