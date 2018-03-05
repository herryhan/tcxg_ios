//
//  UIButton+QPX_Extend.h
//  QPXExtend
//
//  Created by DemonArrow on 2016/11/26.
//  Copyright © 2016年 DemonArrow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (QPX_Extend)

typedef enum{
    UIButtonTopImageTitle = 0,//上图下字
    UIButtonLeftImageTitle,//左图右字
    UIButtonBottomImageTitle,//下图上字
    UIButtonRightImageTitle,//右图左字
}UIButtonImageTitleType;

-(void)qpx_verticalImageAndTitle:(CGFloat)spacing;

-(void)qpx_buttonImageAndTitle:(UIButtonImageTitleType)imageTitleType spacing:(CGFloat)spacing;

-(void)qpx_buttonSetBackgroundColor:(UIColor *)color forState:(UIControlState)UIControlState;

+(UIButton *)qpx_creatButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backGroundColor:(UIColor *)backGroundColor tag:(NSInteger)tag target:(id)target action:(SEL)action;

@end
