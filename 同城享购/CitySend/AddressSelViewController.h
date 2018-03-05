//
//  AddressSelViewController.h
//  同城享购
//
//  Created by Charles on 2018/2/25.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "baseViewController.h"

@interface AddressSelViewController : baseViewController

@property (nonatomic,copy) void(^SelAddress) (CLLocation *location,NSString *name,NSString *subName);

@end
