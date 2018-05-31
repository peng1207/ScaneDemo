//
//  SPScanVC.h
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//
//  扫描主界面

#import <UIKit/UIKit.h>
#import "SPSaneHead.h"

@interface SPScanVC : UIViewController

@property (nonatomic,copy) ScanBackBlock scanBackBlock;    // 获取数据回调


@end
