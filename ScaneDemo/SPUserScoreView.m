
//
//  SPUserScoreView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/21.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPUserScoreView.h"
#import "Masonry.h"

#define K_SCORE_WIDTH     100
#define K_SCORE_RIGHT      8
@interface SPUserScoreView ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *totalLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) SPUserScoreContentView *contentView;
@end

@implementation SPUserScoreView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
        self.nameLabel.text = @"p";
        self.scoreLabel.text = @"600";
        self.contentView.listArray = @[@"",@"",@""];
    }
    return self;
}
/**
 创建UI
 */
- (void)setupUI{
    [self addSubview:self.nameLabel];
    [self addSubview:self.lineView];
    [self addSubview:self.contentView];
    [self addSubview:self.totalLabel];
    [self addSubview:self.scoreLabel];
    [self addConstraintToView];
}
/**
 添加约束
 */
- (void)addConstraintToView{
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(4);
        make.top.equalTo(self).offset(0);
        make.right.equalTo(self.mas_right).offset(-4);
        make.height.mas_equalTo(40);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(0);
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.height.mas_greaterThanOrEqualTo(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(0);
    }];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left).offset(0);
        make.top.equalTo(self.contentView.mas_bottom).offset(10);
        make.height.mas_greaterThanOrEqualTo(0);
        make.bottom.equalTo(self.mas_bottom).offset(-8);
        make.right.equalTo(self.scoreLabel.mas_left).offset(-1);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-K_SCORE_RIGHT);
        make.top.equalTo(self.totalLabel.mas_top).offset(0);
        make.width.mas_equalTo(K_SCORE_WIDTH);
        make.height.equalTo(self.totalLabel.mas_height).offset(0);
    }];
}
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font  = [UIFont systemFontOfSize:16];
    }
    return _nameLabel;
}
- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel  = [[UILabel alloc] init];
        _totalLabel.font = [UIFont systemFontOfSize:16];
        _totalLabel.text = @"总计:";
        _totalLabel.textAlignment = NSTextAlignmentRight;
    }
    return _totalLabel;
}
- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = [UIFont systemFontOfSize:16];
    }
    return _scoreLabel;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}
- (SPUserScoreContentView *)contentView{
    if (!_contentView) {
        _contentView = [[SPUserScoreContentView alloc] init];
    }
    return _contentView;
}
@end
@interface SPUserScoreContentView()
@property (nonatomic,strong) UILabel *titlaLabel;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) UILabel *totalLabel;
@property (nonatomic,strong) UIView *lineView;
@end

@implementation SPUserScoreContentView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI]; 
    }
    return self;
}
- (void)setListArray:(NSArray *)listArray{
    _listArray = listArray;
    if (_listArray.count > 0) {
        [self.lineView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self).offset(0);
            make.top.equalTo(self.titlaLabel.mas_bottom).offset(0);
            make.height.mas_equalTo(1);
        }];
        [self setupSubView];
    }
}
- (void)setupSubView{
    UIView *tempView = nil;
    for (NSInteger i = 0; i < _listArray.count; i++ ) {
        SPUserScoreItemView *itemView = [[SPUserScoreItemView alloc] init];
        [self addSubview:itemView];
        
        [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tempView) {
                make.top.equalTo(tempView.mas_bottom).offset(0);
            }else{
                make.top.equalTo(self.lineView.mas_bottom).offset(0);
            }
            make.left.right.equalTo(self).offset(0);
            make.height.mas_equalTo(40);
            if (i == self->_listArray.count - 1) {
                make.bottom.equalTo(self.mas_bottom).offset(0);
            }
        }];
          tempView = itemView;
    }
}

- (void)setupUI{
    [self addSubview:self.titlaLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.totalLabel];
    [self addSubview:self.lineView];
    [self addConstraintToView];
}
- (void)addConstraintToView{
    [self.titlaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.left.equalTo(self.mas_left).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_greaterThanOrEqualTo(0);
        make.right.mas_lessThanOrEqualTo(self.totalLabel.mas_left).offset(-4);
    }];
    [self.totalLabel setContentHuggingPriority:(UILayoutPriorityDefaultHigh) forAxis:(UILayoutConstraintAxisHorizontal)];
    [self.totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titlaLabel.mas_top).offset(0);
        make.height.equalTo(self.titlaLabel.mas_height).offset(0);
        make.width.mas_greaterThanOrEqualTo(0);
        make.right.equalTo(self.scoreLabel.mas_left).offset(-1);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-K_SCORE_RIGHT);
        make.top.equalTo(self.titlaLabel.mas_top).offset(0);
        make.height.equalTo(self.titlaLabel.mas_height).offset(0);
        make.width.mas_equalTo(K_SCORE_WIDTH);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(0);
        make.top.equalTo(self.titlaLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
        make.bottom.equalTo(self).offset(0);
    }];
}
- (UILabel *)titlaLabel{
    if (!_titlaLabel) {
        _titlaLabel = [[UILabel alloc] init];
        _titlaLabel.font  = [UIFont systemFontOfSize:16];
        _titlaLabel.text = @"比洞";
    }
    return _titlaLabel;
}
- (UILabel *)totalLabel{
    if (!_totalLabel) {
        _totalLabel = [[UILabel alloc] init];
        _totalLabel.font = [UIFont systemFontOfSize:16];
        _totalLabel.text = @"合计:";
    }
    return _totalLabel;
}
- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font  = [UIFont systemFontOfSize:16];
        _scoreLabel.text = @"600";
    }
    return _scoreLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}

@end

@interface SPUserScoreItemView ()

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) UIView *lineView;
@end
@implementation SPUserScoreItemView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}
/**
 创建UI
 */
- (void)setupUI{
    [self addSubview:self.titleLabel];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.lineView];
    [self addConstraintToView];
}
/**
 添加约束
 */
- (void)addConstraintToView{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(40);
        make.top.bottom.equalTo(self).offset(0);
        make.right.equalTo(self.scoreLabel.mas_left).offset(-8);
    }];
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self).offset(0);
        make.right.equalTo(self.mas_right).offset(-K_SCORE_RIGHT);
        make.width.mas_equalTo(K_SCORE_WIDTH);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(1);
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.text = @"1";
    }
    return _titleLabel;
}
- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font  = [UIFont systemFontOfSize:16];
        _scoreLabel.text = @"600";
    }
    return _scoreLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blackColor];
    }
    return _lineView;
}
@end
