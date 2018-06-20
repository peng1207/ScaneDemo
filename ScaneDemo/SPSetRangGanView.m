//
//  SPSetRangGanView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/20.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPSetRangGanView.h"
#import "Masonry.h"
#import "AppDelegate.h"
@interface SPSetRangGanView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIPickerView *pickerView;
@property (nonatomic,strong) UIView *pickerContentView;
@property (nonatomic,strong) UIButton *canceBtn;
@property (nonatomic,strong) UIButton *doneBtn;
@end

@implementation SPSetRangGanView
- (void)clickCanceAction{
    [self removeFromSuperview];
}
- (void)clickDoneAction{
      [self removeFromSuperview];
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 4;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (0 == component) {
        return self.userArray.count;
    }else if (1 == component){
        return 1;
    }else if (2 == component){
        return self.userArray.count - 1;
    }else{
        return 1;
    }
  
}
//返回指定列，行的高度，就是自定义行的高度

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 40.f;
}
//被选择的
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    if (0 == component || 2 == component) {
        //设置分割线的颜色
        for(UIView *singleLine in pickerView.subviews)
        {
            if (singleLine.frame.size.height < 1)
            {
                singleLine.backgroundColor = [UIColor redColor];
            }
        }
        //设置文字的属性
        UILabel *genderLabel = [UILabel new];
        genderLabel.textAlignment = NSTextAlignmentCenter;
        genderLabel.text = @"1";
        genderLabel.textColor = [UIColor blackColor];
          return genderLabel;
    }else if (1  == component){
        //设置文字的属性
        UILabel *genderLabel = [UILabel new];
        genderLabel.textAlignment = NSTextAlignmentCenter;
        genderLabel.text = @"对";
        genderLabel.textColor = [UIColor blackColor];
        return genderLabel;
    }else{
 
        //设置文字的属性
        UILabel *genderLabel = [UILabel new];
        genderLabel.textAlignment = NSTextAlignmentCenter;
        genderLabel.text = @"让杆";
        genderLabel.textColor = [UIColor blackColor];
        return genderLabel;
    }
    

    
  
 
}

+ (void)showViewForUserArray:(NSArray *)userArray{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
 
    SPSetRangGanView *view = [[SPSetRangGanView alloc] init];
    view.userArray  = userArray;
    view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.pickerContentView];
    [self.pickerContentView addSubview:self.pickerView];
    [self.contentView addSubview:self.canceBtn];
    [self.contentView addSubview:self.doneBtn];
    [self addConstraintToView];
}
-(void)addConstraintToView{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.centerY.equalTo(self).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView).offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.pickerContentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(162);
    }];
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.pickerContentView.mas_width).multipliedBy(0.5);
        make.centerX.equalTo(self.pickerContentView.mas_centerX).offset(0);
        make.top.bottom.equalTo(self.pickerContentView).offset(0);
    }];
    [self.canceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(12);
        make.top.equalTo(self.pickerContentView.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
        make.width.equalTo(self.doneBtn.mas_width).offset(0);
    }];
    [self.doneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.canceBtn.mas_right).offset(20);
        make.top.equalTo(self.canceBtn.mas_top).offset(0);
        make.height.equalTo(self.canceBtn.mas_height).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
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
        _titleLabel.textColor = [UIColor whiteColor];
    }
    return _titleLabel;
}
- (UIView *)pickerContentView{
    if (!_pickerContentView) {
        _pickerContentView = [[UIView alloc] init];
        _pickerContentView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerContentView;
}
- (UIPickerView *)pickerView{
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
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
