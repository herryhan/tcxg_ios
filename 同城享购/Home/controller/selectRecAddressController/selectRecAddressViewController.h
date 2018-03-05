//
//  selectRecAddressViewController.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "baseViewController.h"

@interface selectRecAddressViewController : baseViewController

@property (nonatomic,strong) NSMutableArray *addressArray;

@property  float lat;
@property  float lon;

@property(nonatomic,strong) void(^CallBackSelectedLocation)(NSString *locateName,float selectLan,float selectLon);

@end
