//
//  homeTopEffecialView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/31.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "homeTopEffecialView.h"

@implementation homeTopEffecialView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"effectView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                self.searchBarBgView.alpha = 0.8;
                self.searchBarBgView.layer.cornerRadius = 5;
                self.searchBarBgView.layer.masksToBounds = YES;
                self.searchBarBgView.backgroundColor = UIColorFromRGBA(254, 250, 239, 0.7);
                NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"同城享购合作店"];
                [placeholder addAttribute:NSForegroundColorAttributeName
                                    value:UIColorFromRGBA(104, 104, 104, 1)
                                    range:NSMakeRange(0,  placeholder.length)];
                self.searchText.attributedPlaceholder = placeholder;
                
                UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedLocate)];
                [self.locateNameLabel addGestureRecognizer:tapGes];
            }
        }
    }
    
    return self;
}
- (void)selectedLocate{
    
    _changeLocatePress();
    
}

- (IBAction)searchBtn:(UIButton *)sender {
    
    _keyWordSearch();
    
}

@end
