//
//  ViewController.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "ViewController.h"
#import "SPScanVC.h"

@interface ViewController ()


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    btn.frame = CGRectMake(0, 0, 100, 100);
    btn.center = self.view.center;
    [btn setTitle:@"扫描二维码" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(clickScanAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:btn];
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
