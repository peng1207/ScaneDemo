
//
//  SPPkAlertView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/22.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPPkAlertView.h"
#import "Masonry.h"
#import "AppDelegate.h"
#define K_TABLE_ROW     40

@interface SPPkAlertView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UIView *lineView;
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,copy) SPTableViewSelectBlock selectBlock;
@end

@implementation SPPkAlertView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataArray.count ? 1 : 0 ;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"SPPkAlertViewCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:cellID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *selectBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        selectBtn.backgroundColor = [UIColor redColor];
        selectBtn.tag = 100;
        [cell.contentView addSubview:selectBtn];
        [selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(20, 20));
            make.centerY.equalTo(cell.contentView).offset(0);
            make.right.equalTo(cell.contentView.mas_right).offset(-20);
        }];
        
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor grayColor];
        [cell.contentView addSubview:lineView];
        lineView.tag = 101;
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(cell.contentView).offset(0);
            make.height.mas_equalTo(1);
        }];
        
    }
    if (indexPath.row < self.dataArray.count    ) {
        cell.textLabel.text = [self.dataArray objectAtIndex:indexPath.row];
        UIView *lineView = [cell.contentView viewWithTag:101];
        if (indexPath.row == self.dataArray.count - 1) {
            lineView.hidden = YES;
        }else{
            lineView.hidden = NO;
        }
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.dataArray.count) {
        if (_selectBlock) {
            _selectBlock(indexPath);
        }
    }
}
- (void)setDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self.tableView reloadData];
    [self updateTableViewLayout];
}

/**
 展示view
 
 @param title 标题
 @param dataArray 数据
 @param complete 回调
 */
+ (void)showViewForTitle:(NSString *)title dataArray:(NSArray *)dataArray complete:(SPTableViewSelectBlock)complete{
    SPPkAlertView *alertView = [[SPPkAlertView alloc] init];
    alertView.dataArray = dataArray;
    alertView.titleLabel.text = title;
    alertView.selectBlock = complete;
    alertView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window addSubview:alertView];
    [alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(appDelegate.window).offset(0);
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
    [self.contentView addSubview:self.lineView];
    [self.contentView addSubview:self.tableView];
    [self addConstraintToView];
}

/**
 更新tableview 的约束
 */
- (void)updateTableViewLayout{
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(0 );
        make.height.mas_equalTo(K_TABLE_ROW * self.dataArray.count) ;
        make.bottom.equalTo(self.contentView).offset(0);
    }];
}

- (void)addConstraintToView{
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.right.equalTo(self.mas_right).offset(-20);
        make.height.mas_greaterThanOrEqualTo(0);
        make.centerY.equalTo(self.mas_centerY).offset(0);
        make.bottom.mas_lessThanOrEqualTo(self.mas_bottom).offset(-20);
        make.top.mas_greaterThanOrEqualTo(self.mas_top).offset(20);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(12);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.height.mas_equalTo(40);
        make.right.equalTo(self.contentView.mas_right).offset(-12);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(1);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView).offset(0);
        make.top.equalTo(self.lineView.mas_bottom).offset(0 );
        make.height.mas_equalTo(0);
        make.bottom.equalTo(self.contentView).offset(0);
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
        _titleLabel.font = [UIFont systemFontOfSize:16];
    }
    return _titleLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor blueColor];
    }
    return _lineView;
}
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.rowHeight = K_TABLE_ROW;
        _tableView.bounces = NO;
    }
    return _tableView;
}

@end
