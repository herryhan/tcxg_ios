//
//  shopHeaderView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/13.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "shopHeaderView.h"
#import "showActivityModel.h"
#import "showActivityTableViewCell.h"

@implementation shopHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *arrayObjectViews = [[NSBundle mainBundle] loadNibNamed:@"shopHeaderView" owner:self options:nil];
        if (arrayObjectViews.count <1) {
            return nil;
        }else{
            
            for (id obj in arrayObjectViews) {
                self = obj;
                self.frame = frame;
                [self uiconfig];
                self.backgroundColor = UIColorFromRGBA(247, 247, 247, 1);
            }
        }
    }
    
    return self;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc]init];
    }
    return _dataArray;
}
- (void)uiconfig{
    
    self.firstActivityLabel.backgroundColor = [UIColor redColor];
    self.lineView.alpha = 0.5;
    self.activityTableView.backgroundColor = [UIColor clearColor];
    self.activityTableView.delegate = self;
    self.activityTableView.dataSource = self;
    self.activityTableView.showsVerticalScrollIndicator = NO;
    self.activityTableView.showsHorizontalScrollIndicator = NO;
    self.mLock = [[NSLock alloc] init];
    [self.noticeImageView setImage:[UIImage imageNamed:@"icon_horn_notice_3"]];
    
    self.noticeImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"icon_horn_notice_1"],[UIImage imageNamed:@"icon_horn_notice_2"] ,[UIImage imageNamed:@"icon_horn_notice_3"],nil];
    self.noticeImageView.animationDuration = 0.8;
    self.noticeImageView.animationRepeatCount = 0;
    [self.noticeImageView startAnimating];
}

-(void)setModel:(homeModel *)model{
   
    _model = model;
    if (model.actives.count!=0) {
        [self.mLock lock];
        [self closeTimer];
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:[NSArray modelArrayWithClass:[showActivityModel class] json:model.actives]];
        [self.dataArray insertObject:self.dataArray[model.actives.count-1] atIndex:0];
        [self.activityTableView reloadData];
        [self.activityTableView scrollToRow:0 inSection:1 atScrollPosition:UITableViewScrollPositionNone animated:NO];
    }
  
    [self.logoImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    self.shopNameLabel.text =[NSString stringWithFormat:@"起送价:%d元 | 距离%0.2lfkm | 免费配送",[model.minMoney intValue],[model.distance floatValue]];
    [self.moreActivityBtn setTitle:[NSString stringWithFormat:@"%ld个活动>",(unsigned long)model.actives.count] forState:UIControlStateNormal];
    if (model.actives.count == 0) {
        self.activityLabel.hidden = YES;
        self.activityTableView.hidden = YES;
        self.firstActivityLabel.hidden = YES;
    }else{
        self.firstActivityLabel.hidden = YES;
    }
    self.noticeLabel.text = [NSString stringWithFormat:@"%@",model.notice];
    [self.bulrImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    // 生成特定样式的模糊效果
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [effectView setFrame:self.frame];
    [self.bulrImageView  addSubview:effectView];
    if (model.actives.count!=0){
        [self openTimer];
        [self.mLock unlock];
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
   return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellid=@"TableViewCell";
    showActivityTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:@"showActivityTableViewCell" owner:self options:nil].firstObject;
    }
    [cell modelConfigWithModel:self.dataArray[indexPath.section]];
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    return 20;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *v =[[UIView alloc] init];
    v.alpha=0;
    return v;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.5;
}


- (void)closeTimer {
    if (self.timer) {
        [self.timer invalidate];
    }
}

- (void)openTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}
- (void)onTimer{
    NSArray *indexPathArray = [self.activityTableView indexPathsForVisibleRows];
    if (indexPathArray.count == 0) return ;
    NSIndexPath *indexPath = indexPathArray[0];
    NSInteger section = indexPath.section;
    if (section+1 == self.dataArray.count) {
       
        [self.activityTableView scrollToRow:0 inSection:0 atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        
    }else{
         [self.activityTableView scrollToRow:0 inSection:section+1 atScrollPosition:UITableViewScrollPositionNone animated:YES];
    }
    
}
- (IBAction)showShopInfoPress:(UIButton *)sender {
    _showShopInfo();
}

@end
