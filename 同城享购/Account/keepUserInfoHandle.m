
//
//  keepUserInfoHandle.m
//  同城享购
//
//  Created by 韩先炜 on 2018/1/24.
//  Copyright © 2018年 庄园. All rights reserved.
//

#import "keepUserInfoHandle.h"

@implementation keepUserInfoHandle

/**
 *   存储 用户信息
 *
 *     */
+(void)saveUserInfo:(NSString *)keyString withInfoType:(KeepUserInfoType )type{
    
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    switch (type) {
        case 1:
            [userDefault setObject:keyString forKey:@"uuid"];
            break;
        case 2:
            [userDefault setObject:keyString forKey:@"channelId"];
            break;
        case 3:
            [userDefault setObject:keyString forKey:@"headImage"];
            break;
        case 4:
            [userDefault setObject:keyString forKey:@"nickName"];
            break;
        default:
            break;
    }
    [userDefault synchronize];
}

/**
 *  读取用户信息 *
 *
 */
+(NSString *)readUserInfoWith:(KeepUserInfoType)type{
    NSString *infoString;
    
    switch (type) {
        case 1:
            infoString = [[NSUserDefaults standardUserDefaults] objectForKey:@"uuid"];
            break;
        case 2:
            infoString = [[NSUserDefaults standardUserDefaults] objectForKey:@"channelId"];
            break;
        case 3:
            infoString = [[NSUserDefaults standardUserDefaults] objectForKey:@"headImage"];
            break;
        case 4:
            infoString = [[NSUserDefaults standardUserDefaults] objectForKey:@"nickName"];
            break;
        default:
            break;
    }
    return infoString;
}

/**
 *    删除用户信息
 */

+(void)deleteUserInfoWith:(KeepUserInfoType)type{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    switch (type) {
        case 1:
            [userDefault removeObjectForKey:@"uuid"];
            break;
        case 2:
            [userDefault removeObjectForKey:@"channelId"];
            break;
        case 3:
            [userDefault removeObjectForKey:@"headImage"];
            break;
        case 4:
            [userDefault removeObjectForKey:@"nickName"];
            break;
        default:
            break;
    }
    [userDefault synchronize];
}

@end





