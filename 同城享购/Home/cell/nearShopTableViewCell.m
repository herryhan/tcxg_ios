//
//  nearShopTableViewCell.m
//  同城享购
//
//  Created by 韩先炜 on 2017/11/11.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "nearShopTableViewCell.h"
#import <YYLabel.h>
#import <Masonry.h>
#import <UIButton+YYWebImage.h>
#import <UIImageView+YYWebImage.h>
#import <UIImage+YYAdd.h>
#import "activityLabelView.h"
#import "activityTagView.h"

@interface nearShopTableViewCell ()

@property (nonatomic ,strong)UIImageView *logoImage;
@property (nonatomic ,strong)YYLabel *shopNameLabel;
@property (nonatomic ,strong)UIImageView *singleView;
@property (nonatomic ,strong)UIImageView *vipShopImageView;
//@property (nonatomic ,strong)YYLabel *sendLabel;
@property (nonatomic ,strong)UIImageView *rankImageView;
@property (nonatomic ,strong)YYLabel *monthSalesLabel;
@property (nonatomic ,strong)UIImageView *distanceImageView;
@property (nonatomic ,strong)YYLabel *distanceLabel;
@property (nonatomic ,strong)UIImageView *addressImageView;
@property (nonatomic ,strong)YYLabel *addressLabel;
@property (nonatomic ,strong)activityNewView *actView;
//@property (nonatomic ,strong)imagesView *recImageView;
@property (nonatomic ,strong)UIImageView *lineImageView;

@property (nonatomic ,strong) YYLabel *avgTimeLabel;

@property (nonatomic ,strong) activityTagView *actTagView;

@end

@implementation nearShopTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self SetUpUI];
    }
    
    return self;
}
- (void)SetUpUI{
    [self.contentView addSubview:self.logoImage];
    [self.contentView addSubview:self.shopNameLabel];
    [self.contentView addSubview:self.vipShopImageView];
    [self.contentView addSubview:self.singleView];
    [self.contentView addSubview:self.avgTimeLabel];
    
    
  //  [self.contentView addSubview:self.sendLabel];
    [self.contentView addSubview:self.rankImageView];
    [self.contentView addSubview:self.monthSalesLabel];
    [self.contentView addSubview:self.distanceImageView];
    [self.contentView addSubview:self.distanceLabel];
    [self.contentView addSubview:self.addressImageView];
    [self.contentView addSubview:self.addressLabel];
    [self.contentView addSubview:self.lineImageView];
    //[self.contentView addSubview:self.actTagView];
    
    [self.contentView addSubview:self.actView];
    //[self.contentView addSubview:self.recImageView];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [self.logoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(10);
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(60*1.25);
    }];
    [self.shopNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImage);
        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
        make.width.mas_equalTo(SCREEN_WIDTH-140);
        make.height.mas_equalTo(20);
    }];
    
    [self.vipShopImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.logoImage);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.singleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(12);
        make.right.mas_equalTo(self.vipShopImageView.mas_left).offset(-5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(20/30*20);
    }];
    
    [self.avgTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {

        make.right.mas_equalTo(self.contentView).offset(-10);;
        make.top.mas_equalTo(self.shopNameLabel.mas_bottom).offset(5);
        //make.right.mas_equalTo(10);
        make.height.mas_equalTo(16);
    }];
 
//    [self.sendLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.shopNameLabel.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(104);
//    }];
   
    
    [self.rankImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.shopNameLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(60);
        
    }];
    
    [self.monthSalesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.rankImageView.mas_right).offset(1);
        make.top.mas_equalTo(self.shopNameLabel.mas_bottom).offset(6.5);
        //make.right.mas_equalTo(10);
        make.height.mas_equalTo(16);
    }];
    
    [self.distanceImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
        make.top.mas_equalTo(self.rankImageView.mas_bottom).offset(5);
        make.height.width.mas_equalTo(16);
    }];
    [self.distanceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.distanceImageView.mas_right).offset(1);
        make.top.mas_equalTo(self.rankImageView.mas_bottom).offset(5);
        make.right.mas_equalTo(10);
        make.height.mas_equalTo(16);
    }];
    [self.addressImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.distanceImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
        make.height.width.mas_equalTo(16);
    }];
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.distanceImageView.mas_bottom).offset(5);
        make.left.mas_equalTo(self.addressImageView.mas_right).offset(1);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(16);
       
    }];
    [self.lineImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
        make.top.mas_equalTo(self.addressImageView.mas_bottom).offset(5);
        make.right.mas_equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(0.5);
       // make.bottom.mas_equalTo(self.contentView).offset(-10).priorityLow();
    }];
