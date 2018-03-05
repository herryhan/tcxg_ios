//
//  CitySendBannerView.m
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CitySendBannerView.h"

@interface CitySendBannerView()
//** titleLabel */
@property (nonatomic,strong) UILabel * mTitleLabel;
//** imageView */
@property (nonatomic,strong) UIImageView * mImageView;
//** loadWeight */
@property (nonatomic,strong) UILabel * mLoadWeightLabel;
//** volume */
@property (nonatomic,strong) UILabel * mVolumeLabel;
//** threeHigh */
@property (nonatomic,strong) UILabel * mThreeHighLabel;
//** backView */
@property (nonatomic,strong) UIView * backView;
@end

@implementation CitySendBannerView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = PX_COLOR_HEX(@"ffffff");
        [self setupView];
    }
    return self;
}

- (void)setupView{
    self.mTitleLabel = ({
        UILabel *view = [[UILabel alloc] init];
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(self, 0)
            .rightSpaceToView(self, 0)
            .topSpaceToView(self, 34)
            .heightIs(30);
        view.font = Font(18);
        view.textColor = PX_COLOR_HEX(@"57e038");
        view.textAlignment = NSTextAlignmentCenter;
        view;
    });
    
    UIView *lineView = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(self, 0)
            .rightSpaceToView(self, 0)
            .topSpaceToView(self.mTitleLabel, 0)
            .heightIs(.8f);
        view.backgroundColor = PX_COLOR_HEX(@"dfdfdf");
        view;
    });
    
    self.backView = ({
        UIView *view = [[UIView alloc] init];
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(self, 0)
            .rightSpaceToView(self, 0)
            .bottomSpaceToView(self, 0)
            .heightIs(60);
        view.backgroundColor = PX_COLOR_HEX(@"ffffff");
        view;
    });
    
    self.mImageView = ({
        UIImageView *view = [[UIImageView alloc] init];
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(self, 50)
            .rightSpaceToView(self, 50)
            .topSpaceToView(lineView, 0)
            .bottomSpaceToView(self.backView, 0);
        view.image = [UIImage imageWithColor:PX_RANDOM_COLOR];
        view;
    });
    
    self.mLoadWeightLabel = ({
        UILabel *view = [[UILabel alloc] init];
        [self.backView addSubview:view];
        view.sd_layout.heightIs(60);
        view.isAttributedContent = YES;
        view.numberOfLines = 0;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.textAlignment = NSTextAlignmentCenter;
        view;
    });
    
    self.mVolumeLabel = ({
        UILabel *view = [[UILabel alloc] init];
        [self.backView addSubview:view];
        view.sd_layout.heightIs(60);
        view.isAttributedContent = YES;
        view.numberOfLines = 0;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.textAlignment = NSTextAlignmentCenter;
        view;
    });
}

- (void)setMTitle:(NSString *)mTitle{
    self.mTitleLabel.text = mTitle;
}

- (void)setMImageName:(NSString *)mImageName{
    self.mImageView.image = PX_IMAGE_NAMED(mImageName);
}

- (void)setMLoadWeight:(NSString *)mLoadWeight{
    self.mLoadWeightLabel.attributedText = [self getAttributeString:mLoadWeight];
}

- (void)setMVolume:(NSString *)mVolume{
    self.mVolumeLabel.attributedText = [self getAttributeString:mVolume];
}

- (void)setMThreeHigh:(NSString *)mThreeHigh{
    self.mThreeHighLabel.attributedText = [self getAttributeString:mThreeHigh];
}

- (void)setMHaveThreeHigh:(BOOL)mHaveThreeHigh{
    if (mHaveThreeHigh) {
        NSArray *array = [NSArray arrayWithObjects:self.mLoadWeightLabel,self.mThreeHighLabel,self.mVolumeLabel, nil];
        [self.backView setupAutoWidthFlowItems:[array copy] withPerRowItemsCount:3 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    }else{
        NSArray *array = [NSArray arrayWithObjects:self.mLoadWeightLabel,self.mVolumeLabel, nil];
        [self.backView setupAutoWidthFlowItems:[array copy] withPerRowItemsCount:2 verticalMargin:0 horizontalMargin:0 verticalEdgeInset:0 horizontalEdgeInset:0];
    }
}

- (NSMutableAttributedString *)getAttributeString:(NSString *)string{
    NSMutableAttributedString *syString = [[NSMutableAttributedString alloc] initWithString:string];
    NSArray *array = [string componentsSeparatedByString:@"\n"];
    [syString addAttributes:[NSDictionary dictionaryWithObjects:@[PX_COLOR_HEX(@"333333"),Font(15)] forKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]] range:[string rangeOfString:[array firstObject]]];
    [syString addAttributes:[NSDictionary dictionaryWithObjects:@[PX_COLOR_HEX(@"666666"),Font(12)] forKeys:@[NSForegroundColorAttributeName,NSFontAttributeName]] range:[string rangeOfString:[array lastObject]]];
    return syString;
}

- (UILabel *)mThreeHighLabel{
    return PX_LAZY(_mThreeHighLabel, ({
        UILabel *view = [[UILabel alloc] init];
        [self.backView addSubview:view];
        view.sd_layout.heightIs(60);
        view.isAttributedContent = YES;
        view.numberOfLines = 0;
        view.lineBreakMode = NSLineBreakByTruncatingTail;
        view.textAlignment = NSTextAlignmentCenter;
        view;
    }));
}

@end
