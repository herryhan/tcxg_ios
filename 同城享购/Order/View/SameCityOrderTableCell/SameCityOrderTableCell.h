//
//  SameCityOrderTableCell.h
//  同城享购
//
//  Created by qipx on 2018/2/28.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SameCityOrderModel.h"

@class SameCityOrderTableCell;
@protocol SameCityOrderTableCellDelegate
@optional
- (void)sameCityOrderTableCell:(SameCityOrderTableCell *)cell clickButton:(UIButton *)button;
@end

@interface SameCityOrderTableCell : UITableViewCell

//** model */
@property (nonatomic,strong) SameCityOrderModel * model;

@end
