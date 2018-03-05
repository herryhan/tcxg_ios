//
//  goodsViewController.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/13.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "homeModel.h"
#import "shopViewController.h"

@interface goodsViewController : UIViewController

//抛物线红点
@property (strong, nonatomic) UIImageView *redView;

@property (nonatomic,strong) homeModel *shopModel;

@property (nonatomic,strong) NSDictionary *shopCartDict;

@property (nonatomic,strong) shopViewController *fatherVc;

@property float lat;
@property float lon;

@end
