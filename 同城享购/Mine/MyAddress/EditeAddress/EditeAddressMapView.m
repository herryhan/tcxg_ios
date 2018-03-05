//
//  EditeAddressMapView.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "EditeAddressMapView.h"

@interface EditeAddressMapView()
{
    UIImageView *_mLeftImageView;
    UIImageView *_mRightImageView;
}
@end

@implementation EditeAddressMapView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UILabel *view = [UILabel new];
    _mLeftImageView = [UIImageView new];
    _mRightImageView = [UIImageView new];
    [self sd_addSubviews:@[_mLeftImageView,view,_mRightImageView]];
    
    self.mMapLabel = view;
    _mLeftImageView.sd_layout
        .leftSpaceToView(self, 0)
        .topSpaceToView(self, 10)
        .bottomSpaceToView(self, 10)
        .widthEqualToHeight();
    _mLeftImageView.image = PX_IMAGE_NAMED(@"address");
    
    _mRightImageView.sd_layout
        .rightSpaceToView(self,0)
        .topEqualToView(_mLeftImageView)
        .bottomEqualToView(_mLeftImageView)
        .widthEqualToHeight();
    _mRightImageView.image = PX_IMAGE_NAMED(@"icon_poi_notice_arrow");
    
    self.mMapLabel.sd_layout
        .leftSpaceToView(_mLeftImageView, 10)
        .topEqualToView(_mLeftImageView)
        .bottomEqualToView(_mLeftImageView)
        .rightSpaceToView(_mRightImageView, 10);
    self.mMapLabel.font = Font(15);
}

@end
