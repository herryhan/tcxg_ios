//
//  myHeaderView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/16.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "myHeaderView.h"

@implementation myHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"myHeaderView" owner:self options:nil];
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

- (void)uiconfig{
    self.headerBgImageView.tag = 101;
    self.headerBgImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.cashBtn.titleEdgeInsets = UIEdgeInsetsMake(30, 0, 0,0);
    
    self.cashView.userInteractionEnabled = YES;
    self.quanView.userInteractionEnabled = YES;
    
    __weak typeof(self) weakSelf = self;
    [self.cashView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        weakSelf.delegate?[weakSelf.delegate headerView:weakSelf didClickAtView:weakSelf.cashView]:nil;
    }]];
    [self.quanView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        weakSelf.delegate?[weakSelf.delegate headerView:weakSelf didClickAtView:weakSelf.quanView]:nil;
    }]];
}

@end
