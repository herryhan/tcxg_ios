//
//  cartView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/22.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "cartView.h"
#import "cartTableViewCell.h"

@implementation cartView


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self layoutUI];
    }
    return self;
}

-(void)layoutUI
{
   // self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds];
    self.tableView.bounces = NO;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
   // self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerNib:[UINib nibWithNibName:@"GoodslistCell" bundle:nil] forCellReuseIdentifier:@"GoodslistCell"];
    
}


#pragma mark - TableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.objects count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    cartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cartTableViewCell" forIndexPath:indexPath];
//    OrderModel *model = [[OrderModel alloc]initWithDictionary:[self.objects objectAtIndex:indexPath.row]];
//
//    [cell ListModel:model];
//    cell.operationBlock=^(NSInteger number,BOOL plus){
//
//        NSMutableDictionary * dic = self.objects[indexPath.row];
//        //更新选中订单列表中的数量
//        [dic setValue:[NSNumber numberWithInteger:number] forKey:@"orderCount"];
//
//        NSMutableDictionary *notification = [[NSMutableDictionary alloc]init];
//        [notification setValue:[NSNumber numberWithBool:plus] forKey:@"isAdd"];
//        [notification setValue:dic forKey:@"update"];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"updateUI" object:self userInfo:notification];
//    };
    return cell;
    
}

@end
