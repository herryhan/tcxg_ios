//
//  CitySendContacterView.m
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CitySendContacterView.h"

@interface CitySendContacterView()

@end

@implementation CitySendContacterView

+ (void)showCitySendContacterView:(void (^)(CitySendContacterInsert, NSString *, NSString *))action{
    UIButton *cancelButton = [[UIButton alloc] init];
    UIView *backView = [[UIView alloc] init];
    [[[UIApplication sharedApplication] keyWindow] addSubview:cancelButton];
    cancelButton.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    cancelButton.backgroundColor = [UIColor colorWithHexString:@"000000" alpha:.4];
    __weak typeof(cancelButton) weakButton = cancelButton;
    [cancelButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        //点击执行
        __strong typeof(weakButton) btn = weakButton;
        action?action(CitySendContacterInsertCancel,nil,nil):nil;
        [self hideView:backView backView:btn];
    }];
    
    [cancelButton addSubview:backView];
    backView.sd_layout
        .leftSpaceToView(cancelButton, 45)
        .rightSpaceToView(cancelButton, 45)
        .bottomSpaceToView(cancelButton, 268);
    backView.alpha = 0;
    backView.sd_cornerRadius = @(10);
    backView.backgroundColor = PX_COLOR_HEX(@"ffffff");
    
    UILabel *titleLabel = [[UILabel alloc]init];
    [backView addSubview:titleLabel];
    titleLabel.font = Font(15);
    titleLabel.text = @"请输入联系人";
    titleLabel.textColor = PX_COLOR_HEX(@"333333");
    titleLabel.sd_layout
        .leftSpaceToView(backView, 15)
        .rightSpaceToView(backView, 15)
        .topSpaceToView(backView, 10)
        .heightIs(20);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    UITextField *nameTextField = [[UITextField alloc] init];
    [backView addSubview:nameTextField];
    nameTextField.sd_layout
        .leftEqualToView(titleLabel)
        .rightEqualToView(titleLabel)
        .topSpaceToView(titleLabel, 15)
        .heightIs(40);
    nameTextField.backgroundColor = PX_COLOR_HEX(@"efefef");
    nameTextField.textColor = PX_COLOR_HEX(@"333333");
    nameTextField.font = Font(15);
    nameTextField.sd_cornerRadius = @(5);
    nameTextField.placeholder = @"请输入联系人姓名";
    
    UITextField *mobileTextField = [[UITextField alloc] init];
    [backView addSubview:mobileTextField];
    mobileTextField.sd_layout
        .leftEqualToView(nameTextField)
        .rightEqualToView(nameTextField)
        .topSpaceToView(nameTextField, 15)
        .heightIs(40);
    mobileTextField.keyboardType = UIKeyboardTypeNumberPad;
    mobileTextField.backgroundColor = PX_COLOR_HEX(@"efefef");
    mobileTextField.placeholder = @"请输入联系人电话";
    mobileTextField.textColor = PX_COLOR_HEX(@"333333");
    mobileTextField.sd_cornerRadius = @(5);
    mobileTextField.font = Font(15);
    
    UIButton *confirmButton = [[UIButton alloc] init];
    [backView addSubview:confirmButton];
    confirmButton.sd_layout
        .leftEqualToView(mobileTextField)
        .rightEqualToView(mobileTextField)
        .topSpaceToView(mobileTextField, 15)
        .heightIs(40);
    confirmButton.sd_cornerRadius = @(5);
    confirmButton.backgroundColor = PX_COLOR_HEX(@"57e038");
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:PX_COLOR_HEX(@"ffffff") forState:UIControlStateNormal];
    
    [confirmButton addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        //点击执行
        if (nameTextField.text.length < 2) {
            //名字长度不对
        }else if (![mobileTextField.text px_checkPhoneNum]){
            //号码不对
        }else{
            //添加完成
            action?action(CitySendContacterInsertConfirm,nameTextField.text,mobileTextField.text):nil;
            [self hideView:backView backView:cancelButton];
        };
    }];
    
    [backView setupAutoHeightWithBottomView:confirmButton bottomMargin:15];
    
    [self showAnimation:backView backView:cancelButton];
}

+ (void)showAnimation:(UIView *)view backView:(UIButton *)backView{
//    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
//    animation.toValue = [NSValue valueWithCGPoint:CGRectGetCenter([UIApplication sharedApplication].keyWindow.bounds)];
//    animation.removedOnCompletion = NO;
//    animation.duration = .3;
//    animation.fillMode = kCAFillModeForwards;
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    [view.layer addAnimation:animation forKey:@"PostionAni"];
    [UIView animateWithDuration:.5f animations:^{
        view.alpha = 1;
    }];
}

+ (void)hideView:(UIView *)view backView:(UIButton *)backView{
    [UIView animateWithDuration:.5f animations:^{
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [backView removeAllSubviews];
        [backView removeFromSuperview];
    }];
}

@end
