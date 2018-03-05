//
//  goodsAttrsView.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/20.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsInfoModel.h"

@interface goodsAttrsView : UIView

-(instancetype)initWithFrame:(CGRect)frame withModel:(goodsInfoModel *)model;

@property NSInteger selectedIndex;
@property (nonatomic,strong)goodsInfoModel *goodsInfoModel;
@property (nonatomic,strong)NSMutableArray *attrsSelectedIDArray;

@property (nonatomic,strong) void(^addCart)(NSString * goodsID);

@end
