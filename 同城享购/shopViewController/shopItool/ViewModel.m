//
//  ViewModel.m
//  MeiTuanWaiMai
//
//  Created by maxin on 16/1/19.
//  Copyright © 2016年 maxin. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel


#pragma  mark - 计算价格
+(float)GetTotalPrice:(NSMutableArray *)dataArray{

    double nTotal = 0;
    for (NSDictionary *dic in dataArray) {
        
        if ([dic objectForKey:@"count"] !=nil) {
            
            nTotal += [[dic objectForKey:@"count"] floatValue] * [[dic objectForKey:@"price"] floatValue];
        }
    }
    return nTotal;
}

#pragma mark - 计算订单数据
+(NSMutableArray *)storeOrders:(NSMutableDictionary *)dictionary OrderData:(NSMutableArray *)orderArray isAdded:(BOOL)added{

    
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dictionary];
    //增加订单和减少订单
    if (added) {
        
        if (orderArray.count!=0) {
            
            BOOL flage = YES;
            for (NSMutableDictionary *dic in orderArray) {
                if (dic[@"id"] == dict[@"id"]){
                    
                    NSNumber  *count = dict[@"count"];
                    [dic setValue:count forKey:@"count"];
                    flage = NO;
                    break;
                }
            }
            if(flage){
                [orderArray addObject:dict];
            }
            
        }else{
            
            [orderArray addObject:dict];
        }
 
    }else{
        
        for (int i=0; i<orderArray.count;i++) {
            
            NSMutableDictionary *dic = orderArray[i];
            
            if (dic[@"id"] == dict[@"id"]){
                
                if ([dict[@"count"] integerValue]==0) {
                    [orderArray removeObjectAtIndex:i];
                    break;
                }
                
                if ([dic[@"count"] integerValue] == 0){
                    [orderArray removeObjectAtIndex:i];
                }else{
                    [dic setValue:dict[@"count"] forKey:@"count"];
                    [orderArray replaceObjectAtIndex:i withObject:dic];
                }
                break;
            }
        }
    }
    return orderArray;
    
}

#pragma  mark - 计算数量
+(NSInteger) CountOthersWithorderData:(NSMutableArray *)ordersArray{
    
    NSInteger count = 0;
    for (int i = 0; i< ordersArray.count; i++)
    {
        NSMutableDictionary *dic = ordersArray[i];
        count += [dic[@"count"] integerValue];
    }
    
    return count;
    
}


#pragma mark - 更新显示数据
+(NSMutableArray *)UpdateArray:(NSMutableArray *)dataArray atSelectDictionary:(NSMutableDictionary *)dictionary{

    
    for (NSMutableDictionary *dic in dataArray) {
        if (dic[@"id"] == dictionary[@"id"]){
            
            NSInteger count = [dictionary[@"count"] integerValue];
            [dic setValue:[NSString stringWithFormat:@"%ld",(long)count] forKey:@"orderCount"];
            break;
        }
    }
    return dataArray;
}


@end
