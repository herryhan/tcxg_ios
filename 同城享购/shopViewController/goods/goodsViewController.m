//
//  goodsViewController.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/13.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "goodsViewController.h"
#import "goodsType.h"
#import "TableViewCell.h"
#import "goodsInfoModel.h"
#import "goodsTableViewCell.h"
#import "bottomView.h"
#import "ThrowLineTool.h"
#import "ViewModel.h"
#import "goodsAttrsView.h"
#import "cartView.h"
#import "cartHeadView.h"
#import "trggierView.h"

@interface goodsViewController ()<UITableViewDataSource,UITableViewDelegate,ThrowLineToolDelegate>

@property (nonatomic,strong) NSMutableArray *typeDataArray;
@property (nonatomic,strong) UITableView *typeTableView;
@property (nonatomic,strong) NSMutableArray *goodsInfoArray;
@property (nonatomic,strong) UITableView *goodsTableView;
@property (nonatomic,strong) bottomView *bottomView;
@property (nonatomic,strong) NSMutableArray *shopCartArray;
@property (nonatomic,strong) UIView *upHalfBgView;
@property (nonatomic,strong) UIView *downHalfBgView;
@property (nonatomic,strong) goodsAttrsView *attrsView;
@property (nonatomic,strong) cartView *goodsCartView;
@property (nonatomic,strong) UIView *goodsCartBgView;
@property (nonatomic,strong) UIView *attrBgView;
@property (nonatomic,strong) UITableView *cartTableView;

@property (nonatomic,strong) NSMutableArray *cartDataArray;
@property (nonatomic,strong) cartHeadView *cartHeaderView;
@property (nonatomic,strong) UIView *cartBgView;
@property (nonatomic,strong) trggierView *trgCustomView;

//存储购物车数据
@property (nonatomic,strong) NSMutableDictionary *cartDataDictionary;

@end

#define headerViewHeight 170
#define scrollerHeight 40*KWidth_ScaleW
#define bottomHeight 45
#define middleViewHeight SCREEN_HEIGHT-headerViewHeight - scrollerHeight - bottomHeight
#define maxCartTableViewHeight middleViewHeight-100

@implementation goodsViewController
@synthesize fatherVc;

-(NSMutableDictionary *)cartDataDictionary{
    if (!_cartDataDictionary) {
        _cartDataDictionary = [[NSMutableDictionary alloc]init];
    }
    return _cartDataDictionary;
}

-(trggierView *)trgCustomView{
    if (!_trgCustomView) {
        _trgCustomView = [[trggierView alloc] initStartPoint:CGPointMake(7,0) middlePoint:CGPointMake(0,6) endPoint:CGPointMake(14,6) color:UIColorFromRGBA(244, 244, 244, 1)];
        _trgCustomView.frame = CGRectMake(32, -5,14, 6);
    }
    return _trgCustomView;
}

-(UIView *)cartBgView{
    if (!_cartBgView) {
        _cartBgView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT-headerViewHeight - scrollerHeight - bottomHeight, SCREEN_WIDTH, 0)];
        [self.view addSubview:_cartBgView];
        [self drawTrigger:_cartBgView.frame];
        _cartTableView.hidden = YES;
    }
    return _cartBgView;
}

- (cartHeadView *)cartHeaderView{
    if (!_cartHeaderView) {
        _cartHeaderView = [[cartHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    }
    return _cartHeaderView;
}

- (NSMutableArray *)cartDataArray{
    if (!_cartDataArray) {
        _cartDataArray = [[NSMutableArray alloc]init];
    }
    return _cartDataArray;
}

- (UITableView *)cartTableView{
    if (!_cartTableView) {
        _cartTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,40,SCREEN_WIDTH,0) style:UITableViewStyleGrouped];
        _cartTableView.delegate = self;
        _cartTableView.dataSource = self;
        _cartTableView.tag = 1003;
        _cartTableView.backgroundColor = [UIColor whiteColor];
        _cartTableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _cartTableView;
}

- (UIView *)upHalfBgView{
    if (!_upHalfBgView) {
        _upHalfBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, headerViewHeight+scrollerHeight)];
        _upHalfBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCartView:)];
        [_upHalfBgView addGestureRecognizer:tapGes];
    }
    return _upHalfBgView;
}
- (UIView *)downHalfBgView{
    if (!_downHalfBgView) {
        _downHalfBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-headerViewHeight - scrollerHeight - bottomHeight)];
        _downHalfBgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showCartView:)];
        [_downHalfBgView addGestureRecognizer:tapGes];
    }
    return _downHalfBgView;
}



