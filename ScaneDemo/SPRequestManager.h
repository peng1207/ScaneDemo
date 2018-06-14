//
//  SPRequestManager.h
//  ScaneDemo
//
//  Created by okdeer on 2018/6/14.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RequestSuccessBlock)(id reponse);
typedef void(^RequestFailureBlock)(NSError *error);

@interface SPRequestManager : NSObject

/**
 post 请求

 @param urlString 请求链接
 @param parm 请求参数
 @param successBlock 请求成功回调
 @param failureBlock 请求失败回调
 */
+ (void)sp_postForUrl:(NSString *)urlString  parm:(NSDictionary *) parm success:(RequestSuccessBlock) successBlock failure:(RequestFailureBlock )failureBlock;

@end
