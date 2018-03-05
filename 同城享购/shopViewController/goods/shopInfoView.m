//
//  shopInfoView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/15.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "shopInfoView.h"

@implementation shopInfoView

-(instancetype) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"shopInfoView" owner:self options:nil];
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
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    // 生成特定样式的模糊效果
  
    self.imageBgView.layer.cornerRadius = 5;
    self.imageBgView.layer.masksToBounds = YES;

}

- (IBAction)closeBtnPress:(UIButton *)sender {
    _close();
}

- (void)configWith:(homeModel *)model{
    [self.imageBgView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [effectView setFrame:self.imageBgView.bounds];
    [self.imageBgView  addSubview:effectView];
}

@end
