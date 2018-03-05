//
//  SecCateModel.h
//  同城享购
//
//  Created by Charles on 2018/2/25.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SecCateSecModel : NSObject

@property (nonatomic,copy) NSString *cate_name;
@property (nonatomic,copy) NSString *cate_logo;
@property (nonatomic,copy) NSString *cate_id;

@end

@interface SecCateModel : NSObject

@property (nonatomic,copy) NSString *cate_name;
@property (nonatomic,copy) NSString *cate_logo;
@property (nonatomic,copy) NSString *cate_id;
@property (nonatomic,strong) NSArray <SecCateSecModel *> *cate_list;

@end
