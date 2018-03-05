//
//  orderViewController.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "orderViewController.h"
#import "OrderCenterVC.h"

@interface orderViewController ()

@end

@implementation orderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.hidden = YES;
    OrderCenterVC *vc = [[OrderCenterVC alloc] init];
    vc.view.frame = PX_SCREEN_BOUNDS;
    [self addChildViewController:vc];
    [self.view addSubview:vc.view];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

@end
