//
//  SPUploadManager.h
//  ScaneDemo
//
//  Created by okdeer on 2018/6/1.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^SPUploadSuccessBlock)(void);
typedef void(^SPUploadFailureBlock)(void);
typedef void(^SPUploadProgressBlock)(void);

typedef NS_ENUM(NSUInteger, SPResposeStyle) {
    JSON,
    XML,
    Data,
};

typedef NS_ENUM(NSUInteger, SPRequestStyle) {
    RequestJSON,
    RequestString,
    RequestDefault
};

@interface SPUploadManager : NSObject

/**
 上传图片

 @param para 参数
 @param requestUrl 上传链接
 @param imageArray image数组
 @param successBlock 上传成功
 @param failureBlock 上传失败
 */
+ (void)sp_uploadImageWithOption:(NSDictionary *)para withRequestUrl:(NSString *)requestUrl imageArray:(NSArray *)imageArray uploadSuccess:(SPUploadSuccessBlock)successBlock uploadFailure:(SPUploadFailureBlock)failureBlock;

/**
  单个文件上传

 @param requestUrl 上传链接
 @param parm 参数
 @param fileData 上传数据
 @param name 服务器参数名称
 @param fileName 文件名称 图片:xxx.jpg,xxx.png 视频:video.mov
 @param mimeType 文件类型 图片:image/jpg,image/png 视频:video/quicktime
 @param style 返回的数据类型
 @param progressBlock  进度
 @param success 成功
 @param failure 失败
 */
+ (void)sp_uploadImageToUrlString:(NSString *) requestUrl
                             parm:(NSDictionary *)parm
                         fileData:(NSData *)fileData
                             name:(NSString *)name
                         fileName:(NSString *)fileName
                         mimeType:(NSString *)mimeType
                         response:(SPResposeStyle)style
                         progress:(SPUploadProgressBlock) progressBlock
                          success:(SPUploadSuccessBlock) success
                          failure:(SPUploadFailureBlock)failure;


@end
