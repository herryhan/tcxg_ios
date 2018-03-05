//
//  homeHeaderView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/31.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "homeTopView.h"

@implementation homeTopView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"homeTopView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
                UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
                [effectView setFrame:self.frame];
               // self.alpha = 0.8;
                [self insertSubview:effectView atIndex:0];
            }
        }
    }
    
    return self;
}

@end
