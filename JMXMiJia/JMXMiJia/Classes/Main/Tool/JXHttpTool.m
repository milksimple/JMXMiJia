//
//  JXHttpTool.m
//  JMXMiJia
//
//  Created by 张盼盼 on 16/1/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "JXHttpTool.h"
#import <AFNetworking.h>

@implementation JXHttpTool

+ (void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr GET:@"http://10.255.1.24/dschoolAndroid/SendCheckCode" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void (^)(id json))success failure:(void (^)(NSError *error))failure {
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    [mgr POST:@"http://10.255.1.24/dschoolAndroid/SendCheckCode" parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end
