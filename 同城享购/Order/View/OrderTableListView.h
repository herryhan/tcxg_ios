//
//  OrderTableListView.h
//  同城享购
//
//  Created by qipx on 2018/2/27.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderItemView.h"

@interface OrderTableListView : UIView

//** dataSource */
@property (nonatomic,strong) NSArray < GoodsProducts  *> *  model;

@end
