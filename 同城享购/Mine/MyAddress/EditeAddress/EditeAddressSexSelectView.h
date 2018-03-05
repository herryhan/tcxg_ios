//
//  EditeAddressSexSelectView.h
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,EditeAddressSex) {
    EditeAddressSex_Man = 0,
    EditeAddressSex_Woman
};

@interface EditeAddressSexSelectView : UIView

@property (nonatomic,copy) void(^EditeAddressSexSelectBlock)(EditeAddressSex sex);

@end
