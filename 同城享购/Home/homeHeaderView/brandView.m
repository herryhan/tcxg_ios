//
//  brandView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "brandView.h"

@implementation brandView
- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle]loadNibNamed:@"brandView" owner:self options:nil];
        if (arrayOfViews.count<1) {
            return nil;
        }else{
            for (id obj in arrayOfViews) {
                if ([obj isKindOfClass:[brandView class]]) {
                    self = obj;
                    self.frame = frame;
                    self.firstConstraint.constant = SCREEN_WIDTH/3-2;
                   // self.backgroundColor = [UIColor lightGrayColor];
                }
                
            }
        }
        
    }
    return self;
    
}

@end
