//
//  goodsTableViewCell.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/14.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsInfoModel.h"

typedef void(^btnPulsBlock)(NSInteger count, BOOL animated);

@interface goodsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;

@property (nonatomic,strong) goodsInfoModel *model;

@property (nonatomic, copy)   btnPulsBlock block;       // block

@property (nonatomic, assign) NSInteger numCount;       // 计数器



@end
