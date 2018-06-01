//
//  SPUploadManager.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/1.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPUploadManager.h"
#import "AFNetWorking.h"
#import "UIImage+SPExt.h"

@implementation SPUploadManager

/**
 上传图片
 
 @param para 参数
 @param requestUrl 上传链接
 @param imageArray image数组
 @param successBlock 上传成功
 @param failureBlock 上传失败
 */
+ (void)sp_uploadImageWithOption:(NSDictionary *)para withRequestUrl:(NSString *)requestUrl imageArray:(NSArray *)imageArray uploadSuccess:(SPUploadSuccessBlock)successBlock uploadFailure:(SPUploadFailureBlock)failureBlock{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    [manager POST:requestUrl parameters:para constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSInteger i = 0 ;
        for (UIImage *image in imageArray) {
            UIImage *newImage = [UIImage imageCompressForImage:image targetWidth:640];
            NSData *imageData = UIImagePNGRepresentation(newImage);
            [formData appendPartWithFileData:imageData name:[NSString stringWithFormat:@"picfile%ld",(long)i] fileName:@"image.png" mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


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
                          failure:(SPUploadFailureBlock)failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    switch (style) {
        case JSON:
            manager.responseSerializer = [AFJSONResponseSerializer serializer];
            break;
            case XML:
            manager.responseSerializer = [AFXMLParserResponseSerializer serializer];;
            break;
            case Data:
            manager.responseSerializer = [AFHTTPResponseSerializer serializer];
            break;
        default:
            break;
    }
    [manager.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain", @"application/javascript",@"application/json", @"application/x-www-form-urlencoded", nil]];
    [manager POST:requestUrl parameters:parm  constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

@end
