//
//  SPScanBoxView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/5/31.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPScanBoxView.h"
#import "Masonry.h"
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
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(moveUpAndDownLine) userInfo:nil repeats:YES];
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
        lineFrame.origin.y += 10;
        [UIView animateWithDuration:0.1 animations:^{
            self.lineView.frame = lineFrame;
        }];
    }
}

-  (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:0.4];
        [self addSubview:_lineView];
        [self addConstraintForLineView];
    }
    return _lineView;
}
/**
 添加分割线约束
 */
- (void)addConstraintForLineView{
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(1);
    }];
}

@end
