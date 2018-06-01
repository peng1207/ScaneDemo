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
#import "Masonry.h"
#import "SPScanBoxView.h"

@interface SPScanVC ()
@property (nonatomic,strong) SPScanManager *scanManager;
@property (nonatomic,strong) SPScanePreview *scanePreview;
@property (nonatomic,strong) SPScanBoxView *boxView;
@property (nonatomic,strong) UIView *topView;
@property (nonatomic,strong) UIView *leftView;
@property (nonatomic,strong) UIView *rightView;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIButton *flashBtn;
@property (nonatomic,strong) UIButton *albumBtn;
@property (nonatomic,strong) UIButton *backBtn;

@end

@implementation SPScanVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self start];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self stop];
}

#pragma mark -- ation
/**
 开始
 */
- (void)start{
      [self.scanManager startRunning];
    [self.boxView startAnimate];
}
/**
 结束
 */
- (void)stop{
    [self.scanManager stopRunning];
    [self.scanManager clickFlashAction:NO];
    [self.boxView stopAnimate];
}
/**
 点击闪光灯
 */
- (void)clickFlashAction{
    self.flashBtn.selected = !self.flashBtn.isSelected;
    [self.scanManager clickFlashAction:self.flashBtn.isSelected];
}
/**
 点击相册
 */
- (void)clickAlbumAction {
    [self.scanManager clickAlbum:self];
}
/**
 点击返回按钮
 */
- (void)clickBackAction{
    [self dismissViewControllerAnimated:true completion:nil];
}
#pragma mark -- UI
/**
  创建UI
 */
- (void)setupUI{
    [self.view addSubview:self.scanePreview];
    [self.view addSubview:self.boxView];
    [self.view addSubview:self.topView];
    [self.view addSubview:self.leftView];
    [self.view addSubview:self.rightView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.flashBtn];
    [self.view addSubview:self.albumBtn];
    [self.view addSubview:self.backBtn];
    [self addConstraintToView];
}
/**
    添加约束
 */
- (void)addConstraintToView{
    [self.scanePreview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view).offset(0);
    }];
    [self.boxView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view).offset(0);
        make.width.equalTo(self.scanePreview.mas_width).multipliedBy(0.6);
        make.height.equalTo(self.boxView.mas_width).offset(0);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view).offset(0);
        make.bottom.equalTo(self.boxView.mas_top).offset(0);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(0);
        make.top.bottom.equalTo(self.boxView).offset(0);
        make.right.equalTo(self.boxView.mas_left).offset(0);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(0);
        make.top.bottom.equalTo(self.boxView).offset(0);
        make.left.equalTo(self.boxView.mas_right).offset(0);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.boxView.mas_bottom).offset(0);
        make.left.right.bottom.equalTo(self.view).offset(0);
    }];
    [self.flashBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(0);
        } else {
            make.bottom.equalTo(self.view.mas_bottom).offset(-20);
        }
        make.size.mas_equalTo(CGSizeMake(60, 40));
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(0.5);
    }];
    [self.albumBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.flashBtn.mas_bottom).offset(0);
        make.width.equalTo(self.flashBtn.mas_width).offset(0);
        make.height.equalTo(self.flashBtn.mas_height).offset(0);
        make.centerX.equalTo(self.view.mas_centerX).multipliedBy(1.5);
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(12);
        make.top.equalTo(self.view).offset(CGRectGetHeight( [[UIApplication sharedApplication] statusBarFrame]));
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
}

#pragma mark -- 懒加载
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
- (SPScanBoxView *)boxView{
    if (!_boxView) {
        _boxView = [[SPScanBoxView alloc] init];
        _boxView.layer.borderColor = [[UIColor redColor] colorWithAlphaComponent:0.5].CGColor;
        _boxView.layer.borderWidth = 1;
    }
    return _boxView;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [self setupView];
    }
    return _topView;
}
- (UIView *)leftView{
    if (!_leftView) {
        _leftView = [self setupView];
    }
    return _leftView;
}
- (UIView *)rightView{
    if (!_rightView) {
        _rightView = [self setupView];
    }
    return _rightView;
}
- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [self setupView];
    }
    return _bottomView;
}
/**
 创建View
 */
- (UIView *)setupView{
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    return view;
}
- (UIButton *)flashBtn{
    if (!_flashBtn) {
        _flashBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_flashBtn setTitle:@"闪光的" forState:(UIControlStateNormal)];
        [_flashBtn addTarget:self action:@selector(clickFlashAction) forControlEvents:(UIControlEventTouchUpInside)];
        
    }
    return _flashBtn;
}
- (UIButton *)albumBtn{
    if (!_albumBtn) {
        _albumBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_albumBtn setTitle:@"相册" forState:(UIControlStateNormal)];
        [_albumBtn addTarget:self action:@selector(clickAlbumAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _albumBtn;
}
- (UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_backBtn  setTitle:@"返回" forState:(UIControlStateNormal)];
        [_backBtn addTarget:self action:@selector(clickBackAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backBtn;
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
