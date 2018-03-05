//
//  subClassView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface subClassView : UIView <UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *subClassCollectionView;
@property (nonatomic,strong) NSMutableArray *subClassArrayData;
@property (nonatomic,assign) int selectedIndex;

@end
