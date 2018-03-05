//
//  shopViewController.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/13.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "baseViewController.h"
#import "homeModel.h"
#import "shopHeaderView.h"
#import "hxwSegmentView.h"
@interface shopViewController : baseViewController

@property (nonatomic,strong) NSString *shopId;

@property (nonatomic,strong) homeModel *shopModel;

@property float lat;
@property float lon;

@property (nonatomic,strong) hxwSegmentView *hxwSegView;

@end
