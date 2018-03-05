//
//  trggierView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/1/12.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface trggierView : UIView
{
    CGPoint _startPoint;
    CGPoint _middlePoint;
    CGPoint _endPoint;
    UIColor  *_color;
}
- (instancetype)initStartPoint:(CGPoint)startPoint
                   middlePoint:(CGPoint)middlePoint
                      endPoint:(CGPoint)endPoint
                         color:(UIColor*)color;
@end
