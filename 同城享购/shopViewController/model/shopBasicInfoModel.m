//
//  shopBasicInfoModel.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/15.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "shopBasicInfoModel.h"
#import "homeModel.h"

@implementation shopBasicInfoModel

-(void)fetchBasicInfo:(NSNumber *)shop_id andUuid:(NSString *)uuid{

    
     homeModel *model = [[homeModel alloc]init];
    
      NSMutableArray *arr = [[NSMutableArray alloc]init];
    
    [URLRequest getWithURL:[NSString stringWithFormat:@"http://ha.tongchengxianggou.com/api/cart/list?id=%@&uuid=%@",shop_id,uuid] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {

        NSDictionary *dic= [NSDictionary dictionaryWithDictionary:[cityShoppingTool jsonConvertToDic:responseObject]];
        NSLog(@"eee :%@",dic);
        
       
//        model.actives = dic[@"actives"];
//        model.carts = dic[@"carts"];
//        model.count = dic[@"count"];
//        model.isStop = dic[@"isStop"];
//        model.minMoney = dic[@"minMoney"];
//        model.money = dic[@"money"];
//        model.releaseMoney = dic[@"releaseMoney"];
//        model.weight = dic[@"weight"];
//        
//      
        [arr addObject:model];
        NSLog(@"%ld",arr.count);
        self.returnBlock(arr);
      
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"errrrr:%@",error);
    }];

   
}

@end
