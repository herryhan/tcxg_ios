//
//  keepUserInfoHandle.h
//  同城享购
//
//  Created by 韩先炜 on 2018/1/24.
//  Copyright © 2018年 庄园. All rights reserved.
//
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, KeepUserInfoType) {
    UUID = 1,
    CHANNALID,
    HEADER_PORTIMAGE,
    NICKNAME,
};

@interface keepUserInfoHandle : NSObject

/**
 *   存储 用户信息
 *
 *     */
+(void)saveUserInfo:(NSString *)keyString withInfoType:(KeepUserInfoType )type;

/**
 *  读取用户信息 *
 *
 */
+(NSString *)readUserInfoWith:(KeepUserInfoType)type;

/**
 *    删除用户信息
 */
+(void)deleteUserInfoWith:(KeepUserInfoType)type;

@end

