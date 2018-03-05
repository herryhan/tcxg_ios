//
//  nearShopView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "nearShopView.h"

@implementation nearShopView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"nearShopView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self configUI];
                _indexTag = 1001;
                self.sumButton.selected = YES;
                self.backgroundColor = [UIColor whiteColor];
            }
        }
    }
    
    return self;
}
- (void)configUI{
    
    [self.sumButton setTitleColor:UIColorFromRGBA(104, 104, 104, 1) forState:UIControlStateNormal];
    [self.sumButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [self.topSaleButton setTitleColor:UIColorFromRGBA(104, 104, 104, 1) forState:UIControlStateNormal];
    [self.topSaleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [self.qunlityButton setTitleColor:UIColorFromRGBA(104, 104, 104, 1) forState:UIControlStateNormal];
    [self.qunlityButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
    [self.distanceButton setTitleColor:UIColorFromRGBA(104, 104, 104, 1) forState:UIControlStateNormal];
    [self.distanceButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
    
}

- (IBAction)sum:(UIButton *)sender {
    if (_indexTag != sender.tag) {
        
        if (_sum) {
            _sum(sender.tag);
        }
        UIButton *btn = (UIButton *)[self viewWithTag:_indexTag];
        btn.selected = NO;
        _indexTag = sender.tag;
        sender.selected = YES;
    }
    NSLog(@"you are the first one!");
}

- (IBAction)topSale:(UIButton *)sender {
    if (_indexTag != sender.tag) {
        
        if (_topSale) {
            _topSale(sender.tag);
        }
        UIButton *btn = (UIButton *)[self viewWithTag:_indexTag];
        btn.selected = NO;
        _indexTag = sender.tag;
        sender.selected = YES;
    }
}

- (IBAction)qunlity:(UIButton *)sender {
    if (_indexTag != sender.tag) {
        
        if (_qunlity) {
            _qunlity(sender.tag);
        }
        UIButton *btn = (UIButton *)[self viewWithTag:_indexTag];
        btn.selected = NO;
        _indexTag = sender.tag;
        sender.selected = YES;
    }
}

- (IBAction)distance:(UIButton *)sender {
    if (_indexTag !=sender.tag) {
        if (_distance) {
            _distance(sender.tag);
        }
        UIButton *btn = (UIButton *)[self viewWithTag:_indexTag];
        btn.selected = NO;
        _indexTag = sender.tag;
        sender.selected = YES;
    }
}


@end
