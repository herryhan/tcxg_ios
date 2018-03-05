//
//  cartTableViewCell.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/22.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface cartTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsStyleLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UIButton *subBtn;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
