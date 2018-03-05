//
//  activityView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/10.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "activityView.h"
#import "activityLabelView.h"
#import "activityModel.h"

@implementation activityView
{
    NSMutableArray *_imageViewsArray;
}
- (instancetype)initWithMaxItemsCount:(NSInteger)count
{
    if (self = [super init]) {
        self.maxItemsCount = count;
    }
    return self;
}

-(void)setActivityArray:(NSArray *)activityArray{
    
    _activityArray = activityArray;
    if (!_imageViewsArray) {
        _imageViewsArray = [NSMutableArray new];
    }
    int needsToAddItemsCount = (int)(_activityArray.count - _imageViewsArray.count);
    
    if (needsToAddItemsCount > 0) {
        for (int i = 0; i < needsToAddItemsCount; i++) {
            activityLabelView *actLabel = [activityLabelView new];
            [self addSubview:actLabel];
            [_imageViewsArray addObject:actLabel];
        }
    }
    
    NSMutableArray *temp = [NSMutableArray new];
    
    [_imageViewsArray enumerateObjectsUsingBlock:^(activityLabelView *actLabel, NSUInteger idx, BOOL *stop) {
        if (idx < _activityArray.count) {
            actLabel.hidden = NO;
            actLabel.sd_layout.autoHeightRatio(1);
            actLabel.activityNameLabel.text = activityArray[idx][@"type"];
            actLabel.activityContentLabel.text = activityArray[idx][@"name"];
            [temp addObject:actLabel];
        } else {
            [actLabel sd_clearAutoLayoutSettings];
            actLabel.hidden = YES;
        }
    }];
    
    [self setupAutoWidthFlowItems:[temp copy] withPerRowItemsCount:1 verticalMargin:0 horizontalMargin:5 verticalEdgeInset:0 horizontalEdgeInset:0];
}
@end
