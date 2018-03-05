//
//  NSString+PX.h
//  同城享购
//
//  Created by Charles on 2018/2/26.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PX)

- (BOOL)px_checkPhoneNum;

+ (NSString *)transform:(NSString *)chinese;

@end
