//
//  CDTabbarVC.m
//  CustomTabbar
//
//  Created by Dong Chen on 2017/8/31.
//  Copyright © 2017年 Dong Chen. All rights reserved.
//

#import "CDTabbarVC.h"
#import "JTNavigationController.h"

#import "homeViewController.h"
#import "classifyViewController.h"
#import "citySendViewController.h"
#import "orderViewController.h"
#import "myViewController.h"

@interface CDTabbarVC ()

@property (nonatomic, strong) homeViewController *oneVC;
@property (nonatomic, strong) classifyViewController *twoVC;
@property (nonatomic, strong) citySendViewController *threeVC;
@property (nonatomic, strong) orderViewController *fourVC;
@property (nonatomic ,strong) myViewController *fiveVC;


@end

@implementation CDTabbarVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self InitView];
    
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    //NSLog(@" --- %@", item.title);
   
}

- (void)InitView
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray *titles = @[@"首页", @"分类", @"同城配送",@"订单",@"我的"];
    NSArray *images = @[@"menu11", @"menu21", @"menu31", @"menu31",@"menu41",@"menu51"];
    NSArray *selectedImages = @[@"menu12", @"menu22", @"menu32", @"menu42",@"menu52"];
    homeViewController * oneVc = [[homeViewController alloc] init];
    self.oneVC = oneVc;
    classifyViewController * twoVc = [[classifyViewController alloc] init];
    self.twoVC = twoVc;
    citySendViewController * threeVc = [[citySendViewController alloc] init];
    self.threeVC = threeVc;
    orderViewController * fourVc = [[orderViewController alloc] init];
    self.fourVC = fourVc;
    myViewController *fiveVc = [[myViewController alloc]init];
    self.fiveVC = fiveVc;
    
    NSArray *viewControllers = @[oneVc, twoVc, threeVc, fourVc,fiveVc];
    for (int i = 0; i < viewControllers.count; i++)
    {
        UIViewController *childVc = viewControllers[i];
        [self setVC:childVc title:titles[i] image:images[i] selectedImage:selectedImages[i]];
    }
}

- (void)setVC:(UIViewController *)VC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    VC.tabBarItem.title = title;
    NSMutableDictionary *normDict = [NSMutableDictionary dictionary];
    normDict[NSForegroundColorAttributeName] = UIColorFromRGBA(105, 105, 105, 1);
    normDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [VC.tabBarItem setTitleTextAttributes:normDict forState:UIControlStateNormal];
    
    NSMutableDictionary *selectedDict = [NSMutableDictionary dictionary];
    selectedDict[NSForegroundColorAttributeName] = UIColorFromRGBA(27, 197, 59, 1.0);
    selectedDict[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [VC.tabBarItem setTitleTextAttributes:selectedDict forState:UIControlStateSelected];
    
    VC.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    VC.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    JTNavigationController *nav = [[JTNavigationController alloc] initWithRootViewController:VC];
    [self addChildViewController:nav];
}

@end
