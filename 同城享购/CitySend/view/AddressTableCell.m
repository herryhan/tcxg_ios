//
//  AddressTableCell.m
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "AddressTableCell.h"

@implementation AddressTableCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self px_setupView];
    }
    return self;
}

- (void)px_setupView{
    UILabel *nameLabel = ({
        UILabel *view = [[UILabel alloc] init];
        [self addSubview:view];
        view.sd_layout
            .leftSpaceToView(self, 15)
            .rightSpaceToView(self, 15)
            .topSpaceToView(self, 10)
            .heightIs(20);
        view.font = Font(15);
        view.textColor = PX_COLOR_HEX(@"333333");
        view;
    });
    self.nameLabel = nameLabel;
    
    UILabel *subNameLabel = ({
        UILabel *view = [[UILabel alloc] init];
        [self addSubview:view];
        view.sd_layout
            .leftEqualToView(self.nameLabel)
            .rightEqualToView(self.nameLabel)
            .topSpaceToView(self.nameLabel, 5)
            .bottomSpaceToView(self, 10);
        view.font = Font(13);
        view.textColor = PX_COLOR_HEX(@"666666");
        view;
    });
    self.subNameLabel = subNameLabel;
}

- (void)setPoi:(AMapPOI *)poi{
    self.location = [[CLLocation alloc] initWithLatitude:poi.location.latitude longitude:poi.location.longitude];
    self.nameLabel.text = poi.name;
    self.subNameLabel.text = [NSString stringWithFormat:@"%@%@%@",poi.city,poi.district,poi.address];
}

@end
