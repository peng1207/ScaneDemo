//
//  UIImage+SPExt.h
//  ScaneDemo
//
//  Created by okdeer on 2018/6/1.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SPExt)

/**
 压缩图片

 @param sourceImage 图片
 @param defineWidth 宽度
 @return 图片
 */
+ (UIImage *) imageCompressForImage:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
@end
