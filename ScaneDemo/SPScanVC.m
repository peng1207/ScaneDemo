//
//  SPScanVC.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPScanVC.h"
#import "SPScanManager.h"
#import "SPScanePreview.h"


@interface SPScanVC ()
@property (nonatomic,strong) SPScanManager *scanManager;
@property (nonatomic,strong) SPScanePreview *scanePreview;
@end

@implementation SPScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.scanManager startRunning];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.scanManager stopRunning];
}

/**
  创建UI
 */
- (void)setupUI{
    self.scanePreview.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:self.scanePreview];
}
- (SPScanManager *)scanManager{
    if (!_scanManager) {
        _scanManager = [SPScanManager initLayer:(AVCaptureVideoPreviewLayer *)self.scanePreview.layer metadateTypes:@[AVMetadataObjectTypeQRCode] rectOfInterest:CGRectMake(0.2f, 0.2f, 0.8f, 0.8f)];
        __weak typeof(self) weakSelf = self;
        _scanManager.scanBackBlock = ^(NSString *scanCodeType, NSString *result) {
            __weak typeof(self) strongSelf = weakSelf;
            if (strongSelf && strongSelf.scanBackBlock) {
                strongSelf.scanBackBlock(scanCodeType, result);
            }
            [strongSelf dismissViewControllerAnimated:true completion:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
