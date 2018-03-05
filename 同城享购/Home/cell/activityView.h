//
//  activityView.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SDAutoLayout.h"

@interface activityView : UIView
- (instancetype)initWithMaxItemsCount:(NSInteger)count;

@property (nonatomic, strong) NSArray *activityArray;
@property (nonatomic, assign) NSInteger maxItemsCount;

@end
