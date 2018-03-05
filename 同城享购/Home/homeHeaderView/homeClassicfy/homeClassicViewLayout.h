//
//  homeClassicViewLayout.h
//  同城享购
//
//  Created by 庄园 on 2017/11/9.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeClassicViewLayout : UICollectionViewFlowLayout

@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;
@property (strong, nonatomic) NSMutableArray *allAttributes;


@end
