//
//  hxwTagView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/11.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface hxwTagView : UIView

/**
 *  初始化
 *
 *  @param frame    frame
 *  @param tagArray 标签数组
 *

 */
- (instancetype)initWithFrame:(CGRect)frame tagArray:(NSMutableArray*)tagArray;

// 标签数组
@property (nonatomic,retain) NSArray* tagArray;

//// 选中标签文字颜色
//@property (nonatomic,retain) UIColor* textColorSelected;
//// 默认标签文字颜色
//@property (nonatomic,retain) UIColor* textColorNormal;
//
//// 选中标签背景颜色
//@property (nonatomic,retain) UIColor* backgroundColorSelected;
//// 默认标签背景颜色
//@property (nonatomic,retain) UIColor* backgroundColorNormal;

@property int row;

@property (nonatomic,strong) void(^rowCount)(int row);


@end
