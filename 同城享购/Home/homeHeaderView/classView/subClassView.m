//
//  subClassView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "subClassView.h"
#import "subClassCollectionViewCell.h"
#import "subClassModel.h"
@implementation subClassView


- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"classView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                if ([obj isKindOfClass:[subClassView class]]) {
                    self = obj;
                    self.frame = frame;
                  //  _subClassArrayData = [[NSMutableArray alloc]init];
                    [self uiconfig];
                   
                }
            }
        }
    }
    return self;
}
- (void)setSubClassArrayData:(NSMutableArray *)subClassArrayData{
    _subClassArrayData = subClassArrayData;
    NSLog(@"ffff%@",_subClassArrayData);
    [self.subClassCollectionView reloadData];
}
- (void)uiconfig{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(88, 88);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 2;
    [self.subClassCollectionView setCollectionViewLayout:layout];
    self.subClassCollectionView.backgroundColor = [UIColor whiteColor];
    self.subClassCollectionView.delegate = self;
    self.subClassCollectionView.dataSource = self;
    self.subClassCollectionView.scrollsToTop = NO;
    self.subClassCollectionView.showsVerticalScrollIndicator = NO;
    self.subClassCollectionView.showsHorizontalScrollIndicator = NO;
   
    [self.subClassCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass([subClassCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"subClass"];
    
    self.selectedIndex = 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.subClassArrayData.count;
}


- ( UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    subClassCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"subClass" forIndexPath:indexPath];
    subClassModel *model = self.subClassArrayData[indexPath.item];
    [cell configWithModel:model];
    return cell;
    
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   // subClassCollectionViewCell *cell =  (subClassCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    NSLog(@"%@",indexPath);
    subClassModel * model = self.subClassArrayData[indexPath.item];
    if (model.isSelected) {
        model.isSelected = NO;
    }else{
        model.isSelected = YES;
    }
    subClassModel *pastModel = self.subClassArrayData[self.selectedIndex];
    pastModel.isSelected = NO;
    [self.subClassArrayData replaceObjectAtIndex:self.selectedIndex withObject:pastModel];
    self.selectedIndex = indexPath.item;
    [self.subClassCollectionView reloadData];
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"index:%@",indexPath);
}

@end
