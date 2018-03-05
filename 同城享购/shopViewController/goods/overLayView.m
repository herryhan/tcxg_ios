//
//  overLayView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/20.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "overLayView.h"
#import "bottomView.h"

@implementation overLayView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    }
    return self;
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
}



@end
