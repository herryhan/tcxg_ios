//
//  HxwTabBarController.m
//  KaPaVideo
//
//  Created by herryhan on 16/5/17.
//  Copyright © 2016年 Candy. All rights reserved.
//

#import "HxwTabBarController.h"
#import "JTNavigationController.h"

#import "homeViewController.h"
#import "classifyViewController.h"
#import "citySendViewController.h"
#import "orderViewController.h"
#import "myViewController.h"

#define SCREEN_H         [[UIScreen mainScreen] bounds].size.height
#define SCREEN_W         [[UIScreen mainScreen] bounds].size.width

#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

@interface HxwTabBarController ()

@property (nonatomic, retain) UIButton *previousBtn;

@end

@implementation HxwTabBarController

- (UIButton *)previousBtn{
    if (!_previousBtn) {
        _previousBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _previousBtn;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //首页nav
    homeViewController *homeVc = [[homeViewController alloc] init];
    JTNavigationController *homeNav = [[JTNavigationController alloc] initWithRootViewController:homeVc];
    
    //分类Nav
    classifyViewController *classifyVc = [[classifyViewController alloc] init];
    
    JTNavigationController *classifyNav=[[JTNavigationController alloc]initWithRootViewController:classifyVc];
    
    //同城配送Nav
    citySendViewController *citySendVc = [[citySendViewController alloc] init];
    JTNavigationController *citySendNav = [[JTNavigationController alloc]initWithRootViewController:citySendVc];
    
    //订单Nav
    orderViewController *orderVc = [[orderViewController alloc]init];
    JTNavigationController *orderNav = [[JTNavigationController alloc]initWithRootViewController:orderVc];
    
    //我的Nav
     myViewController *myVc=[[myViewController alloc]init];
    JTNavigationController *myNav=[[JTNavigationController alloc]initWithRootViewController:myVc];
    
    
    self.viewControllers = @[homeNav,classifyNav,citySendNav,orderNav,myNav];
    
    NSArray *tabArr = @[@{@"image": @"menu11",@"selectimage": @"menu12",@"title": @"首页"},@{@"image": @"menu21",@"selectimage": @"menu22",@"title": @"分类"},@{@"image": @"menu31",@"selectimage": @"menu32",@"title": @"同城配送"},@{@"image": @"menu41",@"selectimage": @"menu42",@"title": @"订单"},@{@"image": @"menu51",@"selectimage": @"menu52",@"title": @"我的"}];
    
    [self customTabbarViewInit:tabArr];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Custom Action

// 按钮被点击时调用

- (void)changeViewController:(UIButton *)sender
{
    self.previousBtn.selected = NO;
  
    self.previousBtn = sender;
    self.previousBtn.selected = YES;
    self.previousBtn.userInteractionEnabled = NO;
    //选中viewcontrollview
    self.selectedIndex = (sender.tag - 100);
}

//初始化自定义的tabbarview

- (void)customTabbarViewInit:(NSArray *)tabArr
{
    CGRect rect = CGRectMake(0,0,SCREEN_WIDTH,SCREEN_HEIGHT);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context =UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    [self.tabBar setBackgroundImage:img];
    
    [self.tabBar setShadowImage:img];
    
    self.tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tabBar.bounds.size.width, SafeAreaBottomHeight)];
    self.tabBarView.backgroundColor=[UIColor whiteColor];
    //self.tabBarView.alpha=0.99f;
    self.tabBarView.userInteractionEnabled = YES;
   // self.tabBarView.image = [UIImage imageNamed:@"TabBar_BG"];
    self.tabBarView.image = [self createImageWithColor:[UIColor whiteColor]];
    self.tabBar.layer.borderWidth = 0.5;
    self.tabBar.layer.borderColor = UIColorFromRGBA(228, 228, 230, 1).CGColor;

    self.tabBar.tintColor= [UIColor colorWithRed:0.85 green:0.32 blue:0.65 alpha:1];;
    
    for (int i = 0; i < tabArr.count; i++) {
        
        NSDictionary *tempdic = [tabArr objectAtIndex:i];
        [self creatButtonWithNormalName:[tempdic objectForKey:@"image"] andSelectName:[tempdic objectForKey:@"selectimage"] andTitle:[tempdic objectForKey:@"title"] andIndex:i totalNum:tabArr.count];
        
    }
    
    //tabbar修改
    [[self.tabBar subviews] makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    [self.tabBar insertSubview:self.tabBarView atIndex:0];
    if (([[[UIDevice currentDevice] systemVersion] floatValue] > 7.0) || ([[[UIDevice currentDevice] systemVersion] floatValue] == 7.0)) {
        // self.tabBar.barTintColor = [UIColor redColor];
        self.tabBar.barStyle = 1;
    }
    //self.tabBar.clipsToBounds = true;
    [self.tabBar bringSubviewToFront:self.tabBarView];
    
}

- (UIImage*)createImageWithColor:(UIColor*)color{
    
    CGRect rect=CGRectMake(0.0f,0.0f,1.0f,1.0f);UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context=UIGraphicsGetCurrentContext();CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage*theImage=UIGraphicsGetImageFromCurrentImageContext();UIGraphicsEndImageContext();
    
    return theImage;
    
}

- (void)creatButtonWithNormalName:(NSString *)normal andSelectName:(NSString *)selected andTitle:(NSString *)title andIndex:(int)index totalNum:(NSUInteger)tabNum
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.tag = index + 100;
    CGFloat buttonW = _tabBarView.frame.size.width / tabNum;
    CGFloat buttonH = _tabBarView.frame.size.height;
    
    button.frame = CGRectMake( buttonW*index, 0, buttonW, buttonH);
   
    [button setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGBA(105, 105, 105, 1) forState:UIControlStateNormal];
    [button setTitleColor:RGBACOLOR(27, 197, 59, 1.0) forState:UIControlStateSelected];
    button.imageView.contentMode = UIViewContentModeCenter; // 让图片在按钮内居中
    button.titleLabel.textAlignment = NSTextAlignmentCenter; // 让标题在按钮内居中
    button.titleLabel.font = [UIFont systemFontOfSize:10]; // 设置标题的字体大小
    //设置按钮中图片和label对象的位置
    CGSize imageSize = button.imageView.frame.size;
    CGSize titleSize = button.titleLabel.frame.size;
    button.imageEdgeInsets = UIEdgeInsetsMake(-10.0, 0.0, 0.0, -titleSize.width);
    button.titleEdgeInsets = UIEdgeInsetsMake(imageSize.height+5.0, - imageSize.width, 0.0, 0.0);
    button.adjustsImageWhenHighlighted = NO;
    [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
    [self.tabBarView addSubview:button];
    if (index == 3) {
        self.previousBtn = button;
        self.previousBtn.selected = YES;
        self.previousBtn.userInteractionEnabled = NO;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
