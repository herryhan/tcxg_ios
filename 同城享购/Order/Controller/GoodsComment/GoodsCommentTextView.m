//
//  GoodsCommentTextView.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "GoodsCommentTextView.h"

@interface GoodsCommentTextView()<PXStarRateViewDelegate,UITextViewDelegate>
//** starRate */
@property (nonatomic,assign) CGFloat starRate;
//** commentText */
@property (nonatomic,copy) NSString * commentText;
@end

@implementation GoodsCommentTextView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.backgroundColor = PX_COLOR_HEX(@"ffffff");
    self.starRate = 0;
    self.commentText = nil;
    
    UILabel *nameLabel = [UILabel new];
    PXStarRateView *starView = [[PXStarRateView alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    starView.isAnimation = YES;
    starView.rateStyle = WholeStar;
    starView.delegate = self;
    UITextView *textView = [UITextView new];
    [self sd_addSubviews:@[nameLabel,starView,textView]];
    
    self.mNameLabel = nameLabel;
    self.mStarRateView = starView;
    self.mTextView = textView;
    
    CGFloat padding = 15.0f;
    CGFloat margin = 10.0f;
    
    self.mNameLabel.sd_layout
        .leftSpaceToView(self, padding)
        .topSpaceToView(self, padding)
        .autoHeightRatio(0);
    self.mNameLabel.font = Font(16);
    self.mNameLabel.textColor = PX_COLOR_HEX(@"333333");
    [self.mNameLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    self.mStarRateView.sd_layout
        .rightSpaceToView(self, padding)
        .centerYEqualToView(self.mNameLabel)
        .heightIs(30)
        .widthIs(200);
    
    self.mTextView.sd_layout
        .leftSpaceToView(self, padding)
        .rightSpaceToView(self, padding)
        .topSpaceToView(self.mNameLabel, padding)
        .heightIs(10*margin);
    self.mTextView.layer.masksToBounds = YES;
    self.mTextView.layer.borderColor = PX_COLOR_HEX(@"999999").CGColor;
    self.mTextView.layer.borderWidth = .5f;
    self.mTextView.font = Font(15);
    self.mTextView.delegate = self;
    
    [self setupAutoHeightWithBottomView:self.mTextView bottomMargin:padding];
}

- (void)textViewDidChange:(UITextView *)textView{
    _commentText = textView.text;
    if (_delegate) {
        [_delegate commentTextView:self starRate:_starRate commentText:textView.text];
    }
}

- (void)starRateView:(PXStarRateView *)starRateView currentScore:(CGFloat)currentScore{
    _starRate = currentScore;
    if (_delegate) {
        [_delegate commentTextView:self starRate:currentScore commentText:_commentText];
    }
}

@end
