//
//  LoginViewController.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/23.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UIAccelerometerDelegate,WXApiDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UIButton *getCodeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self uiconfig];
    [SVProgressHUD setBackgroundColor:[UIColor blackColor]];

}

- (void)uiconfig{
    
    NSAttributedString *phoneAttrString = [[NSAttributedString alloc] initWithString:@"请输入号码" attributes:
                                      @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                        NSFontAttributeName:self.phoneText.font
                                        }];
    self.phoneText.attributedPlaceholder = phoneAttrString;
    
    NSAttributedString *codeAttrString = [[NSAttributedString alloc] initWithString:@"请填写验证码" attributes:
                                           @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                             NSFontAttributeName:self.codeText.font
                                             }];
    self.codeText.attributedPlaceholder = codeAttrString;

    self.submitBtn.layer.cornerRadius = 20;
    self.submitBtn.layer.borderWidth = 0.5;
    self.submitBtn.layer.borderColor = [UIColor whiteColor].CGColor;
    
    //注册登陆成功的通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(wxLoginSuccess:) name:@"wxLoginSuccess" object:nil];
    
}

- (void)wxLoginSuccess:(NSNotification *)noti{
    NSLog(@"%@",noti.object[@"code"]);
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"code"] = noti.object[@"code"];
    parmas[@"uuid"] = Uid;
    parmas[@"channelId"] = @"5637447362195603251";
    parmas[@"os"] = @"ios";
    parmas[@"locate"] = @(1);
    [URLRequest postWithURL:@"login/wx" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",[cityShoppingTool jsonConvertToDic:responseObject]);
        if ([[cityShoppingTool jsonConvertToDic:responseObject][@"state"] isEqualToString:@"ok"]) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                [SVProgressHUD showSuccessWithStatus:@"登陆成功"];
                [[NSNotificationCenter defaultCenter] removeObserver:self];
            }];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

- (IBAction)backBtn:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    
    return UIStatusBarStyleLightContent;
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self.phoneText resignFirstResponder];
    [self.codeText resignFirstResponder];
    
}
- (IBAction)getCodePress:(UIButton *)sender {
    [self.phoneText resignFirstResponder];
    [self.codeText resignFirstResponder];
    if ([hudCustom isValidateMobileNumber:self.phoneText.text]) {
        [self.phoneText resignFirstResponder];
        __block NSInteger time = 59; //倒计时时间
        
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        
        dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
        
        dispatch_source_set_event_handler(_timer, ^{
            
            if(time <= 0){ //倒计时结束，关闭
                
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置按钮的样式
                    [self.getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                    self.getCodeBtn.userInteractionEnabled = YES;
                });
                
            }else{
                
                int seconds = time % 60;
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    //设置按钮显示读秒效果
                    [self.getCodeBtn setTitle:[NSString stringWithFormat:@"%.2ds", seconds] forState:UIControlStateNormal];
                    self.getCodeBtn.userInteractionEnabled = NO;
                });
                time--;
            }
        });
        dispatch_resume(_timer);
        /***请求验证码***/
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        parmas[@"channelId"] = @"5637447362195603251";
        parmas[@"la"] = @"";
        parmas[@"lo"] = @"";
        parmas[@"locate"] = @"1";
        parmas[@"os"] = @"ios";
        parmas[@"tel"] = self.phoneText.text;
        parmas[@"uuid"] = Uid;
        [URLRequest postWithURL:@"send/sms" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
            NSLog(@"%@",responseObject);
            NSString *string = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"dddd   %@",string);
            if ([string isEqualToString:@"'ok'"]) {
                [SVProgressHUD showSuccessWithStatus:@"发送成功"];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error){
            NSLog(@"%@",error);
        }];
    }else{
        [SVProgressHUD showInfoWithStatus:@"号码格式不正确"];
    }
}

/**登陆按钮**/
- (IBAction)LoginPress:(UIButton *)sender{
    
    [self.phoneText resignFirstResponder];
    [self.codeText resignFirstResponder];
    if (self.phoneText.text.length == 0 || self.codeText.text.length == 0){
        [SVProgressHUD showErrorWithStatus:@"号码或验证码不能为空"];
    }
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"channelId"] = @"5637447362195603251";
    parmas[@"la"] = @"";
    parmas[@"lo"] = @"";
    parmas[@"locate"] = @"1";
    parmas[@"os"] = @"ios";
    parmas[@"tel"] = self.phoneText.text;
    parmas[@"uuid"] = Uid;
    parmas[@"code"] = self.codeText.text;
    
    [URLRequest postWithURL:@"login" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",responseObject);
        NSString *resString = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if ([resString isEqualToString:@"'ok'"]) {
            
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
            
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (IBAction)wxLoginPress:(UIButton *)sender {
    SendAuthReq* req =[[SendAuthReq alloc ] init];
    req.scope = @"snsapi_userinfo" ;
    req.state = @"tcxg" ;
    //第三方向微信终端发送一个SendAuthReq消息结构
    [WXApi sendAuthReq:req viewController:self delegate:self];
}

@end
