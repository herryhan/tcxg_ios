//
//  SameCityOrderVC.m
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "SameCityOrderVC.h"
#import "SameCityOrderListVC.h"

@interface SameCityOrderVC ()
{
    NSArray *vcs;
}
@end

@implementation SameCityOrderVC

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.menuViewStyle      = WMMenuViewStyleLine;
        self.titleSizeSelected  = 15.0f;
        self.titleSizeNormal    = 15.0f;
        self.titleColorNormal   = PX_COLOR_HEX(@"333333");
        self.titleColorSelected = PX_COLOR_HEX(@"57e038");
        vcs                     = @[@"全部",@"配送中",@"待评价",@"退款中"];
        self.progressHeight     = 3.0f;
        self.menuView.backgroundColor = PX_COLOR_HEX(@"ffffff");
        self.progressColor      = PX_COLOR_HEX(@"57e038");
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = PX_COLOR_HEX(@"ffffff");
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return vcs.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    SameCityOrderListVC *vc = [SameCityOrderListVC new];
    vc.type = index;
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return [vcs objectAtIndex:index];
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView{
    return CGRectMake(0, 0, PX_SCREEN_WIDTH, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView{
    return self.view.bounds;
}

@end
