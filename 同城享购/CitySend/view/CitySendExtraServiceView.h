//
//  CitySendExtraServiceView.h
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CitySendExtraServiceCellView : UIView

@property (nonatomic,weak) UILabel *mLabel;
@property (nonatomic,weak) UIImageView *mImageView;
@property (nonatomic,weak) UIButton *mButton;
@end

@interface CitySendExtraServiceView : UIView
@property (nonatomic,copy) void (^ExtraServiceCallBack)(NSArray <NSNumber *> *array);
- (instancetype)initWithFrame:(CGRect)frame dataSource:(NSArray <NSString *>*)dataSource;

@end
