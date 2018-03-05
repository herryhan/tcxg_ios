//
//  CitySendContacterView.h
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,CitySendContacterInsert) {
    CitySendContacterInsertConfirm,
    CitySendContacterInsertCancel
};

@interface CitySendContacterView : UIView

+ (void)showCitySendContacterView:(void(^)(CitySendContacterInsert type,NSString *name,NSString *mobile))action;

@end
