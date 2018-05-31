//
//  SPScanManager.h
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//
// 扫描初始化 扫描管理类
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
#import "SPSaneHead.h"

@interface SPScanManager : NSObject

@property (nonatomic,copy) ScanBackBlock scanBackBlock;    // 获取数据回调
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;
+  (instancetype)initLayer:(AVCaptureVideoPreviewLayer *)previewLayer metadateTypes:(NSArray *)metadateTypeArray rectOfInterest:(CGRect)rectOfInterest;
/**
 开始扫描
 */
- (void)startRunning;
/**
  停止扫描
 */
- (void)stopRunning;
/**
  点击闪光灯 on 是否打开
 */
- (void)clickFlashAction:(BOOL)on;
/**
 点击选择相册
 */
- (void)clickAlbum:(UIViewController *)viewController;

@end
