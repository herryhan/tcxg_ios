//
//  activityLabelView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "activityLabelView.h"

@implementation activityLabelView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        NSArray *arrayOfViews = [[NSBundle mainBundle]loadNibNamed:@"activityLabelView" owner:self options:nil];
        if (arrayOfViews.count<1) {
            return nil;
        }else{
            for (id obj in arrayOfViews) {
                if ([obj isKindOfClass:[activityLabelView class]]) {
                    self = obj;
                    self.frame = frame;
                    self.activityNameLabel.backgroundColor = [UIColor redColor];
                    self.activityNameLabel.layer.cornerRadius = 2;
                    self.activityNameLabel.layer.masksToBounds = YES;
                }
            }
        }
        
    }
    return self;
    
}
- (void)setValueWithDic:(NSDictionary *)dic{
    
    self.activityNameLabel.text =dic[@"type"];
    self.activityContentLabel.text =dic[@"name"];
}
@end