//    [self.actTagView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.lineImageView.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
//        make.right.mas_equalTo(self.contentView).offset(-30);
//        make.height.mas_equalTo(60);
//        make.bottom.mas_equalTo(self.contentView).offset(-10).priorityLow();
//    }];
    
    [self.actView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
        make.top.mas_equalTo(self.lineImageView.mas_bottom).offset(10);
        make.right.mas_equalTo(self.contentView).offset(-10);
        make.height.mas_equalTo(0).priorityLow();
        make.bottom.mas_equalTo(self.contentView).offset(0).priorityLow();
       // make.height.mas_equalTo(self.contentView).offset(-10).priorityLow();
    }];
//    [self.recImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.actView.mas_bottom).offset(5);
//        make.left.mas_equalTo(self.logoImage.mas_right).offset(8);
//        make.right.mas_equalTo(self.contentView).offset(-10);
//        make.height.mas_equalTo(0).priorityLow();
//        make.bottom.mas_equalTo(self.contentView).offset(-10).priorityLow();
//    }];
}
-(void)setModel:(homeModel *)model{
    
    _model = model;
    declareWeakSelf;
    [self.logoImage setImageWithURL:[NSURL URLWithString:model.logo] placeholder:[UIImage imageNamed:@"AppIcon512x512"] options:YYWebImageOptionSetImageWithFadeAnimation manager:[YYWebImageManager sharedManager] progress:nil transform:^UIImage * _Nullable(UIImage * _Nonnull image, NSURL * _Nonnull url) {
        
        return image;
        
    }  completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
       // UIImage *newimage = [image imageByRoundCornerRadius:15];
        
        weakSelf.logoImage.image = image;
        
    }];
   // NSMutableArray *tagArray = [[NSMutableArray alloc]init];
    
//    for (NSDictionary *dic in model.actives) {
//        [tagArray addObject:dic[@"name"]];
//    }
//    [self.actTagView setTagArray:tagArray];
    
    self.actView.activityNewArray = [NSMutableArray arrayWithArray:model.actives];
    if (model.actives.count == 0) {
        self.lineImageView.alpha = 0;
    }else{
        self.lineImageView.alpha = 1;
    }
   // self.recImageView.imagesArray = [NSMutableArray arrayWithArray:model.products];
    self.shopNameLabel.text = model.name;
    if ([model.vip integerValue] == 0) {
        [self.vipShopImageView setImage:[UIImage imageNamed:@"auth0"]];
    }else{
        [self.vipShopImageView setImage:[UIImage imageNamed:@"auth1"]];
    }
    if ([model.singleDay integerValue] == 1) {
        [self.singleView setImage:[UIImage imageNamed:@"singler"]];
    }
    
    self.monthSalesLabel.text = [NSString stringWithFormat:@" 月售%@单",model.monthSells];
    self.addressLabel.text = model.address;
    switch ([model.score integerValue]) {
        case 0:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank0"]];
            break;
        case 1:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank1"]];
            break;
        case 2:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank2"]];
            break;
        case 3:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank3"]];
            break;
        case 4:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank4"]];
            break;
            
        case 5:
            [self.rankImageView setImage:[UIImage imageNamed:@"rank5"]];
            break;
        default:
            break;
    }
    
    [self.distanceImageView setImage:[UIImage imageNamed:@"distance"]];
    [self.addressImageView setImage:[UIImage imageNamed:@"address"]];
    self.distanceLabel.text = [NSString stringWithFormat:@"起送:¥%@ | 配送:¥%@",model.minMoney,model.fee];
    self.avgTimeLabel.text = [NSString stringWithFormat:@"%@分钟 | %0.2lfkm",model.avgTime,[model.distance floatValue]];
}

#pragma  mark - Getter

