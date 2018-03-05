//
//  GoodsCommentTextView.h
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PXStarRateView.h"

@class GoodsCommentTextView;
@protocol GoodsCommentTextViewDelegate
@required
- (void)commentTextView:(GoodsCommentTextView *)view starRate:(CGFloat)starRate commentText:(NSString *)text;
@end

@interface GoodsCommentTextView : UIView

//** nameLabel */
@property (nonatomic,weak) UILabel *mNameLabel;
//** starRateView */
@property (nonatomic,weak) PXStarRateView *mStarRateView;
//** textView */
@property (nonatomic,weak) UITextView *mTextView;

@property (nonatomic,weak) id <GoodsCommentTextViewDelegate> delegate;

@end
