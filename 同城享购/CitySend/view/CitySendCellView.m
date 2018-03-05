//
//  CitySendCellView.m
//  同城享购
//
//  Created by Charles on 2018/2/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CitySendCellView.h"

@implementation CitySendCellView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self px_setpView];
    }
    return self;
}

- (void)px_setpView{
    
    __weak typeof(self) weakSelf = self;
    [self.contentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        //点击事件
        __weak typeof(self) strongSelf = weakSelf;
        [strongSelf.delegate citySendCellView:strongSelf didClickContentLabel:strongSelf.contentLabel];
    }]];
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = ({
            UILabel *view = [[UILabel alloc] init];
            [self addSubview:view];
            view.sd_layout
                .leftSpaceToView(self, 15)
                .topSpaceToView(self, 0)
                .bottomSpaceToView(self, 0)
                .widthIs(80);
            view.textColor = PX_COLOR_HEX(@"333333");
            view.font = [UIFont systemFontOfSize:15.0f];
            view;
        });
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel =({
            UILabel *view = [[UILabel alloc] init];
            [self addSubview:view];
            view.sd_layout
                .rightSpaceToView(self.mImageView, 0)
                .topSpaceToView(self, 0)
                .bottomSpaceToView(self, 0)
                .leftSpaceToView(self.nameLabel, 20);
            view.font = [UIFont systemFontOfSize:13.0f];
            view.textColor = PX_COLOR_HEX(@"666666");
            view.textAlignment = NSTextAlignmentRight;
            view.userInteractionEnabled = YES;
            view.isAttributedContent = YES;
            view;
        });
    }
    return _contentLabel;
}

- (UITextView *)mTextView{
    return PX_LAZY(_mTextView, ({
        UITextView *view = [[UITextView alloc] init];
        [self addSubview:view];
        [self.contentLabel removeFromSuperview];
        view.sd_layout
            .rightSpaceToView(self.mImageView, 0)
            .topSpaceToView(self, 10)
            .bottomSpaceToView(self, 10)
            .leftSpaceToView(self.nameLabel, 20);
        view.font = Font(13);
        view.textAlignment = NSTextAlignmentRight;
        view;
    }));
}

- (UIImageView *)mImageView{
    if (!_mImageView) {
        _mImageView = ({
            UIImageView *view = [[UIImageView alloc] init];
            [self addSubview:view];
            view.sd_layout
                .rightSpaceToView(self, 10)
                .topSpaceToView(self, 0)
                .bottomSpaceToView(self, 0)
                .widthIs(25);
            view.contentMode = UIViewContentModeRight;
            view.image = [UIImage imageNamed:@"icon_poi_notice_arrow"];
            view;
        });
    }
    return _mImageView;
}

@end
