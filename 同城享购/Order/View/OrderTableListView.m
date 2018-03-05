//
//  OrderTableListView.m
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "OrderTableListView.h"

@interface OrderTableListView()

//** array */
@property (nonatomic,strong) NSMutableArray *dataSource;
//** items */
@property (nonatomic,strong) NSMutableArray *itemsArray;
@end

@implementation OrderTableListView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    
}

- (void)setModel:(NSArray <GoodsProducts *> *)model{
    
    if (self.itemsArray.count) {
        [self.itemsArray enumerateObjectsUsingBlock:^(OrderItemView *view, NSUInteger index, BOOL * _Nonnull stop) {
            [view sd_clearAutoLayoutSettings];
            view.hidden = YES;
        }];
    }
    
    NSInteger count = model.count > self.itemsArray.count ? (model.count - self.itemsArray.count) : 0;
    
    for (NSInteger index = 0; index < count; index++) {
        OrderItemView *view = [[OrderItemView alloc] init];
        [self addSubview:view];
        [self.itemsArray addObject:view];
    }
    UIView *topView = nil;
    for (NSInteger index = 0 ; index < model.count ; index ++) {
        OrderItemView *view = [self.itemsArray objectAtIndex:index];
        view.model = [model objectAtIndex:index];
        view.sd_layout
            .leftSpaceToView(self, 0)
            .topSpaceToView(topView, 0)
            .rightSpaceToView(self, 0);
        topView = view;
        view.hidden = NO;
    }
    [self setupAutoHeightWithBottomView:topView bottomMargin:0];
    
}

- (NSMutableArray *)dataSource{
    return PX_LAZY(_dataSource, ({
        NSMutableArray *array = [NSMutableArray new];
        array;
    }));
}

- (NSMutableArray *)itemsArray{
    return PX_LAZY(_itemsArray, ({
        NSMutableArray *array = [NSMutableArray new];
        array;
    }));
}


@end
