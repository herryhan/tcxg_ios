//
//  MyAddressCell.h
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyAddressModel.h"

typedef NS_ENUM(NSUInteger,MyAddressCellButtonType) {
    MyAddressCellButtonTyp_Edite = 0,
    MyAddressCellButtonType_Del
};

@class MyAddressCell;
@protocol MyAddressCellDelegate
@optional
- (void)addressCell:(MyAddressCell *)cell buttonClickType:(MyAddressCellButtonType)actionType;
@end

@interface MyAddressCell : UITableViewCell

//** model */
@property (nonatomic,strong) MyAddressModel * model;
@property (nonatomic,weak) id <MyAddressCellDelegate> delegate;

@end
