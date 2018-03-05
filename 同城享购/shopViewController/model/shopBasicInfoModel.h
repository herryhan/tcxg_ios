//
//  shopBasicInfoModel.h
//  同城享购
//
//  Created by 韩先炜 on 2017/11/15.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "ViewModelClass.h"

@interface shopBasicInfoModel : ViewModelClass

-(void)fetchBasicInfo:(NSNumber *)shop_id andUuid:(NSString *)uuid;

@end
