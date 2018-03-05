//
//  searchByClassView.h
//  同城享购
//
//  Created by 韩先炜 on 2018/2/13.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface searchByClassView : UIView

@property (nonatomic,strong)void(^orderTag)(NSInteger tag);

@property (weak, nonatomic) IBOutlet UIButton *sumBtn;
@property (weak, nonatomic) IBOutlet UIButton *topSalesBtn;
@property (weak, nonatomic) IBOutlet UIButton *qualityBtn;
@property (weak, nonatomic) IBOutlet UIButton *distanceBtn;

@property NSInteger indexTag;
- (void)resetSelected;

@end
