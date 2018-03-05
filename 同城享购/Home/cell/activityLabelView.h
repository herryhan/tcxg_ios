//
//  activityLabelView.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "activityModel.h"

@interface activityLabelView : UIView
@property (weak, nonatomic) IBOutlet UILabel *activityNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *activityContentLabel;

- (void)setValueWithDic:(NSDictionary *) dic;

@end
