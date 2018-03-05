//
//  HxwTabBarController.h
//  KaPaVideo
//
//  Created by herryhan on 16/5/17.
//  Copyright © 2016年 Candy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HxwTabBarController : UITabBarController

- (void)customTabbarViewInit:(NSArray *)tabArr;
- (void)changeViewController:(UIButton *)sender;
@property (nonatomic, retain) UIImageView *tabBarView;


@end
