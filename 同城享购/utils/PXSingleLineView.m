//
//  PXSingleLineView.m
//  同城享购
//
//  Created by qipx on 2018/3/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "PXSingleLineView.h"

@interface PXSingleLineView()
//** imageName */
@property (nonatomic,copy) NSString * mImageName;
@end

@implementation PXSingleLineView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
    }
    return self;
}

- (void)setupView{
    UIImage *image = PX_IMAGE_NAMED(@"cellLineView");
    UIEdgeInsets edge=UIEdgeInsetsMake(.2,.2,.2,.2);
    image = [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    self.image = image;
}

- (void)setImageName:(NSString *)imageName{
    self.mImageName = [imageName copy];
}

- (void)setInsets:(UIEdgeInsets)insets{
    NSAssert(self.mImageName, @"请先传入图片名字");
    UIImage *image = PX_IMAGE_NAMED(self.mImageName);
    UIEdgeInsets edge = insets;
    image = [image resizableImageWithCapInsets:edge resizingMode:UIImageResizingModeStretch];
    self.image = image;
}

@end
