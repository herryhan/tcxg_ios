//
//  AppDelegate.m
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"

#import <AMapFoundationKit/AMapFoundationKit.h>

@interface AppDelegate ()<CLLocationManagerDelegate,WXApiDelegate>
{
    CLLocationManager *locationManager;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [UIApplication sharedApplication].statusBarHidden=NO;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    JTBaseNavigationController * rootView = nil;
   
    self.hxwTAB=[[CDTabbarVC alloc]init];
    rootView = [[JTBaseNavigationController alloc]initWithRootViewController:self.hxwTAB];
    self.window.rootViewController = rootView;
    [self.window makeKeyAndVisible];
 
    if (@available(ios 11.0,*)) {
        UITableView.appearance.estimatedRowHeight = 0;
        UITableView.appearance.estimatedSectionFooterHeight = 0;
        UITableView.appearance.estimatedSectionHeaderHeight = 0;
    }
    //登陆通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(strongLogin) name:@"loginAction" object:nil];
    
    //初始化高德地图
    [self getLocationService];
    [AMapServices sharedServices].apiKey = @"9794b4f62c2ef383b60214e88d08e211";
//
//   //判断是否已经有uuid
//
    if ([keepUserInfoHandle readUserInfoWith:1].length ==0) {
         NSString *deviceUUID = [[UIDevice currentDevice].identifierForVendor UUIDString];
        NSLog(@"%@",deviceUUID);
        [keepUserInfoHandle saveUserInfo:deviceUUID withInfoType:1];
    }
    //初始化微信sdk
    [WXApi registerApp:@"wx34174b932ecf79bf"];
    //向微信注册支持的文件类型
    UInt64 typeFlag = MMAPP_SUPPORT_TEXT | MMAPP_SUPPORT_PICTURE | MMAPP_SUPPORT_LOCATION | MMAPP_SUPPORT_VIDEO |MMAPP_SUPPORT_AUDIO | MMAPP_SUPPORT_WEBPAGE | MMAPP_SUPPORT_DOC | MMAPP_SUPPORT_DOCX | MMAPP_SUPPORT_PPT | MMAPP_SUPPORT_PPTX | MMAPP_SUPPORT_XLS | MMAPP_SUPPORT_XLSX | MMAPP_SUPPORT_PDF;
    
    [WXApi registerAppSupportContentFlag:typeFlag];
    //初始化百度推送
    return YES;
}

//获取位置的权限
- (void)getLocationService{
    
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager requestWhenInUseAuthorization];
    
}
//登陆
- (void)strongLogin{
    
    LoginViewController *logionVc = [[LoginViewController alloc]init];
    [self.hxwTAB presentViewController:logionVc animated:YES completion:^{
        
    }];
    
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL isSuc = [WXApi handleOpenURL:url delegate:self];
    NSLog(@"url %@ isSuc %d",url,isSuc == YES ? 1 : 0);
    return  isSuc;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendAuthResp class]]){
        SendAuthResp *rep = (SendAuthResp *)resp;
        if (rep.errCode == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"wxLoginSuccess" object:@{@"code":rep.code}];
        }
    }
}


@end
