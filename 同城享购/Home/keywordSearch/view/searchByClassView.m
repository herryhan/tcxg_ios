//
//  searchByClassView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/13.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "searchByClassView.h"

@implementation searchByClassView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"searchAllView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                if ([obj isKindOfClass:[searchByClassView class]]) {
                    self = obj;
                    self.frame = frame;
                    for (int i=1; i<5; i++) {
                        UIButton *btn = [self viewWithTag:100+i];
                        if (i == 1) {
                            btn.selected = YES;
                        }
                        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
                    }
                    _indexTag = 101;
                    
                }
            }
        }
    }
    
    return self;
}

- (void)resetSelected{
     UIButton *selecteBtn = [self viewWithTag:101];
     selecteBtn.selected = YES;
     UIButton *btn = (UIButton *)[self viewWithTag:_indexTag];
     btn.selected = NO;
     _indexTag = 101;
}

- (IBAction)classBtnClick:(UIButton *)sender {
    sender.selected = YES;
    if (_indexTag != sender.tag) {
         _orderTag(sender.tag);
        UIButton *btn = (UIButton *)[self viewWithTag:_indexTag];
        btn.selected = NO;
        _indexTag = sender.tag;
        sender.selected = YES;
    }
}

@end