- (UIImageView *)logoImage{
    if (!_logoImage) {
        _logoImage = [[UIImageView alloc]init];
        _logoImage.layer.borderWidth = 0.5;
        _logoImage.layer.borderColor = UIColorFromRGBA(240, 240, 240, 1).CGColor;
//        _logoImage.contentMode = UIViewContentModeScaleAspectFill;
        _logoImage.layer.cornerRadius = 5;
        _logoImage.layer.masksToBounds = YES;
    }
    return _logoImage;
}
- (YYLabel *)shopNameLabel{
    if (!_shopNameLabel) {
        _shopNameLabel = [YYLabel new];
        //_shopNameLabel.textVerticalAlignment = YYTextDirectionLeft;
       // _shopNameLabel.backgroundColor = [UIColor redColor];
        _shopNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _shopNameLabel;
}
- (UIImageView *)vipShopImageView{
    if (!_vipShopImageView) {
        _vipShopImageView = [[UIImageView alloc]init];
    }
    return _vipShopImageView;
}
- (UIImageView *)singleView{
    if (!_singleView) {
        _singleView = [[UIImageView alloc]init];
    }
    return _singleView;
}
//- (YYLabel *)sendLabel{
//    if (!_sendLabel) {
//        _sendLabel = [YYLabel new];
//        _sendLabel.font = [UIFont systemFontOfSize:13];
//        _sendLabel.layer.borderWidth = 0.5;
//        _sendLabel.layer.borderColor = UIColorFromRGBA(68, 195, 34, 1).CGColor;
//        _sendLabel.textColor = UIColorFromRGBA(68, 195, 34, 1);
//        _sendLabel.text = @"享购专送-30分钟";
//        _sendLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _sendLabel;
//}
- (UIImageView *)rankImageView{
    if (!_rankImageView) {
        _rankImageView = [[UIImageView alloc]init];
    }
    return _rankImageView;
}
- (YYLabel *)monthSalesLabel{
    if (!_monthSalesLabel) {
        _monthSalesLabel = [YYLabel new];
        _monthSalesLabel.font =[UIFont systemFontOfSize:12];
        _monthSalesLabel.textColor = [UIColor lightGrayColor];
    }
    return _monthSalesLabel;
}
- (UIImageView *)distanceImageView{
    if (!_distanceImageView) {
        _distanceImageView = [[UIImageView alloc]init];
    }
    return _distanceImageView;
}
- (YYLabel *)distanceLabel{
    
    if (!_distanceLabel) {
        _distanceLabel = [YYLabel new];
        _distanceLabel.font = [UIFont systemFontOfSize:12];
        _distanceLabel.textColor = [UIColor lightGrayColor];
    }
    return _distanceLabel;
}
- (UIImageView *)addressImageView{
    if (!_addressImageView) {
        _addressImageView = [[UIImageView alloc]init];
    }
    return _addressImageView;
}
- (YYLabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [YYLabel new];
        _addressLabel.font = [UIFont systemFontOfSize:12];
        _addressLabel.textColor = [UIColor lightGrayColor];
    }
    return _addressLabel;
}
- (UIImageView *)lineImageView{
    if (!_lineImageView) {
        _lineImageView = [[UIImageView alloc]init];
        [_lineImageView setImage:[UIImage imageNamed:@"239"]];
    }
    return _lineImageView;
}
- (YYLabel *)avgTimeLabel{
    if (!_avgTimeLabel) {
        _avgTimeLabel = [YYLabel new];
        _avgTimeLabel.font = [UIFont systemFontOfSize:12];
        _avgTimeLabel.textColor = [UIColor lightGrayColor];
    }
    return _avgTimeLabel;
}
//- (activityTagView *)actTagView{
//    if (!_actTagView) {
//        _actTagView = [[activityTagView alloc]init];
//        _actTagView.backgroundColor = [UIColor redColor];
//    }
//    return _actTagView;
//}

- (activityNewView *)actView{
    if (!_actView) {
        _actView =[[activityNewView alloc]init];
    }
    return _actView;
}

//- (imagesView *)recImageView{
//
//    if (!_recImageView) {
//        _recImageView = [[imagesView alloc]init];
//        //_recImageView.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _recImageView;
//}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

