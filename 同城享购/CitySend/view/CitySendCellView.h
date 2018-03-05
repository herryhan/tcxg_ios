//
//  CitySendCellView.h
//  同城享购
//
//  Created by Charles on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UITextView-WZB/UITextView+WZB.h>


@class CitySendCellView;
@protocol CitySendViewClickDelegate
@optional
- (void)citySendCellView:(CitySendCellView *)view didClickContentLabel:(UILabel *)label;
@end

@interface CitySendCellView : UIView



@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UIImageView *mImageView;
//** textView */
@property (nonatomic,strong) UITextView * mTextView;

@property (nonatomic,weak) id <CitySendViewClickDelegate> delegate;

@end
