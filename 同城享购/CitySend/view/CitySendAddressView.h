//
//  CitySendAddressView.h
//  同城享购
//
//  Created by Charles on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CitySendAddressView;
@protocol CitySendAddressViewDelegate
@required
- (void)citySendAddressView:(CitySendAddressView *)addressView didSelectedAtNameLabel:(UILabel *)nameLabel clickAtView:(UIView *)view;
@end

@interface CitySendAddressView : UIView

@property (nonatomic,strong) UIImageView *tagImageView;
@property (nonatomic,strong) UIView *topLineView;
@property (nonatomic,strong) UIView *botLineView;
@property (nonatomic,strong) UILabel *nameLabel;
//@property (nonatomic,strong) UILabel *subNameLabel;
@property (nonatomic,strong) UIButton *addBookBtn;
@property (nonatomic,strong) UIButton *adButton;
@property (nonatomic,assign) BOOL topLineShow;
@property (nonatomic,assign) BOOL botLineShow;

@property (nonatomic,weak) id <CitySendAddressViewDelegate> delegate;

@end
