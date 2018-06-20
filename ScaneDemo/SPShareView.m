//
//  SPShareView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/20.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPShareView.h"
#import "Masonry.h"
#import "AppDelegate.h"
@interface SPShareView ()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIImageView *qrImageView;
@property (nonatomic,strong) UIButton *share1Btn;
@property (nonatomic,strong) UIButton *share2Btn;

@end

@implementation SPShareView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
/**
 展示view
 */
+ (void)showView{
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    SPShareView *shareView = [[SPShareView alloc] init];
    shareView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    [delegate.window addSubview:shareView];
    [shareView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(delegate.window).offset(0);
    }];
    
}
- (void)setupUI{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.qrImageView];
    [self.contentView addSubview:self.share1Btn];
    [self.contentView addSubview:self.share2Btn];
    [self addConstraintToView]; 
}
-  (void)addConstraintToView{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        if (@available(iOS 11.0, *)) {
            make.bottom.equalTo(self.mas_safeAreaLayoutGuideBottom).offset(0);
        } else {
             make.bottom.equalTo(self.mas_bottom).offset(0);
        }
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.contentView).offset(8);
        make.height.mas_greaterThanOrEqualTo(0);
    }];
    [self.qrImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(150, 150));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(12);
        make.centerX.equalTo(self.contentView.mas_centerX).offset(0);
    }];
    [self.share1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.qrImageView.mas_bottom).offset(12);
        make.width.equalTo(self.share2Btn.mas_width).offset(0);
        make.height.mas_equalTo(40);
    }];
    [self.share2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.share1Btn.mas_right).offset(0);
        make.top.equalTo(self.share1Btn.mas_top).offset(0);
        make.height.equalTo(self.share1Btn.mas_height).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
}
- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"扫一扫下载";
    }
    return _titleLabel;
}
- (UIImageView *)qrImageView{
    if (!_qrImageView) {
        _qrImageView = [[UIImageView alloc] init];
    }
    return _qrImageView;
}
- (UIButton *)share1Btn{
    if (!_share1Btn) {
        _share1Btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_share1Btn setTitle:@"分享到朋友圈" forState:(UIControlStateNormal)];
        _share1Btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_share1Btn setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        [_share1Btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _share1Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [_share1Btn setTitleEdgeInsets:UIEdgeInsetsMake(_share1Btn.imageView.frame.size.height ,-_share1Btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [_share1Btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -_share1Btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }
    return _share1Btn;
}
- (UIButton *)share2Btn{
    if (!_share2Btn) {
        _share2Btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_share2Btn setTitle:@"分享到好友" forState:(UIControlStateNormal)];
        _share2Btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_share2Btn setImage:[UIImage imageNamed:@""] forState:(UIControlStateNormal)];
        [_share2Btn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        _share2Btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;//使图片和文字水平居中显示
        [_share2Btn setTitleEdgeInsets:UIEdgeInsetsMake(_share2Btn.imageView.frame.size.height ,-_share2Btn.imageView.frame.size.width, 0.0,0.0)];//文字距离上边框的距离增加imageView的高度，距离左边框减少imageView的宽度，距离下边框和右边框距离不变
        [_share2Btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, 0.0,0.0, -_share2Btn.titleLabel.bounds.size.width)];//图片距离右边框距离减少图片的宽度，其它不边
    }
    return _share2Btn;
}
@end
