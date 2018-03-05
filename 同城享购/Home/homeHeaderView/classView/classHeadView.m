//
//  classHeadView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/22.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "classHeadView.h"

@implementation classHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"classView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                if ([obj isKindOfClass:[classHeadView class]]) {
                    self = obj;
                    self.frame = frame;
                }
            }
        }
    }
    
    return self;
}

@end
