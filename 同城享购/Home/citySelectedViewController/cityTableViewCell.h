//
//  cityTableViewCell.h
//  同城享购
//
//  Created by 韩先炜 on 2018/1/30.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TFTableViewDlegate <NSObject>

- (void)TableViewSelectorIndix:(NSString *)str;

@end

@interface cityTableViewCell : UITableViewCell

@property (nonatomic,strong)NSArray *cellArr;

@property (nonatomic,assign)id<TFTableViewDlegate> delegate;

@end
