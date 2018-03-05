//
//  subClassCollectionViewCell.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subClassModel.h"

@interface subClassCollectionViewCell : UICollectionViewCell <CALayerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *classImageView;
@property (weak, nonatomic) IBOutlet UILabel *classNameLabel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@property (weak, nonatomic) IBOutlet UIView *imageBgView;

- (void)configWithModel:(subClassModel *)model;

@end

