//
//  CitySendDatePickView.h
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySendDatePickView : UIView

@property (nonatomic,copy) void(^SelDateTime) (NSString *dateString,NSString *timeString);

@end

