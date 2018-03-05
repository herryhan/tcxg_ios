//
//  showActivityTableViewCell.h
//  同城享购
//
//  Created by 韩先炜 on 2018/1/13.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "showActivityModel.h"

@interface showActivityTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *activityTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *activityContent;

- (void)modelConfigWithModel:(showActivityModel *)model;

@end
