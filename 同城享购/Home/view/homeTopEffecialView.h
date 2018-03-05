//
//  homeTopEffecialView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/1/31.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeTopEffecialView : UIVisualEffectView

@property (weak, nonatomic) IBOutlet UIImageView *themeImageView;
@property (weak, nonatomic) IBOutlet UIView *locateBgView;
@property (weak, nonatomic) IBOutlet UILabel *locateNameLabel;

@property (weak, nonatomic) IBOutlet UIView *searchBarBgView;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *searchBarHeightConstraint;

@property (nonatomic,strong) void(^changeLocatePress)(void);
@property (nonatomic,strong) void(^keyWordSearch)(void);

@end
