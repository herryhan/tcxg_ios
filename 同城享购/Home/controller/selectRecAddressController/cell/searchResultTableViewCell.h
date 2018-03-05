//
//  searchResultTableViewCell.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/2.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface searchResultTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *adressDetaillLabel;
- (void)uiconfigWith:(AMapPOI *)poi;

@end
