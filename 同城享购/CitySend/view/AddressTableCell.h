//
//  AddressTableCell.h
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableCell : UITableViewCell

@property (nonatomic,weak) UILabel *nameLabel;
@property (nonatomic,weak) UILabel *subNameLabel;
@property (nonatomic,strong) AMapPOI *poi;
@property (nonatomic,strong) CLLocation *location;

@end
