//
//  goodsAttrsView.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/20.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "goodsAttrsView.h"

@implementation goodsAttrsView

-(instancetype)initWithFrame:(CGRect)frame withModel:(goodsInfoModel *)model{
    
    if ([super initWithFrame:frame]) {
        [self initArray];
        [self uiconfig:model];
        _goodsInfoModel = model;
    }
    return self;
}
- (void)initArray{
    
    self.attrsSelectedIDArray = [[NSMutableArray alloc]init];
}

- (void)uiconfig:(goodsInfoModel *)model{
    
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    self.backgroundColor = [UIColor whiteColor];
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10,self.frame.size.width, 20)];
    titleLabel.text = model.name;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:titleLabel];
    
    //底部
    UIButton *cartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    cartBtn.frame = CGRectMake(self.frame.size.width-100, self.frame.size.height-40, 100, 40);
    
    [cartBtn setTitle:@"加入购物车" forState:UIControlStateNormal];
    [cartBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cartBtn setBackgroundColor:UIColorFromRGBA(60,172,105, 1)];
    cartBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [cartBtn addTarget:self action:@selector(addcartPress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cartBtn];
    
    UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,  self.frame.size.height-40, self.frame.size.width-100, 40)];
    priceLabel.text = [NSString stringWithFormat:@"    ¥%@",model.price];
    priceLabel.font = [UIFont systemFontOfSize:15];
    priceLabel.textColor = [UIColor redColor];
    priceLabel.backgroundColor = UIColorFromRGBA(239, 239, 239, 1);
    
    [self addSubview:priceLabel];
    
    //content
    UIScrollView *scroller = [[UIScrollView alloc]initWithFrame:CGRectMake(0,30,self.frame.size.width, self.frame.size.height-70)];
    //scroller.backgroundColor = [UIColor redColor];
    
    CGFloat viewToatalHeight = 10;
    for (int i = 0; i<model.attrs.count; i++) {
       
        UIView *bgView = [UIView new];
        bgView.tag = 100+i;
        
        UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 20)];
        nameLabel.text = model.attrs[i][@"name"];
        nameLabel.font = [UIFont systemFontOfSize:14];
        [bgView addSubview:nameLabel];
        NSMutableArray *valsArray = model.attrs[i][@"vals"];
    
        
        CGFloat tagsTotalWidth = 0.0f;
        CGFloat tagsTotalHeight = 50.0;
        
        //UIView *view = [UIView alloc]initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)
        
        for (int j = 0; j<valsArray.count; j++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = bgView.tag * 10 +j;
            if (j == 0) {
                btn.selected = YES;
                NSString *idString = [NSString stringWithFormat:@"%@:%@",model.attrs[i][@"id"],valsArray[j][@"id"]];
                NSLog(@"%@",idString);
                [self.attrsSelectedIDArray addObject:idString];
            }
            [btn setTitle:valsArray[j][@"name"] forState:UIControlStateNormal];
            //btn.backgroundColor = [UIColor redColor];
            btn.titleLabel.font = [UIFont systemFontOfSize:13];
            CGRect rect = [self rectSizeWithString:valsArray[j][@"name"] andFont:[UIFont systemFontOfSize:13]];
            [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
            [btn setTitleColor:UIColorFromRGBA(60, 172, 105, 1) forState:UIControlStateSelected];
            btn.layer.borderWidth = 0.5;
            btn.layer.borderColor = UIColorFromRGBA(239, 239, 239, 1).CGColor;
            [btn addTarget:self action:@selector(sender:) forControlEvents:UIControlEventTouchUpInside];
            
            float stringWidth = rect.size.width;
            if (stringWidth<=50) {
                stringWidth = 50;
            }
            if (stringWidth>=self.frame.size.width-20 - tagsTotalWidth) {
                tagsTotalWidth = 0;
                btn.frame = CGRectMake(tagsTotalWidth, tagsTotalHeight+5,stringWidth+2, 30);
                tagsTotalHeight = tagsTotalHeight + 30+5;
                tagsTotalWidth += tagsTotalWidth + stringWidth+12;
                NSLog(@"sect");
            }else{
               
                btn.frame = CGRectMake(tagsTotalWidth, tagsTotalHeight-30 ,stringWidth+2, 30);
                tagsTotalWidth += stringWidth+2+10;
                NSLog(@"row");
                
            }
           // bgView.backgroundColor = [UIColor blueColor];
            
            [bgView addSubview:btn];
        }
       
        bgView.frame = CGRectMake(10,viewToatalHeight, self.frame.size.width-20, tagsTotalHeight);
        viewToatalHeight += tagsTotalHeight+10;
        [scroller addSubview:bgView];
        [self addSubview:scroller];
    }
}

- (void)addcartPress{
    
    NSString *allSelectedIdString = @"";
    for (int i = 0; i<self.attrsSelectedIDArray.count; i++) {
        
        if (i!=self.attrsSelectedIDArray.count -1) {
            allSelectedIdString = [NSString stringWithFormat:@"%@%@",allSelectedIdString,self.attrsSelectedIDArray[i]];
            allSelectedIdString = [NSString stringWithFormat:@"%@,",allSelectedIdString];
        }else{
            allSelectedIdString = [NSString stringWithFormat:@"%@%@",allSelectedIdString,self.attrsSelectedIDArray[i]];
        }
    }
    
      _addCart(allSelectedIdString);
    
}
- (void)sender:(UIButton *)sender{
    
    sender.layer.borderColor = UIColorFromRGBA(60, 172, 105, 1).CGColor;
    sender.selected = YES;

    NSUInteger attrsID = sender.tag/10-100;
    NSInteger valsID = sender.tag%1000%10;
    
    NSLog(@"%ld  %ld",attrsID,valsID);
   // NSLog(@"%@",_goodsInfoModel.attrs[attrsID][@"vals"][valsID][@"id"]);
    
    NSString *attrsIDString =[NSString stringWithFormat:@"%@",_goodsInfoModel.attrs[attrsID][@"id"]];
    NSString *valsIDString = [NSString stringWithFormat:@"%@",_goodsInfoModel.attrs[attrsID][@"vals"][valsID][@"id"]];
    
    NSString *idString = [NSString stringWithFormat:@"%@:%@",attrsIDString,valsIDString];
    for (int i = 0; i<self.attrsSelectedIDArray.count; i++) {
        if ([self.attrsSelectedIDArray[i] rangeOfString:attrsIDString].location !=NSNotFound) {
            [self.attrsSelectedIDArray replaceObjectAtIndex:i withObject:idString];
        }
    }
   
    UIView *bgview = [self viewWithTag:sender.tag/10];
    for (UIView* view in [bgview subviews]) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if (btn.tag != sender.tag) {
                
                [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
                btn.layer.borderColor = UIColorFromRGBA(239, 239, 239, 1).CGColor;
                btn.selected = NO;
                
            }
        }
        
    }
    NSLog(@"hhh");
}
-(CGRect)rectSizeWithString:(NSString *)string andFont:(UIFont *)font{
    
    return [string  boundingRectWithSize:CGSizeMake(100, 100) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    
}
@end
