//
//  homeHeaderView.m
//  同城享购
//
//  Created by 庄园 on 2017/11/9.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "homeHeaderView.h"
#import "brandView.h"


static NSString *ID = @"homeCollectionViewCell";

////////////////////////////////////////////////////////////////////////
@interface CollectionCellWhite : homeClassicfyCollectionViewCell



@end

@implementation CollectionCellWhite

//- (brandView *)recBrandView{
//    if (!_recBrandView) {
//        _recBrandView = [[brandView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
//        [self addSubview:_recBrandView];
//    }
//    return _recBrandView;
//
//}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
////////////////////////////////////////////////////////////////////////


@implementation homeHeaderView 

- (instancetype)initWithFrame:(CGRect)frame{
    
    if ([super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self congfigBanner]; // 设置banner
        [self rquestData]; // 请求banner数据
        [self loadData];// 请求分类数据
    }
    return self;
}

- (void)congfigBanner{
    //banner
    self.sdView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, 120) delegate:self placeholderImage:nil];
    self.sdView.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    self.sdView.layer.cornerRadius = 10;
    self.sdView.layer.masksToBounds = YES;
    [self addSubview:self.sdView];
    
    //首页分类
    homeClassicViewLayout *layout =[[homeClassicViewLayout alloc]init];
    layout.itemSize = CGSizeMake(SCREEN_WIDTH/5, SCREEN_WIDTH/5);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.rowCount = 2;
    layout.itemCountPerRow = 5;
    
    //layout.headerReferenceSize = CGSizeMake(0*SCREEN_SCALE, 0*SCREEN_SCALE);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
     self.classCollectionView =[[UICollectionView alloc]initWithFrame:CGRectMake(0,240+20, SCREEN_WIDTH,SCREEN_WIDTH/5*2+10) collectionViewLayout:layout];
    self.classCollectionView.tag = 10001;
    
    self.classCollectionView.backgroundColor = [UIColor whiteColor];
    self.classCollectionView.dataSource = self;
    self.classCollectionView.delegate = self;
    self.classCollectionView.pagingEnabled = YES;
    self.classCollectionView.showsHorizontalScrollIndicator = NO;
    [self.classCollectionView registerClass:[CollectionCellWhite class]
       forCellWithReuseIdentifier:@"white"];
    
    [self.classCollectionView registerClass:[homeClassicfyCollectionViewCell class]
       forCellWithReuseIdentifier:ID];
    [self addSubview:self.classCollectionView];
    
    //分类pageControl
    UIView *pageBgview = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.classCollectionView.frame), SCREEN_WIDTH, 20)];
    pageBgview.backgroundColor = [UIColor whiteColor];
    [self addSubview:pageBgview];
    self.classPageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
     //self.classPageControl.numberOfPages = 3;//指定页面个数
     self.classPageControl.currentPage = 0;//指定pagecontroll的值，默认选中的小白点（第一个）
    //添加委托方法，当点击小白点就执行此方法
    
     self.classPageControl.pageIndicatorTintColor = UIColorFromRGBA(212, 242, 203, 1);// 设置非选中页的圆点颜色
    
     self.classPageControl.currentPageIndicatorTintColor = UIColorFromRGBA(27, 197, 59, 1); // 设置选中页的圆点颜色
    
    [pageBgview addSubview:self.classPageControl];
   
    //品牌section
    UILabel *brandLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(pageBgview.frame)+20, SCREEN_WIDTH-20, 30)];
    brandLabel.text = @"优惠专区";
    [brandLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    [self addSubview:brandLabel];
    
    //品牌商家展示
    self.recBrandView = [[brandView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(brandLabel.frame)+10, SCREEN_WIDTH, 200)];
    [self addSubview:self.recBrandView];
    //附近商家view
    self.nearShopView = [[nearShopView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.recBrandView.frame)+20, SCREEN_WIDTH, 80)];
    self.nearShopView.userInteractionEnabled = YES;
    [self addSubview:self.nearShopView];
}

- (void)rquestData{
    
    declareWeakSelf;
    self.sdDataArray = [[NSMutableArray alloc]init];
    //banner的请求
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"locate"] = @(1);
    parmas[@"max"] = @(10);
    [URLRequest postWithURL:@"banner/list" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [weakSelf.sdDataArray addObjectsFromArray:[cityShoppingTool jsonConvertToArray:responseObject]];
        NSMutableArray *imageArr = [[NSMutableArray alloc]init];
        
        for (int i = 0; i<weakSelf.sdDataArray.count; i++) {
            [imageArr addObject:weakSelf.sdDataArray[i][@"pic"]];
        }
        self.sdView.imageURLStringsGroup = imageArr;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (void)loadData
{
    self.classfyArray = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"locate"] = @(1);
    parmas[@"max"] = @(99);
    [URLRequest postWithURL:@"type/list" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        [self.classfyArray addObjectsFromArray:[cityShoppingTool jsonConvertToArray:responseObject]];
        _pageCount = self.classfyArray.count;
        NSLog(@"ddddd%@",[cityShoppingTool jsonConvertToArray:responseObject]);
        while (_pageCount % 10 != 0) {
            ++_pageCount;
        }
        self.classPageControl.numberOfPages = _pageCount/10;
        
        [self.classCollectionView reloadData];
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _pageCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    homeClassicfyCollectionViewCell *cell = nil;
    if (indexPath.item>=self.classfyArray.count) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"white"
                                                            forIndexPath:indexPath];
    }else{
            
        cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
        cell.imageName = self.classfyArray[indexPath.item][@"logo"];
        cell.title = self.classfyArray[indexPath.item][@"name"];
    }
    return cell;
   
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
 
    NSLog(@"%@",self.classfyArray[indexPath.item][@"name"]);
    _selectedClassfy(self.classfyArray[indexPath.item][@"id"],self.classfyArray[indexPath.item][@"name"]);
 
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
   
        // 确定当前页数及组数
    NSInteger currentPage = self.classCollectionView.contentOffset.x / SCREEN_WIDTH;
        //NSInteger currentPageIndex = currentPage % self.cycles.count;
    self.classPageControl.currentPage = currentPage;

}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    

}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    if (_banner) {
        _banner(index);
    }
}

- (void)dealloc{

    [self removeObserver:self forKeyPath:@"frame" context:nil];
}
@end
