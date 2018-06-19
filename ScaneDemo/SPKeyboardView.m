//
//  SPKeyboardView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/15.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPKeyboardView.h"
#import "Masonry.h"
@interface SPKeyboardView ()

@property (nonatomic,strong) UIButton *canceBtn;
@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,copy) SPClickBlock finishBlock;
@property (nonatomic,copy) SPClickBlock canceBlock;
@end

@implementation SPKeyboardView
#pragma mark -- action
/**
 点击取消事件
 */
- (void)clickCanceAction{
    if (_canceBlock) {
        _canceBlock();
    }
}
/**
 点击完成事件
 */
- (void)clickDoneAction{
    if (_finishBlock) {
        _finishBlock();
    }
}
/**
 加载键盘上的最顶部的控件
 
 @param finishBlock 完成
 @param canceBlock 取消
 @return 当前对象
 */
+ (instancetype)initWithFinish:(SPClickBlock)finishBlock cance:(SPClickBlock)canceBlock{
    SPKeyboardView *view = [[SPKeyboardView alloc] init];
    view.finishBlock = finishBlock;
    view.canceBlock =  canceBlock;
    [view setupUI];
    return view;
}
/**
 创建UI
 */
- (void)setupUI{
    [self addSubview:self.canceBtn];
    [self addSubview:self.doneBtn];
}
/**
 添加约束到view
 */
- (void)addConstraintToView{
    [self.canceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(8);
        make.top.bottom.equalTo(self).offset(0);
        make.width.mas_equalTo(80);
    }];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-8);
        make.top.bottom.equalTo(self).offset(0);
        make.width.equalTo(self.canceBtn.mas_width).offset(0);
    }];
}
- (UIButton *)canceBtn{
    if (!_canceBtn) {
        _canceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_canceBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [_canceBtn addTarget:self action:@selector(clickCanceAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _canceBtn;
}
- (UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_doneBtn setTitle:@"完成" forState:(UIControlStateNormal)];
        [_doneBtn addTarget:self action:@selector(clickDoneAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _doneBtn; 
}

@end
