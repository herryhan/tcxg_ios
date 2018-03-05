//
//  ViewModel.h
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/19.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ViewModel : NSObject

#pragma  mark - 计算价格
+(float)GetTotalPrice:(NSMutableArray *)dataArray;

#pragma mark - 计算订单数据
+(NSMutableArray *)storeOrders:(NSMutableDictionary *)dictionary OrderData:(NSMutableArray *)orderArray isAdded:(BOOL)added;

#pragma  mark - 计算数量
+(NSInteger) CountOthersWithorderData:(NSMutableArray *)ordersArray;

#pragma mark - 更新显示数据
+(NSMutableArray *)UpdateArray:(NSMutableArray *)dataArray atSelectDictionary:(NSMutableDictionary *)dictionary;

@end