- (NSMutableArray *)shopCartArray{
    
    if (!_shopCartArray) {
        _shopCartArray = [[NSMutableArray alloc]init];
    }
    return _shopCartArray;
}

- (bottomView *)bottomView{
    declareWeakSelf;
    
    if (!_bottomView) {
        _bottomView = [[bottomView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT-headerViewHeight - scrollerHeight - bottomHeight, SCREEN_WIDTH,bottomHeight)];
        [_bottomView setShowCartView:^(BOOL isShow) {
            NSLog(@"%d",isShow);
            [weakSelf showCartView:isShow];
        }];
    }
    return _bottomView;
}

- (void)showCartView:(BOOL)isOpen{
    
    if (isOpen&&([self.shopCartDict[@"count"] intValue]!=0)) {
        [self.fatherVc.view addSubview:self.upHalfBgView];
        [self.view addSubview:self.downHalfBgView];
        [self.view bringSubviewToFront:self.cartBgView];
        self.cartBgView.hidden = NO;
        [self.view bringSubviewToFront:self.bottomView];
        self.fatherVc.hxwSegView.segmentScrollV.scrollEnabled = NO;
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect cartFrame = self.cartBgView.frame;
            cartFrame.origin.y -=  maxCartTableViewHeight+40;
            cartFrame.size.height =  maxCartTableViewHeight+40;
            self.cartBgView.frame = cartFrame;
            
            CGRect cartTableFrame = self.cartTableView.frame;
            cartTableFrame.size.height = cartFrame.size.height-40;
            self.cartTableView.frame = cartTableFrame;
            
            cartFrame.size.height = cartFrame.size.height-40;
        
            self.bottomView.cartBtnConstraint.constant = maxCartTableViewHeight+100-12;
            self.bottomView.totalPriceConstraint.constant = -60;
            
        }];
        self.bottomView.open = NO;
    }else{
        [self.upHalfBgView removeFromSuperview];
        [self.downHalfBgView removeFromSuperview];
        self.cartBgView.hidden = YES;
       // [self.view bringSubviewToFront:self.bottomView];
        self.fatherVc.hxwSegView.segmentScrollV.scrollEnabled = YES;
        [UIView animateWithDuration:0.2 animations:^{
            CGRect cartFrame = self.cartBgView.frame;
            cartFrame.origin.y += maxCartTableViewHeight+40;
            cartFrame.size.height = 0;
            self.cartBgView.frame = cartFrame;
            
            CGRect cartTableFrame = self.cartTableView.frame;
            cartFrame.size.height = 0;
            self.cartTableView.frame = cartTableFrame;
            
            self.bottomView.cartBtnConstraint.constant = 4;
            self.bottomView.totalPriceConstraint.constant = 5;
        }];
        self.bottomView.open = YES;
    }

}
- (NSMutableArray *)typeDataArray{
    
    if (!_typeDataArray) {
        _typeDataArray = [[NSMutableArray alloc]init];
    }
    return _typeDataArray;
}

- (UITableView *)typeTableView{
    
    if (!_typeTableView) {
        _typeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 100,SCREEN_HEIGHT-headerViewHeight -  40*KWidth_ScaleW - 45) style:UITableViewStyleGrouped];
        _typeTableView.delegate = self;
        _typeTableView.dataSource = self;
        _typeTableView.tag = 1001;
        _typeTableView.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
        _typeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _typeTableView;
}

- (NSMutableArray *)goodsInfoArray{
    
    if (!_goodsInfoArray) {
        _goodsInfoArray = [[NSMutableArray alloc]init];
    }
    return _goodsInfoArray;
}

- (UITableView *)goodsTableView{
    if (!_goodsTableView) {
        _goodsTableView = [[UITableView alloc]initWithFrame:CGRectMake(100, 0,SCREEN_WIDTH - 100 ,SCREEN_HEIGHT-headerViewHeight -  40*KWidth_ScaleW - 45) style:UITableViewStyleGrouped];
        _goodsTableView.delegate = self;
        _goodsTableView.dataSource = self;
        _goodsTableView.tag = 1002;
        _goodsTableView.backgroundColor = UIColorFromRGBA(244, 245, 247, 1);
        _goodsTableView.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _goodsTableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [ThrowLineTool sharedTool].delegate = self;
    
    [self.cartBgView addSubview:self.cartTableView];
    [self.cartBgView addSubview:self.cartHeaderView];
    [self.cartBgView addSubview:self.trgCustomView];
    
    //2. 创建背景视图
    self.goodsCartBgView = [[UIView alloc]init];
    self.goodsCartBgView.frame = CGRectMake(0, 0, SCREEN_WIDTH, del.window.bounds.size.height-45);
    //3. 背景颜色可以用多种方法看需要咯
    self.goodsCartBgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.4];
    [del.window addSubview:self.goodsCartBgView];
    UITapGestureRecognizer *bgtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideCartView)];
    [self.goodsCartBgView addGestureRecognizer:bgtap];
    self.goodsCartBgView.hidden = YES;
    [self updateBottomView:self.shopCartDict];
    [self.view addSubview:self.typeTableView];
    [self.view addSubview:self.goodsTableView];
    [self.view addSubview:self.bottomView];
    [self requestData];
}
- (void)hideCartView{
    
    self.goodsCartBgView.hidden = YES;
    [self.bottomView shoppCartClick];
  
}

