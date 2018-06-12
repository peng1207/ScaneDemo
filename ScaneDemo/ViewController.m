//
//  ViewController.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "SPScanVC.h"
#import "Masonry.h"
#import "SPLeftBubbleView.h"
#import "SPBubbleImageView.h"
@interface ViewController ()

@property (nonatomic,strong) SPLeftBubbleView *dubbleView;
@property (nonatomic,strong) SPBubbleImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor orangeColor];
//    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
//    btn.frame = CGRectMake(0, 0, 100, 100);
//    btn.center = self.view.center;
//    [btn setTitle:@"扫描二维码" forState:(UIControlStateNormal)];
//    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
//    [btn addTarget:self action:@selector(clickScanAction) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:btn];
    
    self.dubbleView  = [[SPLeftBubbleView alloc] init];
    
    [self.view addSubview:self.dubbleView];
    [self.dubbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(40);
        make.width.mas_greaterThanOrEqualTo(0);
        make.right.mas_lessThanOrEqualTo(-20);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    self.imageView = [[SPBubbleImageView alloc] init];
    self.imageView.imageView.image = [UIImage imageNamed:@"image1"];
    [self.view addSubview:self.imageView];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dubbleView.mas_bottom).offset(10);
        make.size.mas_equalTo(CGSizeMake(205, 200));
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
    }];
    
 
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.dubbleView.isRight = NO;
        self.imageView.isRight = YES;
        [self.dubbleView setNeedsDisplay];
         [self.imageView setNeedsDisplay];
    });
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)clickScanAction {
    SPScanVC *scanVC = [[SPScanVC alloc] init];
    scanVC.scanBackBlock = ^(NSString *scanCodeType, NSString *result) {
        NSLog(@"scanCodeType:%@-----result:%@",scanCodeType,result); 
    };
    [self presentViewController:scanVC animated:true completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
