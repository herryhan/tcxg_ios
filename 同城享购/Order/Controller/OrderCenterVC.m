//
//  OrderCenterVC.m
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "OrderCenterVC.h"
#import "GoodsOrderVC.h"
#import "SameCityOrderVC.h"

@interface OrderCenterVC ()
{
    NSArray *vcs;
}
@end

@implementation OrderCenterVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuViewStyle      = WMMenuViewStyleLine;
        self.titleSizeSelected  = 18.0f;
        self.titleSizeNormal    = 18.0f;
        self.titleColorNormal   = PX_COLOR_HEX(@"333333");
        self.titleColorSelected = PX_COLOR_HEX(@"57e038");
        vcs                     = @[@"商品订单",@"同城订单"];
        self.menuItemWidth      = 120.0f;
        self.progressViewWidths = @[@50, @50];
        self.progressHeight     = 3.0f;
        self.menuView.backgroundColor = PX_COLOR_HEX(@"ffffff");
        self.progressColor      = PX_COLOR_HEX(@"57e038");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return vcs.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    UIViewController *vc = index == 0 ? [GoodsOrderVC new] : [SameCityOrderVC new];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [vcs objectAtIndex:index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, 20, PX_SCREEN_WIDTH, 44);
}

@end
