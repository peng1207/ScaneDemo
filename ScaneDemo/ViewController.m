//
//  ViewController.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "SPScanManager.h"
#import "SPScanePreview.h"

@interface ViewController ()

@property (nonatomic,strong) SPScanManager *scanManager;
@property (nonatomic,strong) SPScanePreview *scanePreview;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.scanePreview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.scanePreview];
    [self.scanManager startRunning];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (SPScanManager *)scanManager{
    if (!_scanManager) {
        _scanManager = [SPScanManager initLayer:(AVCaptureVideoPreviewLayer *)self.scanePreview.layer metadateTypes:@[AVMetadataObjectTypeQRCode] rectOfInterest:CGRectMake(0.2f, 0.2f, 0.8f, 0.8f)];
        _scanManager.scanBackBlock = ^(NSString *scanCodeType, NSString *result) {
            
        };
    }
    return _scanManager;
}
- (SPScanePreview *)scanePreview{
    if (!_scanePreview) {
        _scanePreview = [[SPScanePreview alloc] init];
    }
    return _scanePreview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
