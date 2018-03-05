//
//  searchView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/10.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "searchView.h"

@implementation searchView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"searchAllView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                if ([obj isKindOfClass:[searchView class]]) {
                    self = obj;
                    self.frame = frame;
                    self.contentText.clearButtonMode = UITextFieldViewModeWhileEditing;
                    self.backgroundColor = UIColorFromRGBA(231, 231, 231, 1);
                    self.layer.cornerRadius = 3;
                    self.layer.masksToBounds = YES;
                    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"同城享购合作店"];
                    [placeholder addAttribute:NSForegroundColorAttributeName
                                        value:UIColorFromRGBA(104, 104, 104, 1)
                                        range:NSMakeRange(0,  placeholder.length)];
                    placeholder.font = [UIFont systemFontOfSize:14];
                    
                    self.contentText.attributedPlaceholder = placeholder;
                    
                }
            }
        }
    }
    
    return self;
}


@end

