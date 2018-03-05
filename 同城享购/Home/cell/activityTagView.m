//
//  activityTagView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "activityTagView.h"

@implementation activityTagView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _tagArray = [[NSMutableArray alloc]init];
       // [self uiconfig];
    }
    return self;
}

// 重写set属性
- (void)setTagArray:(NSMutableArray *)tagArray{
  
    self.rows = 1;
    _tagArray = tagArray;
    
    // 重新创建标签
    [self resetTagButton];
}

#pragma mark - Private

// 重新创建标签
- (void)resetTagButton{
    
    //    // 移除之前的标签
    for (UIButton* btn  in self.subviews) {
        [btn removeFromSuperview];
    }
    // 重新创建标签
    [self createTagButton];
}

// 创建标签按钮
- (void)createTagButton{
    
    // 按钮高度
    CGFloat btnH = 20;
    // 距离左边距
    CGFloat leftX = 0;
    // 距离上边距
    CGFloat topY =5;
    // 按钮左右间隙
    CGFloat marginX = 5;
    // 按钮上下间隙
    CGFloat marginY = 5;
    // 文字左右间隙
    CGFloat fontMargin = 3;
    
    for (int i = 0; i < _tagArray.count; i++) {
        
        UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
        btn.tag = 100+i;
        // 默认选中第一个
        //        if (i == 0) {
        //            btn.selected = YES;
        //        }
        //
        // 按钮文字
        [btn setTitle:_tagArray[i] forState:UIControlStateNormal];
        
        //------ 默认样式
        //按钮文字默认样式
        NSMutableAttributedString* btnDefaultAttr = [[NSMutableAttributedString alloc]initWithString:btn.titleLabel.text];
        // 文字大小
        [btnDefaultAttr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, btn.titleLabel.text.length)];
        // 默认颜色
        [btnDefaultAttr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGBA(50, 50, 50, 1) range:NSMakeRange(0, btn.titleLabel.text.length)];
        [btn setAttributedTitle:btnDefaultAttr forState:UIControlStateNormal];
        
    
        // 边框
        
        btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        btn.layer.borderWidth = 0.5;
        
        // 设置按钮的边距、间隙
        [self setTagButtonMargin:btn fontMargin:fontMargin];
        
        // 处理换行
        if (btn.frame.origin.x + btn.frame.size.width + marginX > self.frame.size.width) {
            // 换行
            self.rows += 1;
            topY += btnH + marginY;
            
            // 重置
            leftX = 0;
            btn.frame = CGRectMake(marginX + leftX, topY, 100, btnH);
            
            // 设置按钮的边距、间隙
            [self setTagButtonMargin:btn fontMargin:fontMargin];
        }
        
        // 重置高度
        CGRect frame = btn.frame;
        frame.size.height = btnH;
        btn.frame = frame;
        if (self.rows > 1) {
         //   btn.hidden = YES;
        }
        [self addSubview:btn];
        leftX += btn.frame.size.width + marginX;
    }

}

// 设置按钮的边距、间隙
- (void)setTagButtonMargin:(UIButton*)btn fontMargin:(CGFloat)fontMargin{
    
    // 按钮自适应
    [btn sizeToFit];
    
    // 重新计算按钮文字左右间隙
    CGRect frame = btn.frame;
    frame.size.width += fontMargin*2;
    btn.frame = frame;
    
}



@end
