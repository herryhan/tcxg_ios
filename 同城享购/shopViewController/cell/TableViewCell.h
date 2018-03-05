//
//  TableViewCell.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/14.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "goodsType.h"

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *typeNameLabel;

@property (nonatomic,strong)goodsType *goodsTypeModel;


@end
