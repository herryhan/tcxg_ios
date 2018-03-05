//
//  MyAddressVC.h
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "baseViewController.h"
#import "MyAddressModel.h"

@interface MyAddressVC : baseViewController

@property (nonatomic,copy) void(^SelMyAddressBlock)(MyAddressModel *model);

@end
