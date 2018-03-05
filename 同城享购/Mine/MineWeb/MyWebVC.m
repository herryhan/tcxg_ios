//
//  MyWebVC.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "MyWebVC.h"
#import <WebKit/WebKit.h>

@interface MyWebVC ()<WKNavigationDelegate>
//** webView */
@property (nonatomic,weak) WKWebView * mWebView;
@end

@implementation MyWebVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:PX_COLOR_HEX(@"57e038")] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:PX_COLOR_HEX(@"ffffff"),NSForegroundColorAttributeName, nil]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
    
}

- (void)setupView{
    WKWebView *view = [[WKWebView alloc] init];
    [self.view addSubview:view];
    view.navigationDelegate = self;
    view.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    [view loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]]];
    self.mWebView = view;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [SVProgressHUD showWithStatus:@"加载中…"];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [SVProgressHUD dismiss];
}

@end
