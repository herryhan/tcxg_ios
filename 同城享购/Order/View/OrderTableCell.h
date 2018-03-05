//
//  OrderTableCell.h
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTableListView.h"

typedef NS_ENUM(NSUInteger , OrderTableCellButtonAction) {
    OrderTableCellButtonAction_Comment = 0,
    OrderTableCellButtonAction_Delete
};

@class OrderTableCell;
@protocol OrderTableCellDelegate
@optional
- (void)orderTableCell:(OrderTableCell *)cell clickButtonType:(OrderTableCellButtonAction)buttonType;
@end

@interface OrderTableCell : UITableViewCell

//** model */
@property (nonatomic,strong) GoodsOrderModel * model;
@property (nonatomic,weak) id <OrderTableCellDelegate> delegate;

@end
