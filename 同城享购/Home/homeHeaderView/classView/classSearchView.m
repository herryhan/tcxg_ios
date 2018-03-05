//
//  classSearchView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/22.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "classSearchView.h"

@implementation classSearchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"classView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                if ([obj isKindOfClass:[classSearchView class]]) {
                    self = obj;
                    self.frame = frame;
                }
            }
        }
    }
    
    return self;
}

@end