- (void)requestData{
    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
    parmas[@"la"] = @(self.lat);
    parmas[@"lo"] = @(self.lon);
    parmas[@"id"] = self.shopModel.id;
    parmas[@"uuid"] = [keepUserInfoHandle readUserInfoWith:1];
    [URLRequest postWithURL:@"shop/type/list" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [self.typeDataArray addObjectsFromArray:[NSArray modelArrayWithClass:[goodsType class] json:[cityShoppingTool jsonConvertToDic:responseObject][@"list"]]];
        [self.typeTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
        [self.typeTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        if ([self.typeTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
            [self.typeTableView.delegate tableView:self.typeTableView didSelectRowAtIndexPath:indexPath];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
          [MBProgressHUD hideHUD];
    }];
}

- (void)rightRequest:(NSInteger)typeID{
    
    [URLRequest getWithURL:[NSString stringWithFormat:@"http://ha.tongchengxianggou.com/api/product/list/shoptype?id=%ld",typeID] params:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [MBProgressHUD hideHUD];
        [MBProgressHUD hideHUD];
        [self.goodsInfoArray removeAllObjects];
        [self.goodsInfoArray addObjectsFromArray:[NSArray modelArrayWithClass:[goodsInfoModel class] json:[cityShoppingTool jsonConvertToDic:responseObject]]];
        [self guiling];
       
        [self.goodsTableView reloadData];
      
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [MBProgressHUD hideHUD];
    }];
}
- (void)guiling{
    
    for (int i = 0; i<self.goodsInfoArray.count; i++){
        goodsInfoModel *model = self.goodsInfoArray[i];
        model.count = 0;
        [self.goodsInfoArray replaceObjectAtIndex:i withObject:model];
    }
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
   
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (tableView.tag == 1001) {
        
        return self.typeDataArray.count;

    }else if(tableView.tag == 1002){
        
        return self.goodsInfoArray.count;
    }else{
        return self.cartDataArray.count;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 1001) {
        static NSString *cellid=@"TableViewCell";
        TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"TableViewCell" owner:self options:nil].firstObject;
        }
        cell.goodsTypeModel = self.typeDataArray[indexPath.section];
        
        return cell;
        
    }else if(tableView.tag == 1002){

        static NSString *cellid=@"goodsTableViewCell";
        goodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"goodsTableViewCell" owner:self options:nil].firstObject;
        }
        goodsInfoModel *infoModel = self.goodsInfoArray[indexPath.section];
        
        for (NSDictionary *dic in self.shopCartArray) {
            if ([infoModel.id integerValue] == [dic[@"id"] integerValue]) {
                infoModel.count = dic[@"count"];
                NSLog(@"count   %ld",[dic[@"count"] integerValue]);
                [self.goodsInfoArray replaceObjectAtIndex:indexPath.section withObject:infoModel];
            }
        }
     
        __weak __typeof(&*cell)weakCell =cell;
        __block __typeof(self)bself = self;
        [cell setBlock:^(NSInteger count, BOOL animated) {
            
            CGRect parentRectA = [weakCell convertRect:weakCell.addBtn.frame toView:bself.view];
            CGRect parentRectB = [bself.bottomView convertRect:bself.bottomView.cartBtn.frame toView:bself.view];
            
            goodsInfoModel *modelInfo = bself.goodsInfoArray[indexPath.section];
            /**
             *  是否执行添加的动画
             */

            if (animated) {
                
                if (modelInfo.attrs.count !=0) {
                    
                    [self show:modelInfo];
                   // [MBProgressHUD hideHUD];
                    
                }else{
                    [MBProgressHUD showMessage:@""];
                    [bself.view addSubview:self.redView];
                    NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
                    parmas[@"id"] = modelInfo.id;
                    parmas[@"uuid"] = Uid;
                    parmas[@"os"] = @"ios";
                    parmas[@"locate"] = @(1);
                    
                    [URLRequest postWithURL:@"cart/add" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
                
                        bself.cartDataDictionary =[NSMutableDictionary dictionaryWithDictionary: [cityShoppingTool jsonConvertToDic:responseObject]];
                        
                        [bself updateBottomView:bself.cartDataDictionary];
                        [bself.shopCartArray removeAllObjects];
                        [bself.shopCartArray addObjectsFromArray:[cityShoppingTool jsonConvertToDic:responseObject][@"carts"]];
                        [bself.goodsTableView reloadData];
                        [[ThrowLineTool sharedTool] throwObject:self.redView from:parentRectA.origin to:parentRectB.origin];
                        [MBProgressHUD hideHUD];
                        
                    } failure:^(NSURLSessionDataTask *task, NSError *error) {
                        NSLog(@"error %@",error);
                        [MBProgressHUD hideHUD];
                        [MBProgressHUD showError:@"网络错误,添加失败"];
                    }];
                }
    
            }else{
                
                NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
                parmas[@"id"] = modelInfo.id;
                parmas[@"uuid"] = Uid;
                parmas[@"os"] = @"ios";
                parmas[@"locate"] = @(1);
                
                [URLRequest postWithURL:@"cart/remove" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
               
                    bself.cartDataDictionary = [NSMutableDictionary dictionaryWithDictionary: [cityShoppingTool jsonConvertToDic:responseObject]];
                    [bself updateBottomView:bself.cartDataDictionary];
                    
                    [bself.shopCartArray removeAllObjects];
                    [bself.shopCartArray addObjectsFromArray:[cityShoppingTool jsonConvertToDic:responseObject][@"carts"]];
                    [self guiling];
                    [bself.goodsTableView reloadData];
                    
                    [MBProgressHUD hideHUD];
                    
                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                    NSLog(@"%@",error);
                }];
                
        }
            NSLog(@"shopcart:%@",bself.shopCartArray);
           
        }];
            cell.model = infoModel;
            return cell;
    }else{
        declareWeakSelf;
        static NSString *cellid=@"goodsTableViewCell";
        goodsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if (!cell) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"goodsTableViewCell" owner:self options:nil].firstObject;
        }
        goodsInfoModel *infoModel = self.cartDataArray[indexPath.section];
        cell.model = infoModel;
        [cell setBlock:^(NSInteger count, BOOL animated) {
            
            NSString *urlString;
            if (animated) {
                urlString = @"cart/add";
            }else{
                urlString = @"cart/remove";
            }
            NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
            parmas[@"id"] = infoModel.id;
            parmas[@"uuid"] = Uid;
            parmas[@"os"] = @"ios";
            parmas[@"locate"] = @(1);
            
            [URLRequest postWithURL:urlString params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
    
                weakSelf.cartDataDictionary =[NSMutableDictionary dictionaryWithDictionary:[cityShoppingTool jsonConvertToDic:responseObject]];
                [weakSelf updateBottomView:weakSelf.cartDataDictionary];
                
                [weakSelf.shopCartArray removeAllObjects];
                [weakSelf.shopCartArray addObjectsFromArray:[cityShoppingTool jsonConvertToDic:responseObject][@"carts"]];

                if (!animated) {
                    [weakSelf guiling];
                }
                [weakSelf.goodsTableView reloadData];
                if ([[cityShoppingTool jsonConvertToDic:responseObject][@"count"] intValue] == 0) {
                    [weakSelf showCartView:NO];
                }
                [MBProgressHUD hideHUD];
                
            } failure:^(NSURLSessionDataTask *task, NSError *error) {
                NSLog(@"error %@",error);
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:@"网络错误,操作失败"];
            }];
        }];
        
        return cell;
        
    }
}

