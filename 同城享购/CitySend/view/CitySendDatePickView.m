//
//  CitySendDatePickView.m
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "CitySendDatePickView.h"
#import "NSDate+QPX_Extend.h"

@interface CitySendDatePickView()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,weak) UIPickerView *mPickView;
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) NSArray *allSource;
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,copy) NSString *selDateString;
@property (nonatomic,copy) NSString *selTimeString;
@end

@implementation CitySendDatePickView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        //
        [self px_setupView];
    }
    return self;
}

- (void)px_setupView{
    self.backgroundColor = [UIColor colorWithHexString:@"333333" alpha:.4f];
    self.userInteractionEnabled = YES;
    [[[UIApplication sharedApplication] keyWindow]addSubview:self];
    
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, PX_SCREEN_HEIGHT, PX_SCREEN_WIDTH, 290)];
    back.backgroundColor = PX_COLOR_HEX(@"ffffff");
    [self addSubview:back];
    self.backView = back;
    
    UIPickerView *view = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, PX_SCREEN_WIDTH, 250)];
    [self.backView addSubview:view];
    view.backgroundColor = PX_COLOR_HEX(@"ffffff");
    view.delegate = self;
    view.dataSource = self;
    self.mPickView = view;
    
    [self preperData];
    
    [self showAnimation];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
        //点击背景取消选择时间
        [self hideView];
    }]];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(PX_SCREEN_WIDTH - 90, 0, 80, 40)];
    [self.backView addSubview:button];
    button.backgroundColor = PX_RANDOM_COLOR;
    __weak typeof(self) weakSelf = self;
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id  _Nonnull sender) {
        //确定选择时间
        __strong typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.SelDateTime?strongSelf.SelDateTime(strongSelf.selDateString,strongSelf.selTimeString):nil;
        [self hideView];
    }];
}

- (void)hideView{
    [UIView animateWithDuration:.5f animations:^{
        self.backView.top = PX_SCREEN_HEIGHT;
    }completion:^(BOOL finished) {
        [self removeAllSubviews];
        [self removeFromSuperview];
    }];
}

- (void)preperData{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddhhmmss"];
    NSDate *currentDate = [NSDate qpx_localDate];
    NSString *currentDateString = [formatter stringFromDate:currentDate];
    NSDate *tomorrowDate = [NSDate qpx_dateAfterDate:currentDate day:1];
    NSString *tormorrowDateString = [formatter stringFromDate:tomorrowDate];
    //获取明天星期几
    NSString *torWeek = [tomorrowDate qpx_dayFromWeekday];
    //获取今天星期几
    NSString *todayWeek = [currentDate qpx_dayFromWeekday];
    
    NSMutableArray *torArray = [NSMutableArray new];
    for (NSUInteger hh = 9; hh < 24; hh ++ ) {
        for (NSInteger mm = 0; mm <= 40; mm += 20) {
            NSString *string = [NSString stringWithFormat:@"%02ld:%02ld",hh,mm];
            [torArray addObject:string];
        }
    }
    NSMutableArray *todayArray = [NSMutableArray new];
    NSInteger h = [[currentDateString substringWithRange:NSMakeRange(8, 2)] integerValue];
    NSInteger m = [[currentDateString substringWithRange:NSMakeRange(10, 2)] integerValue];
    if (m<=20) {
        [todayArray addObject:[NSString stringWithFormat:@"%02ld:20",h]];
        [todayArray addObject:[NSString stringWithFormat:@"%02ld:40",h]];
    }
    else if (m <= 40) [todayArray addObject:[NSString stringWithFormat:@"%02ld:40",h]];
    for (NSInteger hh = h+1; hh < 24; hh ++ ) {
        for (NSUInteger mm = 0; mm <= 40; mm += 20) {
            NSString *string = [NSString stringWithFormat:@"%02ld:%02ld",hh,mm];
            [todayArray addObject:string];
        }
    }
    if (h==23 && m > 40) [todayArray addObject:@"请选择明天的时间"];
    NSDictionary *today = [NSDictionary dictionaryWithObjects:@[todayWeek,currentDateString,todayArray] forKeys:@[@"week",@"date",@"list"]];
    NSDictionary *tor = [NSDictionary dictionaryWithObjects:@[torWeek,tormorrowDateString,torArray] forKeys:@[@"week",@"date",@"list"]];
    self.allSource = [NSArray arrayWithObjects:today,tor, nil];
    self.dataSource = [NSArray arrayWithArray:todayArray];
    [self.mPickView reloadAllComponents];
    
}

- (void)showAnimation{
    [UIView animateWithDuration:.5f animations:^{
        self.backView.top = PX_SCREEN_HEIGHT - 290;
    }];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return component == 0 ? 2 : self.dataSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        if (row == 0) {
            NSDictionary *dict = [self.allSource objectAtIndex:0];
            NSString *dateString = [dict objectForKey:@"date"];
            //yyyyMMddhhmmss
            dateString = [NSString stringWithFormat:@"%@月%@日",[dateString substringWithRange:NSMakeRange(4, 2)],[dateString substringWithRange:NSMakeRange(6, 2)]];
            NSString *today = [NSString stringWithFormat:@"今天(%@)",dateString];
            self.selDateString = today;
            return today;
        }else{
            NSDictionary *dict = [self.allSource objectAtIndex:1];
            NSString *dateString = [dict objectForKey:@"date"];
            //yyyyMMddhhmmss
            dateString = [NSString stringWithFormat:@"%@月%@日",[dateString substringWithRange:NSMakeRange(4, 2)],[dateString substringWithRange:NSMakeRange(6, 2)]];
            NSString *tor = [NSString stringWithFormat:@"明天(%@)",dateString];
            return tor;
        }
    }else{
        self.selTimeString = [self.dataSource firstObject];
        return [NSString stringWithFormat:@"%@前",[self.dataSource objectAtIndex:row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0){
        if(row == 0){
            //使用今天的数组
            self.dataSource = [[self.allSource objectAtIndex:0] objectForKey:@"list"];
        }else{
            //使用明天的数组
            self.dataSource = [[self.allSource objectAtIndex:1] objectForKey:@"list"];
        }
        [self.mPickView reloadComponent:1];
        self.selDateString = [self pickerView:self.mPickView titleForRow:row forComponent:component];
        NSInteger row1 = [pickerView selectedRowInComponent:1];
        self.selTimeString = [self.dataSource objectAtIndex:row1];
        PXDALog(@"===%@",self.selDateString);
    }else{
        //返回一个时间
        self.selTimeString = [self.dataSource objectAtIndex:row];
        PXDALog(@"===%@===",self.selTimeString);
    }
}

@end
