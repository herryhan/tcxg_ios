//
//  shopInfoView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/1/15.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeModel.h"

@interface shopInfoView : UIView


@property (weak, nonatomic) IBOutlet UIImageView *imageBgView;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
@property (strong, nonatomic) void(^close)(void);

- (void)configWith:(homeModel *)model;

@end
