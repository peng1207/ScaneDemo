//
//  SPScanBoxView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPScanBoxView.h"

@interface SPScanBoxView()

@property (nonatomic) NSTimer *timer;
@property (nonatomic,strong) UIView *lineView;

@end

@implementation SPScanBoxView

/**
 开始动画
 */
- (void)startAnimate{
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
}
/**
 结束动画
 */
- (void)stopAnimate{
    if (_timer && [_timer isValid ]) {
        [_timer invalidate];
        _timer = nil;
    }
}
/**
 扫描线移动
 */
- (void)moveUpAndDownLine{
    CGRect lineFrame = self.lineView.frame;
    if (CGRectGetMaxY(self.lineView.frame) > CGRectGetHeight(self.frame)) {
        lineFrame.origin.y = 0;
        self.lineView.frame = lineFrame;
    }else{
        lineFrame.origin.y += 5;
        [UIView animateWithDuration:0.2 animations:^{
            self.lineView.frame = lineFrame;
        }];
    }
}


-  (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        [self addSubview:_lineView];
    }
    return _lineView;
}



@end
