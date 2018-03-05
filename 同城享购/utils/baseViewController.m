//
//  baseViewController.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "baseViewController.h"

@interface baseViewController ()

@end

@implementation baseViewController

-(UIImageView *)navView{
    if (!_navView) {
        if (IPHONE_X ) {
            _navView=[[UIImageView alloc]initWithFrame:CGRectMake(0,-44, SCREEN_WIDTH, 88)];
        }else{
            _navView=[[UIImageView alloc]initWithFrame:CGRectMake(0,-20, SCREEN_WIDTH, 64)];
        }
        [_navView setImage:[self createImageWithColor:UIColorFromRGBA(68, 195, 34, 1) andSize:CGSizeMake(1, 1)]];
    }
    return _navView;
}

//- (UIStatusBarStyle)preferredStatusBarStyle
//{
//
//    return UIStatusBarStyleLightContent;
//
//}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    //去掉分割线
    self.navigationController.navigationBar.shadowImage = [UIImage new];
   // [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGBA(244, 244, 244, 1);
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar addSubview:self.navView];
//    [self.navigationController.navigationBar insertSubview:self.navView atIndex:0];
//    self.navView.layer.zPosition = -1;
}

- (void)contitle:(NSString *)viewtitle WithColor:(UIColor *)color{
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    [customLab setTextColor:color];
    [customLab setText:viewtitle];
    customLab.textAlignment = NSTextAlignmentCenter;
    customLab.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    
    // customLab.backgroundColor = [UIColor redColor];
    self.navigationItem.titleView = customLab;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIImage*)createImageWithColor:(UIColor*)color andSize:(CGSize)size
{
    CGRect rect=CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


@end

