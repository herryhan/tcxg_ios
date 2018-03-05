//
//  homeHeaderView.h
//  同城享购
//
//  Created by 庄园 on 2017/11/9.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDCycleScrollView.h"
#import "homeClassicViewLayout.h"
#import "homeClassicfyCollectionViewCell.h"
#import "nearShopView.h"
#import "brandView.h"

@interface homeHeaderView : UIView <SDCycleScrollViewDelegate,UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) SDCycleScrollView *sdView;
@property (nonatomic, strong) NSMutableArray *sdDataArray;
@property (nonatomic, strong) void(^banner)(NSInteger index);

@property (nonatomic, strong) UICollectionView *classCollectionView;
@property (nonatomic, strong) NSMutableArray *classfyArray;
@property (nonatomic, assign) NSUInteger pageCount;
@property (nonatomic, strong) UIPageControl *classPageControl;

@property (nonatomic, strong) nearShopView *nearShopView;

@property (nonatomic,strong)brandView *recBrandView;

@property (nonatomic,strong)void(^selectedClassfy)(NSNumber *classfyId,NSString *classfyName);

@end
