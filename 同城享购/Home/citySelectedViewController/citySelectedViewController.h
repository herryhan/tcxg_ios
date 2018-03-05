//
//  citySelectedViewController.h
//  同城享购
//
//  Created by 韩先炜 on 2018/1/30.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface citySelectedViewController : UIViewController

@property (nonatomic,copy)void (^succeed)(NSString *cityName);

@end
