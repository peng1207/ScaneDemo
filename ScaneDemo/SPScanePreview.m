//
//  SPScanePreview.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPScanePreview.h"
#import <AVFoundation/AVFoundation.h>

@implementation SPScanePreview

+ (Class)layerClass{
    return AVCaptureVideoPreviewLayer.class;
}

@end
