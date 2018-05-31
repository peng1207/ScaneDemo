//
//  SPScanManager.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPScanManager.h"

@interface SPScanManager()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic,strong) AVCaptureDevice *device;
@property (nonatomic,strong) AVCaptureSession *session;

@property (nonatomic,strong) NSArray *metadateTypeArray;
@property (nonatomic,assign) CGRect rectOfInterest;
@end

@implementation SPScanManager

+  (instancetype)initLayer:(AVCaptureVideoPreviewLayer *)previewLayer metadateTypes:(NSArray *)metadateTypeArray rectOfInterest:(CGRect)rectOfInterest{
    SPScanManager *manager = [[SPScanManager alloc] init];
    manager.previewLayer = previewLayer;
    manager.metadateTypeArray = metadateTypeArray;
    manager.rectOfInterest = rectOfInterest; 
    [manager setup];
    return manager;
}
/**
 初始化
 */
- (void)setup{
    self.session = [[AVCaptureSession alloc] init];
    self.previewLayer.session = self.session;
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceinput = [[AVCaptureDeviceInput alloc] initWithDevice:self.device error:nil];
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]  init];
    if ([self.session canAddInput:deviceinput]) {
        [self.session addInput:deviceinput];
    }
    if ([self.session canAddOutput:output]) {
        [self.session addOutput:output];
    }
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    [output setMetadataObjectTypes:self.metadateTypeArray];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    output.rectOfInterest = self.rectOfInterest;
}

/**
 开始扫描
 */
- (void)startRunning{
    if (self.session) {
        [self.session startRunning];
    }
}
/**
 停止扫描
 */
- (void)stopRunning{
    if (self.session) {
        [self.session stopRunning];
    }
}
/**
 点击闪光灯 on 是否打开
 */
- (void)clickFlashAction:(BOOL)on{
    if (!self.session || !self.device) {
        return;
    }
    if (self.device.hasTorch && self.device.hasFlash) {
        [self.session beginConfiguration];
        [self.device  lockForConfiguration:nil];
        if (on) {
            [self.device setTorchMode:AVCaptureTorchModeOn];
            [self.device setFlashMode:AVCaptureFlashModeOn]; 
        }else{
            [self.device setTorchMode:AVCaptureTorchModeOff];
            [self.device setFlashMode:AVCaptureFlashModeOff];
        }
        [self.device unlockForConfiguration];
        [self.session commitConfiguration];
    }
}
/**
 点击选择相册
 */
- (void)clickAlbum:(UIViewController *)viewController {
    if ([UIImagePickerController isSourceTypeAvailable:(UIImagePickerControllerSourceTypePhotoLibrary)]) {
        // 有相册权限
        UIImagePickerController *pickVC = [[UIImagePickerController alloc]  init];
        pickVC.delegate = self;
        pickVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        [viewController presentViewController:pickVC animated:true completion:nil];
    }else{
        // 没有相册权限
    }
}
#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metadataObject = metadataObjects[0];
        if (self.scanBackBlock) {
            self.scanBackBlock(metadataObject.type,metadataObject.stringValue);
        }
    }
}


#pragma mark - imagePickerController delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{

    
    [picker dismissViewControllerAnimated:YES completion:^{
        //1.获取选择的图片
        UIImage *image = info[UIImagePickerControllerOriginalImage];
        //2.初始化一个监测器
        CIDetector*detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
        //监测到的结果数组
        NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
        if (features.count >=1) {
            /**结果对象 */
            CIQRCodeFeature *feature = [features objectAtIndex:0];
           
            if (self.scanBackBlock) {
                self.scanBackBlock(feature.type, feature.messageString);
            }
        }else{
            if (self.scanBackBlock) {
                self.scanBackBlock(nil, nil);
            }
        }
     
    }];
    
    
}

@end
