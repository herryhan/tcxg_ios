//
//  recommendView.m
//  同城享购
//
//  Created by 庄园 on 2017/11/9.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "recommendView.h"
#import "customBtn.h"

@implementation recommendView

-(instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self requestData];
    }
    return self;
    
}
- (void)requestData{
    declareWeakSelf;
    
    self.recommendArray = [[NSMutableArray alloc]init];
    
    [URLRequest getWithURL:@"http://ha.tongchengxianggou.com/api/brand/list?locate=1&max=6" params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [weakSelf.recommendArray addObjectsFromArray:[cityShoppingTool jsonConvertToArray:responseObject]];
        [weakSelf configUi:weakSelf.recommendArray];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}
- (void)configUi:(NSArray *)recArray{
    for (int i =0; i<recArray.count; i++) {
        customBtn *btn;
        if (i<3) {
            btn = [[customBtn alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*i, 10, SCREEN_WIDTH/3, 100)];
        }else{
            
           // btn = [customBtn alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3*i, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        }
   
    }
   //
}
@end
