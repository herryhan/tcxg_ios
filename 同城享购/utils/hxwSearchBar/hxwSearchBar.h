//
//  hxwSearchBar.h
//  同城享购
//
//  Created by 庄园 on 2017/11/8.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@class hxwSearchBar;

@protocol hxwSearchBarDelegate <NSObject>

@optional

- (BOOL)searchBarShouldBeginEditing:(hxwSearchBar *)searchBar;

- (void)searchBarTextDidBeginEditing:(hxwSearchBar *)searchBar;

- (BOOL)searchBarShouldEndEditing:(hxwSearchBar *)searchBar;

- (void)searchBarTextDidEndEditing:(hxwSearchBar *)searchBar;

- (void)searchBar:(hxwSearchBar *)searchBar textDidChange:(NSString *)searchText;

- (void)searchBarSearchButtonClicked:(hxwSearchBar *)searchBar;//确定按钮

- (void)searchBarCancelButtonClicked:(hxwSearchBar *)searchBar;

@end

@interface hxwSearchBar : UIView

//文本的颜色
@property (nonatomic,strong)UIColor * textColor;
//字体
@property (nonatomic,strong)UIFont * searBarFont;
//内容
@property (nonatomic,strong)NSString * text;
//背景颜色
@property (nonatomic,strong)UIColor * searBarColor;
//默认文本
@property (nonatomic,copy)NSString * placeholder;
//默认文本的颜色
@property (nonatomic,strong)UIColor * placeholdesColor;
//默认文本字体大小
@property (nonatomic,strong)UIFont * placeholdesFont;
//是否弹出键盘
@property (nonatomic,assign)BOOL isbecomeFirstResponder;
//设置右边按钮的样式
@property (nonatomic,strong)UIImage * deleteImage;
//设置代理
@property (nonatomic,weak)id<hxwSearchBarDelegate>delegate;

@end
