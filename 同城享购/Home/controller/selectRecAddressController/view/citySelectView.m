//
//  citySelectView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/1.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "citySelectView.h"

@implementation citySelectView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"citySelectView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;

    
                [self.addressSearchBar setBackgroundColor:[UIColor whiteColor]];
                [ self.addressSearchBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
 
                self.addressSearchBar.tintColor = UIColorFromRGBA(220, 220, 220, 1);
                UITextField *searchField=[((UIView *)[ self.addressSearchBar.subviews objectAtIndex:0]).subviews lastObject];
                NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"请输入收货地址"];
                [placeholder addAttribute:NSForegroundColorAttributeName
                                    value:UIColorFromRGBA(104, 104, 104, 1)
                                    range:NSMakeRange(0,  placeholder.length)];
                searchField.attributedPlaceholder = placeholder;
                searchField.font = [UIFont systemFontOfSize:14];
                searchField.backgroundColor = UIColorFromRGBA(237, 237, 237, 1);
                searchField.tintColor = UIColorFromRGBA(68, 195, 34, 1);
                searchField.layer.cornerRadius = 1;
                searchField.layer.masksToBounds = YES;
            }
        }
    }
    
    return self;
}

- (void)cancelBtnClick{
    NSLog(@"ffff");
}
@end
