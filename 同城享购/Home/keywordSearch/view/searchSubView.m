//
//  searchSubView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/2/11.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "searchSubView.h"

@implementation searchSubView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"searchAllView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                if ([obj isKindOfClass:[searchSubView class]]) {
                    self = obj;
                    self.frame = frame;
                    [self.hotTagView setRowCount:^(int row) {
                        self.hotSearchConstraint.constant = row*44+50;
                    }];
                    [self.historyTagView setRowCount:^(int row) {
                        
                        self.historySearchConstraint.constant = row*44+50;
                        
                    }];
                    
                    [self uiconfig];
                }
            }
        }
    }
    
    return self;
}
- (void)uiconfig{
    self.backgroundColor = UIColorFromRGBA(247, 247, 247, 1);
    self.hotLabel.textColor = UIColorFromRGBA(104, 104, 104, 1);
    self.historyLabel.textColor = UIColorFromRGBA(104, 104, 104, 1);
}

- (IBAction)clearBtnPress:(UIButton *)sender {
    
    _clearHistorySearch();
    
}

@end