#pragma imageview getter
//@interface imagesView ()
//@property (nonatomic ,strong) NSMutableArray *imageViewsArray;
//@property (nonatomic,strong) NSMutableArray *priceLabelArray;
//
//@end
//#define imageWith (SCREEN_WIDTH - 88 - 30)/4
//
//@implementation imagesView
//- (NSMutableArray *)imageViewsArray{
//
//    if (!_imageViewsArray) {
//        _imageViewsArray = [[NSMutableArray alloc]init];
//    }
//    return _imageViewsArray;
//}
//
//- (NSMutableArray *)priceLabelArray{
//    if (!_priceLabelArray) {
//        _priceLabelArray = [[NSMutableArray alloc]init];
//    }
//    return _priceLabelArray;
//}
//
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self configUI];
//    }
//    return self;
//}
//- (void)configUI{
//    for (int i =0; i<4; i++) {
//        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((imageWith+10) * i, 0, imageWith, imageWith)];
//        UILabel *priceLabel = [[UILabel alloc]initWithFrame:CGRectMake((imageWith+10) * i, imageWith+3, imageWith, 20)];
//        priceLabel.font = [UIFont systemFontOfSize:13];
//        priceLabel.textColor = [UIColor redColor];
//        priceLabel.textAlignment = NSTextAlignmentCenter;
//        image.hidden = YES;
//        priceLabel.hidden = YES;
//
//        [self.imageViewsArray addObject:image];
//        [self.priceLabelArray addObject:priceLabel];
//        [self addSubview:image];
//        [self addSubview:priceLabel];
//    }
//}
//- (void)setImagesArray:(NSMutableArray *)imagesArray{
//
//    _imagesArray = imagesArray;
//
//    [self.imageViewsArray enumerateObjectsUsingBlock:^(UIImageView *  _Nonnull image, NSUInteger idx, BOOL * _Nonnull stop) {
//
//        if (idx<self.imagesArray.count) {
//
//            [image sd_setImageWithURL:[NSURL URLWithString:self.imagesArray[idx][@"logo"]]];
//
//            image.hidden = NO;
//
//        }else{
//
//            image.hidden = YES;
//        }
//
//    }];
//    [self.priceLabelArray enumerateObjectsUsingBlock:^(UILabel *  _Nonnull priceLabel, NSUInteger idx, BOOL * _Nonnull stop) {
//        if (idx<self.imagesArray.count) {
//            priceLabel.text = [NSString stringWithFormat:@"¥%@",self.imagesArray[idx][@"price"]];
//            priceLabel.hidden = NO;
//        }else{
//            priceLabel.hidden = YES;
//        }
//    }];
//
//    if (imagesArray.count == 0) {
//
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//
//            make.height.mas_equalTo(0).priorityMedium();
//
//        }];
//    }else{
//        [self mas_updateConstraints:^(MASConstraintMaker *make) {
//
//            make.height.mas_equalTo(imageWith+23).priorityMedium();
//
//        }];
//    }
//}
//
//@end

//
@interface activityNewView ()

@property (nonatomic ,strong) NSMutableArray *activityLabelViewsArray;

@end

#define LabelWidth (SCREEN_WIDTH - 88)

@implementation activityNewView
- (NSMutableArray *)activityLabelViewsArray{
    if (!_activityLabelViewsArray) {
        _activityLabelViewsArray = [[NSMutableArray alloc]init];
    }
    return _activityLabelViewsArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self uiconfig];
    }
    return self;
}
- (void)uiconfig{
    for (int i =0; i<10; i++) {

        activityLabelView *act = [[activityLabelView alloc]initWithFrame:CGRectMake(0, 23*i, LabelWidth, 23)];


        act.hidden = YES;
        [self.activityLabelViewsArray addObject:act];
        [self addSubview:act];
    }
}

- (void)setActivityNewArray:(NSMutableArray *)activityNewArray{

    _activityNewArray = activityNewArray;

    [self.activityLabelViewsArray enumerateObjectsUsingBlock:^(activityLabelView *  _Nonnull actview, NSUInteger idx, BOOL * _Nonnull stop) {

        if (idx < activityNewArray.count) {
            [actview setValueWithDic:self.activityNewArray[idx]];
            actview.hidden = NO;
        }else{

            actview.hidden = YES;
        }

    }];
    if (activityNewArray.count == 0) {

        [self mas_updateConstraints:^(MASConstraintMaker *make) {

            make.height.mas_equalTo(5).priorityMedium();

        }];
    }else{
        [self mas_updateConstraints:^(MASConstraintMaker *make) {

            make.height.mas_equalTo(23*activityNewArray.count).priorityMedium();

        }];
    }

}
@end










