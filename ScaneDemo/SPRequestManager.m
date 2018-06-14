//
//  SPRequestManager.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/14.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPRequestManager.h"
#import <AFNetworking.h>
@implementation SPRequestManager

/**
 post 请求
 
 @param urlString 请求链接
 @param parm 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)sp_postForUrl:(NSString *)urlString  parm:(NSDictionary *) parm success:(RequestSuccessBlock) successBlock failure:(RequestFailureBlock )failureBlock{
    AFHTTPSessionManager *mgr = [self sp_afManager];
    [mgr POST:urlString parameters:parm progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (AFHTTPSessionManager *)sp_afManager{
    AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    mgr.requestSerializer.timeoutInterval = 60;//默认超时时间
    mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",nil];
    return mgr;
}
@end
