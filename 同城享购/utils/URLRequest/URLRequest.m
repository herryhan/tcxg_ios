//
//  URLRequest.m
//  外汇
//
//  Created by 庄园 on 17/11/4.
//  Copyright © 2017年 庄园. All rights reserved.
//

#import "URLRequest.h"

@implementation URLRequest

#define BASEURL @"http://ha.tongchengxianggou.com/api/"

+ (void)getWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:url]];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 15.0f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            if (success) {
                if ([[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding] isEqualToString:@"'login'"]) {
                    [[NSNotificationCenter defaultCenter]postNotificationName:@"strongLogin" object:nil];        }else{
                        success(task, responseObject);
                    }
            }
            
           // success(task,responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
           
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
            NSLog(@"%@",error);
        }
    }];
}

+ (void)postWithURL:(NSString *)url params:(NSDictionary *)params success:(void (^)(NSURLSessionDataTask *task, id responseObject))success failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
{
    // 1.获得请求管理者
    AFHTTPSessionManager *mgr = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [mgr.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    mgr.requestSerializer.timeoutInterval = 10.0f;
    [mgr.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];// 请求
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];// 响应
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/plain",@"application/json",@"text/html",@"text/json",nil];

    [mgr POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
             NSString *receiveStr = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"login:%@",receiveStr);
            if ([receiveStr isEqualToString:@"\'login\'"]){
                [MBProgressHUD hideHUD];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"loginAction" object:nil];
            }else{
                success(task, responseObject);
            }
        }
    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        if (failure) {
            [mgr.operationQueue cancelAllOperations];
            failure(task,error);
        }
       
    }];
    
}


@end
