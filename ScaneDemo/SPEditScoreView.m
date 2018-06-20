
//
//  SPEditScoreView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/20.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPEditScoreView.h"
#import "Masonry.h"
#import "AppDelegate.h"

@interface SPEditScoreView ()
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titlelabel;
@property (nonatomic,strong) UIButton *canceBtn;
@property (nonatomic,strong) UIButton *doneBtn;
@property (nonatomic,strong) UIView *userView;
@property (nonatomic,strong) SPEditScoreUserView *firstView;
@property (nonatomic,strong) SPEditScoreUserView *secondView;
@property (nonatomic,strong) SPEditScoreUserView *thirdView;
@property (nonatomic,strong) SPEditScoreUserView *fourthView;
@end

@implementation SPEditScoreView

- (void)clickCanceAction{
    [self removeFromSuperview];
}
- (void)clickDoneAction{
    [self removeFromSuperview];
}
+ (void)showView{
    SPEditScoreView *view = [[SPEditScoreView alloc] init];
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate.window addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(delegate.window).offset(0);
    }];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)setupUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titlelabel];
    [self.contentView addSubview:self.userView];
    [self.userView addSubview:self.firstView];
    [self.userView addSubview:self.secondView];
    [self.userView addSubview:self.thirdView];
    [self.userView addSubview:self.fourthView];
    [self.contentView addSubview:self.canceBtn];
    [self.contentView addSubview:self.doneBtn];
    [self addConstraintToView];
}
- (void)addConstraintToView{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.centerY.equalTo(self).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.titlelabel.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.firstView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userView.mas_left).offset(6);
        make.top.equalTo(self.userView.mas_top).offset(4);
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.equalTo(self.secondView.mas_width).offset(0);
    }];
    [self.secondView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.firstView.mas_right).offset(12);
        make.top.equalTo(self.firstView.mas_top).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.equalTo(self.thirdView.mas_width).offset(0);
    }];
    [self.thirdView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.secondView.mas_right).offset(12);
        make.top.equalTo(self.secondView.mas_top).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
        make.width.equalTo(self.fourthView.mas_width).offset(0);
    }];
    [self.fourthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.thirdView.mas_right).offset(12);
        make.top.equalTo(self.thirdView.mas_top).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
        make.right.equalTo(self.userView.mas_right).offset(-4);
        make.bottom.equalTo(self.userView.mas_bottom).offset(0);
    }];
    [self.canceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.userView.mas_bottom).offset(8);
        make.width.equalTo(self.doneBtn.mas_width).offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.canceBtn.mas_right).offset(20);
        make.top.equalTo(self.canceBtn.mas_top).offset(0);
        make.height.equalTo(self.canceBtn.mas_height).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
        make.bottom.equalTo(self.contentView).offset(-8);
    }];
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    }
    return _contentView;
}
- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [[UILabel alloc] init];
        _titlelabel.font  = [UIFont systemFontOfSize:14];
        _titlelabel.textColor = [UIColor whiteColor];
        _titlelabel.backgroundColor = [UIColor greenColor];
        _titlelabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titlelabel; 
}
- (UIView *)userView{
    if (!_userView) {
        _userView = [[UIView alloc] init];
        _userView.backgroundColor = [UIColor whiteColor];
    }
    return _userView;
}
-(SPEditScoreUserView *)firstView{
    if (!_firstView) {
        _firstView = [[SPEditScoreUserView alloc] init];
    }
    return _firstView;
}
-(SPEditScoreUserView *)secondView{
    if (!_secondView) {
        _secondView = [[SPEditScoreUserView alloc] init];
    }
    return _secondView;
}
- (SPEditScoreUserView *)thirdView{
    if (!_thirdView) {
        _thirdView = [[SPEditScoreUserView alloc] init];
    }
    return _thirdView;
}
- (SPEditScoreUserView *)fourthView{
    if (!_fourthView) {
        _fourthView = [[SPEditScoreUserView alloc] init];
    }
    return _fourthView;
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

@interface  SPEditScoreUserView ()

@property (nonatomic,strong) UIView *userView;
@property (nonatomic,strong) UIImageView *headerImageView;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *numLabel;
@property (nonatomic,strong) UIView *scoreView;
@property (nonatomic,strong) UIButton *minuBtn;
@property(nonatomic,strong) UIButton *addBtn;
@property (nonatomic,strong) UILabel *scoreLabel;
@end

@implementation SPEditScoreUserView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
- (void)clickMinuAction{
    
}
- (void)clickAddAction{
    
}
-  (void)setupUI{
    [self addSubview:self.userView];
    [self.userView addSubview:self.headerImageView];
    [self.userView addSubview:self.nameLabel];
    [self.userView addSubview:self.numLabel];
    [self addSubview:self.scoreView];
    [self.scoreView addSubview:self.minuBtn];
    [self.scoreView addSubview:self.scoreLabel];
    [self.scoreView addSubview:self.addBtn];
    [self addConstraintToView];
}
-  (void)addConstraintToView{
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self).offset(0);
        make.height.mas_equalTo(120);
    }];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(self.userView.mas_top).offset(4);
        make.centerX.equalTo(self.userView.mas_centerX).offset(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.userView.mas_left).offset(2);
        make.right.equalTo(self.userView.mas_right).offset(-2);
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.equalTo(self.headerImageView.mas_bottom).offset(12);
    }];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(0);
        make.right.equalTo(self.nameLabel.mas_right).offset(0);
        make.bottom.equalTo(self.userView.mas_bottom).offset(-4);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.scoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.top.equalTo(self.userView.mas_bottom).offset(20);
        make.height.mas_greaterThanOrEqualTo(0);
        make.bottom.equalTo(self.mas_bottom).offset(-20);
    }];
    [self.minuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scoreView).offset(0);
        make.top.equalTo(self.scoreView.mas_top).offset(0);
        make.height.mas_equalTo(25);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scoreView).offset(0);
        make.top.equalTo(self.minuBtn.mas_bottom).offset(0);
        make.height.equalTo(self.minuBtn.mas_height).offset(0);
    }];
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.scoreView).offset(0);
        make.top.equalTo(self.scoreLabel.mas_bottom).offset(0);
        make.height.equalTo(self.minuBtn.mas_height).offset(0);
        make.bottom.equalTo(self.scoreView.mas_bottom).offset(0);
    }];
}
- (UIView *)userView{
    if (!_userView) {
        _userView = [[UIView alloc] init];
    }
    return _userView;
}
- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:14];
        _nameLabel.text = @"1";
    }
    return _nameLabel;
}
- (UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textAlignment = NSTextAlignmentCenter;
        _numLabel.font = [UIFont systemFontOfSize:14];
        _numLabel.text = @"1";
    }
    return _numLabel;
}
- (UIView *)scoreView{
    if (!_scoreView) {
        _scoreView = [[UIView alloc] init];
    }
    return _scoreView;
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
-(UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.font = [UIFont systemFontOfSize:14];
    }
    return _scoreLabel;
}
@end