- (void)show:(goodsInfoModel *)model{
    declareWeakSelf;
    //1. 取出window
    UIWindow * window = [UIApplication sharedApplication].windows.lastObject;
    //[[[UIApplication sharedApplication] windows] firstObject];有时这样取window会加载不出我们需要的试图，这是因为不是keywindow，比如用storyboard画的试图，推荐用keywindow不论什么情况包不会出问题。
    //2. 创建背景视图
    self.attrBgView = [[UIView alloc]init];
    self.attrBgView.frame = window.bounds;
    //3. 背景颜色可以用多种方法看需要咯
    self.attrBgView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.6];
    [window addSubview:self.attrBgView];
    //4. 把需要展示的控件添加上去
   // [window addSubview:self];
    self.attrsView = [[goodsAttrsView alloc]initWithFrame:CGRectMake(40,200, SCREEN_WIDTH-80,SCREEN_HEIGHT-340) withModel:model];
    [self.attrsView setAddCart:^(NSString *goodsID) {
        
        NSMutableDictionary *parmas = [[NSMutableDictionary alloc]init];
        parmas[@"id"] = model.id;
        parmas[@"attr"] = goodsID;
        parmas[@"uuid"] = Uid;
        parmas[@"os"] = @"ios";
        parmas[@"locate"] = @(1);
        
        [URLRequest postWithURL:@"cart/add/attr" params:parmas success:^(NSURLSessionDataTask *task, id responseObject) {
        
            weakSelf.cartDataDictionary = responseObject;
            [weakSelf updateBottomView:weakSelf.cartDataDictionary];
            [weakSelf.shopCartArray removeAllObjects];
            [weakSelf.shopCartArray addObjectsFromArray:responseObject[@"carts"]];
            [weakSelf.goodsTableView reloadData];
            [MBProgressHUD hideHUD];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
            NSLog(@"%@",error);
            [MBProgressHUD hideHUD];
            [MBProgressHUD showError:@"网络错误,添加失败"];
            
        }];
        
        NSLog(@"%@",goodsID);
        [weakSelf.attrBgView removeFromSuperview];
        [weakSelf.attrsView removeFromSuperview];
        
    }];
    
    [window addSubview:self.attrsView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideView)];
    [self.attrBgView addGestureRecognizer:tap];
    
}

