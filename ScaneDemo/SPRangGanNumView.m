//
//  SPRangGanNumView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/20.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPRangGanNumView.h"
#import "Masonry.h"
#import "AppDelegate.h"
@interface SPRangGanNumView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *numView;
@property (nonatomic,strong) UIButton *canceBtn;
@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,strong) SPRangGanNumInputerView *threeView;
@property (nonatomic,strong) SPRangGanNumInputerView *fourView;
@property (nonatomic,strong) SPRangGanNumInputerView *fiveView;
@property (nonatomic,copy) SPRangGanNumBlock complete;
@end

@implementation SPRangGanNumView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI]; 
    }
    return self;
}
+ (void)showView:(NSString *)title complete:(SPRangGanNumBlock)complete{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    SPRangGanNumView *view = [[SPRangGanNumView alloc] init];
    view.titleLabel.text = title;
    view.complete = complete;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [delegate.window addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(delegate.window).offset(0);
    }];
}
- (void)clickCanceAction{
    if (_complete) {
        _complete(nil);
    }
    [self removeFromSuperview];
}
- (void)clickDoneAction{
    if (_complete) {
        NSMutableArray *list = [[NSMutableArray alloc] init];
        [list addObject: self.threeView.numLabel.text];
        [list addObject:self.fourView. numLabel.text];
        [list addObject:self.fiveView.numLabel.text];
        _complete(list);
    }
    [self removeFromSuperview];
}
- (void)setupUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.numView];
    [self.numView addSubview:self.threeView];
    [self.numView addSubview:self.fourView];
    [self.numView addSubview:self.fiveView];
    [self.contentView addSubview:self.canceBtn];
    [self.contentView addSubview:self.doneBtn];
    [self addConstraintToView];
}
- (void)addConstraintToView{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.threeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.numView).offset(0);
        make.top.equalTo(self.numView.mas_top).offset(10);
        make.height.mas_equalTo(40);
    }];
    [self.fourView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.threeView).offset(0);
        make.height.equalTo(self.threeView.mas_height).offset(0);
        make.top.equalTo(self.threeView.mas_bottom).offset(0);
    }];
    [self.fiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.fourView).offset(0);
        make.top.equalTo(self.fourView.mas_bottom).offset(0);
        make.height.equalTo(self.fourView.mas_height).offset(0);
        make.bottom.equalTo(self.numView.mas_bottom).offset(-10);
    }];
    [self.canceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.top.equalTo(self.numView.mas_bottom).offset(8);
        make.height.mas_equalTo(40);
        make.width.equalTo(self.doneBtn.mas_width).offset(0);
    }];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.canceBtn.mas_right).offset(20);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.top.equalTo(self.canceBtn.mas_top).offset(0);
        make.height.equalTo(self.canceBtn.mas_height).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-8);
    }];
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    }
    return _contentView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor greenColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIView *)numView{
    if (!_numView) {
        _numView = [[UIView alloc] init];
        _numView.backgroundColor = [UIColor whiteColor];
    }
    return _numView;
}
- (SPRangGanNumInputerView *)threeView{
    if (!_threeView) {
        _threeView = [[SPRangGanNumInputerView alloc] init];
        _threeView.titleLabel.text = @"3杆洞";
    }
    return _threeView;
}
- (SPRangGanNumInputerView *)fourView{
    if (!_fourView) {
        _fourView = [[SPRangGanNumInputerView alloc] init];
        _fourView.titleLabel.text = @"4杆洞";
    }
    return _fourView;
}
- (SPRangGanNumInputerView *)fiveView{
    if (!_fiveView) {
        _fiveView = [[SPRangGanNumInputerView alloc] init];
        _fiveView.titleLabel.text = @"5杆洞";
    }
    return _fiveView;
}
- (UIButton *)canceBtn{
    if (!_canceBtn) {
        _canceBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_canceBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        _canceBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_canceBtn addTarget:self action:@selector(clickCanceAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _canceBtn;
}
- (UIButton *)doneBtn{
    if (!_doneBtn) {
        _doneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_doneBtn setTitle:@"确定" forState:(UIControlStateNormal)];
        _doneBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_doneBtn addTarget:self action:@selector(clickDoneAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _doneBtn;
}
@end

@interface  SPRangGanNumInputerView()

@property (nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UIButton *minuBtn;

@end

@implementation SPRangGanNumInputerView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)clickAddAction{
    CGFloat num = self.numLabel.text.floatValue;
    num = num + 0.5;
    self.numLabel.text = [NSString stringWithFormat:@"%.1f",num];
}
- (void)clickMinuAction{
    CGFloat num = self.numLabel.text.floatValue;
    num = num - 0.5;
    if (num <= 0) {
        self.numLabel.text = @"0";
    }else{
         self.numLabel.text = [NSString stringWithFormat:@"%.1f",num];
    }
}

- (void)setupUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.addBtn];
    [self addSubview:self.minuBtn];
    [self addSubview:self.numLabel];
    [self addConstraintToView ];
}
- (void)addConstraintToView{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0);
        make.top.bottom.equalTo(self).offset(0);
        make.right.equalTo(self.minuBtn.mas_left).offset(-8);
    }];
    [self.minuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 30));
        make.centerY.equalTo(self).offset(0);
        make.right.equalTo(self.numLabel.mas_left).offset(-8);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(self.minuBtn.mas_height).offset(0);
        make.centerY.equalTo(self.minuBtn.mas_centerY).offset(0);
        make.width.mas_equalTo(80);
        make.right.equalTo(self.addBtn.mas_left).offset(-8);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.width.equalTo(self.minuBtn.mas_width).offset(0);
        make.height.equalTo(self.minuBtn.mas_height).offset(0);
        make.right.equalTo(self.mas_right).offset(-8);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentRight;
    }
    return _titleLabel;
}
- (UIButton *)addBtn{
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_addBtn setTitle:@"+" forState:(UIControlStateNormal)];
        _addBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_addBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(clickAddAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}
- (UIButton *)minuBtn{
    if (!_minuBtn) {
        _minuBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_minuBtn setTitle:@"-" forState:(UIControlStateNormal)];
        _minuBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [_minuBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_minuBtn addTarget:self action:@selector(clickMinuAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _minuBtn;
}
- (UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.text = @"0";
        _numLabel.font = [UIFont systemFontOfSize:16];
        _numLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _numLabel;
}
@end
