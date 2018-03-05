//
//  searchView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/10.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchView : UIView
@property (weak, nonatomic) IBOutlet UITextField *contentText;
@property(nonatomic, assign) CGSize intrinsicContentSize;

@end