- (void)hideView{
    
    [self.attrBgView removeFromSuperview];
    [self.attrsView removeFromSuperview];
    
}

#pragma mark - 设置购物车动画
- (void)animationDidFinish
{
    [self.redView removeFromSuperview];
    [UIView animateWithDuration:0.1 animations:^{
        self.bottomView.cartBtn.transform = CGAffineTransformMakeScale(0.8, 0.8);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1 animations:^{
            self.bottomView.cartBtn.transform = CGAffineTransformMakeScale(1, 1);
        } completion:^(BOOL finished) {
            
        }];
        
    }];
}

- (UIImageView *)redView
{
    if (!_redView) {
        _redView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 15, 15)];
        _redView.image = [cityShoppingTool createImageWithColor:UIColorFromRGBA(68, 195, 34, 1) andSize:CGSizeMake(1, 1)];
        _redView.layer.cornerRadius = 7.5;
        _redView.layer.masksToBounds = YES;
    }
    return _redView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    
    if (tableView.tag == 1001) {
        return 50;
    }else{
        return 100;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 1001) {
        
        goodsType *typeModel = [[goodsType alloc]init];
        typeModel = self.typeDataArray[indexPath.section];
        [self rightRequest:[typeModel.id integerValue]];
        [MBProgressHUD showMessage:@""];
        
    }
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


#pragma update bottomDate
-(void)updateBottomView:(NSDictionary *)dic{
    self.cartHeaderView.countAndWeightLabel.text = [NSString stringWithFormat:@"共%@件,重量%@kg",dic[@"count"],dic[@"weight"]];
    [self.shopCartArray addObjectsFromArray:dic[@"carts"]];
    
    [self.bottomView configDataWith:dic];
    [self.cartDataArray removeAllObjects];
        if ([self.shopCartDict count]!=0) {
            [self.cartDataArray addObjectsFromArray:[NSArray modelArrayWithClass:[goodsInfoModel class] json:dic[@"carts"]]];
    }
    [self.cartTableView reloadData];
}

//绘制三角形
- (void)drawTrigger:(CGRect)rect{
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    //path移动到开始画图的位置
    [path moveToPoint:CGPointMake(rect.origin.x+30, rect.origin.y)];
    //从开始位置画一条直线到（rect.origin.x + rect.size.width， rect.origin.y）
    [path addLineToPoint:CGPointMake(rect.origin.x + 35, rect.origin.y-8)];
    //再从rect.origin.x + rect.size.width， rect.origin.y））画一条线到(rect.origin.x + rect.size.width/2, rect.origin.y + rect.size.height)
    [path addLineToPoint:CGPointMake(rect.origin.x+40, rect.origin.y)];
    
    //关闭path
    [path closePath];
    
    //三角形内填充颜色
    [UIColorFromRGBA(244, 244, 244, 1) setFill];
    
    [path fill];
}

@end
