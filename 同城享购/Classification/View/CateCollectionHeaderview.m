//
//  CateCollectionHeaderview.m
//  同城享购
//
//  Created by Charles on 2018/2/25.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CateCollectionHeaderview.h"

@implementation CateCollectionHeaderview

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self px_setupView];
    }
    return self;
}

- (void)px_setupView{
    
    UILabel *label = ({
        UILabel *view = [[UILabel alloc] init];
        [self addSubview:view];
        view.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 15, 0, 15));
        view.font = Font(13);
        view.textColor = PX_COLOR_HEX(@"666666");
        view;
    });
    self.mNameLabel = label;
    
}

- (void)setName:(NSString *)name{
    self.mNameLabel.text = name;
}


@end
