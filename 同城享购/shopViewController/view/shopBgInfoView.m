//
//  shopBgInfoView.m
//  同城享购
//
//  Created by 韩先炜 on 2018/3/3.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "shopBgInfoView.h"
#import "activityLabelView.h"

@implementation shopBgInfoView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
     
        [self configView];
        
    }
    return self;
}

- (void)configView{
    self.backgroundColor = [UIColor whiteColor];
    self.bulrImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,SCREEN_WIDTH, SafeAreaTopHeight+80)];
    [self addSubview:self.bulrImageView];
    self.iconImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, SafeAreaTopHeight+10, 80, 80)];
    self.iconImageView.layer.cornerRadius = 3;
    self.iconImageView.layer.masksToBounds = YES;
    [self addSubview:self.iconImageView];
    self.shopNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight+10+10, SCREEN_WIDTH-100, 20)];
    [self.shopNameLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20]];
    self.shopNameLabel.textColor = [UIColor whiteColor];
   
    [self addSubview:self.shopNameLabel];
    
    self.noticLabel = [[UILabel alloc]initWithFrame:CGRectMake(100, SafeAreaTopHeight+10+10+30, SCREEN_WIDTH-100, 20)];
    self.noticLabel.font = [UIFont systemFontOfSize:12];
    self.noticLabel.textColor = [UIColor whiteColor];
    
    //self.noticLabel.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.noticLabel];
    
    //scroller
    self.infoScroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0, SafeAreaTopHeight+80, SCREEN_WIDTH, SCREEN_HEIGHT-(SafeAreaTopHeight+80))];
    
    //self.infoScroller.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.infoScroller];
    
    self.shopNameLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, SCREEN_WIDTH, 30)];
    self.shopNameLabelTwo.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    self.shopNameLabelTwo.textAlignment = NSTextAlignmentCenter;
    self.shopNameLabelTwo.alpha = 0;
    
    [self.infoScroller addSubview:self.shopNameLabelTwo];
    
    self.actView = [[UIView alloc]init];
    [self.infoScroller addSubview:self.actView];
    self.sendInfoView = [[UIView alloc]init];
    [self.infoScroller addSubview:self.sendInfoView];
    self.noticeView = [[UIView alloc]init];
    [self.infoScroller addSubview:self.noticeView];
    
    //upBtn
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, SCREEN_HEIGHT - 45, SCREEN_WIDTH, 45);
    [btn setImage:[UIImage imageNamed:@"btn_restaurant_bgview_arrow_up"] forState:UIControlStateNormal];
    [self addSubview:btn];
    
    [self bringSubviewToFront:self.iconImageView];
}

- (void)viewConfigWithModel:(homeModel *)model{
    CGFloat contentHeight = 30+30;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    [self.bulrImageView sd_setImageWithURL:[NSURL URLWithString:model.logo]];
    // 生成特定样式的模糊效果
    UIBlurEffect * blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView * effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    [effectView setFrame:self.bulrImageView.frame];
    [self.bulrImageView  addSubview:effectView];
    self.shopNameLabel.text = model.name;
    self.shopNameLabelTwo.text = model.name;
    self.noticLabel.text = [NSString stringWithFormat:@"公告：本店地址%@",model.address];
    //活动
    if (model.actives.count !=0) {
        for (int i = 0; i<model.actives.count; i++) {
            activityLabelView *actView = [[activityLabelView alloc]initWithFrame:CGRectMake(10, (5+20)*i, SCREEN_WIDTH -40, 20)];
            [actView setValueWithDic:model.actives[i]];
            [self.actView addSubview:actView];
        }
        self.actView.frame = CGRectMake(0, CGRectGetMaxY(self.shopNameLabelTwo.frame)+20, SCREEN_WIDTH, 25*model.actives.count);
    }
    contentHeight += 20+25*model.actives.count;
    
    //配送
    UILabel *sendTopicLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH, 20)];
    sendTopicLabel.text = @"配送";
    sendTopicLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self.sendInfoView addSubview:sendTopicLabel];
    UILabel *sendFeeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(sendTopicLabel.frame)+10 , SCREEN_WIDTH-20, 20)];
    sendFeeLabel.text = [NSString stringWithFormat:@"起送 ¥%@ | 配送 ¥%@ | %@分钟",model.minMoney,model.fee,model.avgTime];
    sendFeeLabel.font = [UIFont systemFontOfSize:12];
    sendFeeLabel.textColor = UIColorFromRGBA(140, 140, 140, 1);
    [self.sendInfoView addSubview:sendFeeLabel];
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(sendFeeLabel.frame)+3, SCREEN_WIDTH-20, 20)];
    timeLabel.text = [NSString stringWithFormat:@"配送时间：09:00 - 21:00"];
    timeLabel.textColor = UIColorFromRGBA(140, 140, 140, 1);
    timeLabel.font = [UIFont systemFontOfSize:12];
    [self.sendInfoView addSubview:timeLabel];
    self.sendInfoView.frame = CGRectMake(0, CGRectGetMaxY(self.actView.frame)+20, SCREEN_WIDTH, 73);
    contentHeight += 20+73;
    
    //公告
    UILabel *noticTopicLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, 20)];
    noticTopicLabel.text = @"公告";
    noticTopicLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
    [self.noticeView addSubview:noticTopicLabel];
    
    UILabel *noticContentLabel = [[UILabel alloc]init];
    noticContentLabel.font = [UIFont systemFontOfSize:12];
    
    CGSize textSize2 = [model.address boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 10000)
                                                  options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:noticContentLabel.font}
                                                  context:nil].size;
    noticContentLabel.text = model.address;
    noticContentLabel.frame = CGRectMake(10, CGRectGetMaxY(noticTopicLabel.frame)+5, textSize2.width, textSize2.height);
    noticContentLabel.textColor = UIColorFromRGBA(140, 140, 140, 1);
    [self.noticeView addSubview:noticContentLabel];
    self.noticeView.frame = CGRectMake(0, CGRectGetMaxY(self.sendInfoView.frame)+20, SCREEN_WIDTH, 35+textSize2.height);
    contentHeight += 20+35+textSize2.height;
    self.infoScroller.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight+600);
    
    [self.infoScroller setContentOffset:CGPointMake(0, 60)];
    
   // return
}


@end
