//
//  cartHeadView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/11.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "cartHeadView.h"

@implementation cartHeadView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"carHeadView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                self.backgroundColor = UIColorFromRGBA(244, 244, 244, 1);
                [self uiconfig];
            }
        }
    }
    
    return self;
}
- (void)uiconfig{
    
}
@end
