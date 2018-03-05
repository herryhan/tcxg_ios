//
//  CateCollectionCell.h
//  同城享购
//
//  Created by Charles on 2018/2/25.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecCateModel.h"
#import "CateModel.h"

@interface CateCollectionCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *mImageView;
@property (strong, nonatomic) UILabel *mNameLabel;
@property (nonatomic,strong) SecCateSecModel *model;
@end
