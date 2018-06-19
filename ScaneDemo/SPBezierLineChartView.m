//
//  SPBezierLineChartView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/19.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPBezierLineChartView.h"
#import "Masonry.h"
#import "UIImage+SPExt.h"
#define k_MIN_VALUE     @"-3"
#define K_MAX_VALUE    @"20"

@interface SPBezierLineChartView()

@property (nonatomic,strong) UIButton *oneBtn;
@property (nonatomic,strong) UIButton *twoBtn;
@property (nonatomic,strong) UIButton *threeBtn;
@property (nonatomic,strong) UIButton *fourBtn;
@property (nonatomic,strong) UIButton *fiveBtn;
@property (nonatomic,strong) UIButton *sixBtn;

@property (nonatomic,strong) CAShapeLayer *oneLayer;
@property (nonatomic,strong) CAShapeLayer *twoLayer;
@property (nonatomic,strong) CAShapeLayer *threeLayer;
@property (nonatomic,strong) CAShapeLayer *fourLayer;
@property (nonatomic,strong) CAShapeLayer *fiveLayer;
@property (nonatomic,strong) CAShapeLayer *sixLayer;

@property (nonatomic,assign) BOOL isCreatYValue;

@property (nonatomic,strong) NSArray *xAxisInformationArray;
@property (nonatomic,strong) NSArray *yAxisInformationArray;

@property (nonatomic,assign)CGFloat     axisLineWidth;
@property (nonatomic,assign)CGFloat     axisToViewPadding;
@property (nonatomic,assign)CGFloat     axisPadding;
@property (nonatomic,assign)CGFloat     xAxisSpacing;
@property (nonatomic,assign)CGFloat     yAxisSpacing;
@property (nonatomic,assign)NSInteger   fontSize;
@property (nonatomic,assign) CGFloat   btnHeight;
@end

@implementation SPBezierLineChartView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _axisLineWidth = 1;
        _fontSize = 11;
        _axisToViewPadding = 30;
        _axisPadding = 30;
        _btnHeight = 30;
        self.xAxisInformationArray = @[@"1",@"2",@"3",@"4",@"5"];
        self.yAxisInformationArray = @[k_MIN_VALUE,@"0",@"5",@"10",@"15",K_MAX_VALUE];
        [self setupUI];
    }
    return self;
}
- (void)clickOneAction{
    self.oneBtn.selected = !self.oneBtn.isSelected;
    self.oneLayer.hidden = !self.oneBtn.isSelected;
}
- (void)clickTwoAction{
    self.twoBtn.selected = !self.twoBtn.isSelected;
    self.twoLayer.hidden=  !self.twoBtn.isSelected;
}
- (void)clickThreeAction{
    self.threeBtn.selected = !self.threeBtn.isSelected;
    self.threeLayer.hidden = !self.threeBtn.isSelected;
}
- (void)clickFourAction{
    self.fourBtn.selected = !self.fourBtn.isSelected;
    self.fourLayer.hidden = !self.fourBtn.isSelected;
}
- (void)clickFiveAction{
    self.fiveBtn.selected = !self.fiveBtn.isSelected;
    self.fiveLayer.hidden = !self.fiveBtn.isSelected;
}
- (void)clickSixAction{
    self.sixBtn.selected = !self.sixBtn.isSelected;
    self.sixLayer.hidden = !self.sixBtn.isSelected;
}
/**
 创建UI
 */
- (void)setupUI{
    [self addSubview:self.oneBtn];
    [self addSubview:self.twoBtn];
    [self addSubview:self.threeBtn];
    [self addSubview:self.fourBtn];
    [self addSubview:self.fiveBtn];
    [self addSubview:self.sixBtn];
    [self addConstraintToView];
}
- (void)addConstraintToView{
    [self.oneBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self).offset(0);
        make.height.mas_equalTo(self->_btnHeight);
        make.width.equalTo(self.twoBtn.mas_width).offset(0);
    }];
    [self.twoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.oneBtn.mas_right).offset(0);
        make.top.bottom.equalTo(self.oneBtn).offset(0);
        make.width.equalTo(self.threeBtn.mas_width).offset(0);
    }];
    [self.threeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.twoBtn.mas_right).offset(0);
        make.top.bottom.equalTo(self.oneBtn).offset(0);
        make.width.equalTo(self.fourBtn.mas_width).offset(0);
    }];
    [self.fourBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.threeBtn.mas_right).offset(0);
        make.top.bottom.equalTo(self.oneBtn).offset(0);
        make.width.equalTo(self.fiveBtn.mas_width).offset(0);
    }];
    [self.fiveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fourBtn.mas_right).offset(0);
        make.top.bottom.equalTo(self.oneBtn).offset(0);
        make.width.equalTo(self.sixBtn.mas_width).offset(0);
    }];
    [self.sixBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.fiveBtn.mas_right).offset(0);
        make.top.bottom.equalTo(self.oneBtn).offset(0);
        make.right.equalTo(self).offset(0);
    }];
}

- (void)setFirstArray:(NSArray *)firstArray{
    _firstArray = firstArray;
    [self setNeedsDisplay];
}
- (void)setTwoArray:(NSArray *)twoArray{
    _twoArray = twoArray;
    [self setNeedsDisplay];
}
- (void)setThreeArray:(NSArray *)threeArray{
    _threeArray = threeArray;
    [self setNeedsDisplay];
}
- (void)setFourArray:(NSArray *)fourArray{
    _fourArray = fourArray;
    [self setNeedsDisplay];
}
- (void)setFiveAray:(NSArray *)fiveAray{
    _fiveAray = fiveAray;
    [self setNeedsDisplay];
}
- (void)setSixArray:(NSArray *)sixArray{
    _sixArray = sixArray;
    [self setNeedsDisplay]; 
}

- (void)drawRect:(CGRect)rect{
    _xAxisSpacing = (CGRectGetWidth(self.frame) - _axisToViewPadding - _axisPadding) / _xAxisInformationArray.count;
    _yAxisSpacing = (CGRectGetHeight(self.frame) - _axisToViewPadding - _btnHeight) / _yAxisInformationArray.count;
    [self drawAxisLine];
    [self drawAxisInformation];
    [self drawLayerPath:_firstArray layer:self.oneLayer];
    [self drawLayerPath:_twoArray layer:self.twoLayer];
    [self drawLayerPath:_threeArray layer:self.threeLayer];
    [self drawLayerPath:_fourArray layer:self.fourLayer];
    [self drawLayerPath:_fiveAray layer:self.fiveLayer];
    [self drawLayerPath:_sixArray layer:self.sixLayer];
}
- (void)drawAxisLine{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, _axisLineWidth);
    // yAxis
    CGContextMoveToPoint(context, _axisToViewPadding, 0);
    CGContextAddLineToPoint(context, _axisToViewPadding, CGRectGetHeight(self.frame) - _axisToViewPadding - _btnHeight);
    CGContextStrokePath(context);
    // xAxis
    CGContextMoveToPoint(context, _axisToViewPadding, CGRectGetHeight(self.frame) - _axisToViewPadding - _btnHeight);
    CGContextAddLineToPoint(context, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - _axisToViewPadding - _btnHeight);
    CGContextStrokePath(context);
}
- (void)drawAxisInformation{
    [_xAxisInformationArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 计算文字尺寸
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
        CGSize informationSize = [self getTextSizeWithText:obj fontSize:self->_fontSize maxSize:CGSizeMake(MAXFLOAT, self->_fontSize)];
        // 计算绘制起点
        float drawStartPointX = self->_axisToViewPadding + idx * self->_xAxisSpacing - informationSize.width/2 + 30;
        float drawStartPointY = CGRectGetHeight(self.frame) - self->_axisToViewPadding - self.btnHeight  + (self->_axisToViewPadding - informationSize.height) / 2.0;
        CGPoint drawStartPoint = CGPointMake(drawStartPointX, drawStartPointY);
        // 绘制文字信息
        [obj drawAtPoint:drawStartPoint withAttributes:attributes];
    }];
    
    // y轴
    [_yAxisInformationArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 计算文字尺寸
        UIFont *informationFont = [UIFont systemFontOfSize:self->_fontSize];
        NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
        attributes[NSForegroundColorAttributeName] = [UIColor grayColor];
        attributes[NSFontAttributeName] = informationFont;
        if (!obj) {
            obj = @"";
        }
        CGSize informationSize = [self getTextSizeWithText:obj fontSize:self->_fontSize maxSize:CGSizeMake(MAXFLOAT, self->_fontSize)];
        // 计算绘制起点
        float drawStartPointX = self.axisToViewPadding - informationSize.width - 2;
        float drawStartPointY = CGRectGetHeight(self.frame) - self->_axisToViewPadding - self->_btnHeight - idx * self->_yAxisSpacing - informationSize.height  ;
        CGPoint drawStartPoint = CGPointMake(drawStartPointX, drawStartPointY);
        // 绘制文字信息
        [obj drawAtPoint:drawStartPoint withAttributes:attributes];
    }];
}

- (void)drawLayerPath:(NSArray *)array layer:(CAShapeLayer *)lineLayer{
    if (array.count == 0 ) {
        return ;
    }
    NSMutableArray *pointsArray = [[NSMutableArray alloc] init];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger objInter = 0;
        
        if ([obj respondsToSelector:@selector(integerValue)]) {
            objInter = [obj integerValue];
        }
        if (objInter < k_MIN_VALUE.integerValue) {
            objInter = k_MIN_VALUE.integerValue;
        }
        if (objInter > K_MAX_VALUE.integerValue) {
            objInter = K_MAX_VALUE.integerValue;
        }
        CGPoint point = CGPointMake(self->_xAxisSpacing * idx + self->_axisToViewPadding + 30, CGRectGetHeight(self.frame) - self->_axisToViewPadding - self->_btnHeight -  (objInter  - k_MIN_VALUE.integerValue) /     (CGFloat) (K_MAX_VALUE.integerValue - k_MIN_VALUE.integerValue)   * (CGRectGetHeight(self.frame) - self->_axisToViewPadding - self->_btnHeight ) );
        NSValue *value = [NSValue valueWithCGPoint:CGPointMake(point.x, point.y)];
        [pointsArray addObject:value];
    }];
    NSValue *firstPointValue = [NSValue valueWithCGPoint:CGPointMake(_axisToViewPadding, (CGRectGetHeight(self.frame) - _axisToViewPadding) / 2)];
    [pointsArray insertObject:firstPointValue atIndex:0];
    NSValue *endPointValue = [NSValue valueWithCGPoint:CGPointMake(CGRectGetWidth(self.frame), (CGRectGetHeight(self.frame) - _axisToViewPadding) / 2)];
    [pointsArray addObject:endPointValue];
    /** 折线路径 */
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < array.count -1 ; i++) {
        CGPoint p1 = [[pointsArray objectAtIndex:i] CGPointValue];
        CGPoint p2 = [[pointsArray objectAtIndex:i+1] CGPointValue];
        CGPoint p3 = [[pointsArray objectAtIndex:i+2] CGPointValue];
        CGPoint p4 = [[pointsArray objectAtIndex:i+3] CGPointValue];
        if (i == 0) {
            [path moveToPoint:p2];
        }
        [self getControlPointx0:p1.x andy0:p1.y x1:p2.x andy1:p2.y x2:p3.x andy2:p3.y x3:p4.x andy3:p4.y path:path];
    }
    lineLayer.path = path.CGPath; 
}


- (void)getControlPointx0:(CGFloat)x0 andy0:(CGFloat)y0
                       x1:(CGFloat)x1 andy1:(CGFloat)y1
                       x2:(CGFloat)x2 andy2:(CGFloat)y2
                       x3:(CGFloat)x3 andy3:(CGFloat)y3
                     path:(UIBezierPath*) path{
    CGFloat smooth_value =0.6;
    CGFloat ctrl1_x;
    CGFloat ctrl1_y;
    CGFloat ctrl2_x;
    CGFloat ctrl2_y;
    CGFloat xc1 = (x0 + x1) /2.0;
    CGFloat yc1 = (y0 + y1) /2.0;
    CGFloat xc2 = (x1 + x2) /2.0;
    CGFloat yc2 = (y1 + y2) /2.0;
    CGFloat xc3 = (x2 + x3) /2.0;
    CGFloat yc3 = (y2 + y3) /2.0;
    CGFloat len1 = sqrt((x1-x0) * (x1-x0) + (y1-y0) * (y1-y0));
    CGFloat len2 = sqrt((x2-x1) * (x2-x1) + (y2-y1) * (y2-y1));
    CGFloat len3 = sqrt((x3-x2) * (x3-x2) + (y3-y2) * (y3-y2));
    CGFloat k1 = len1 / (len1 + len2);
    CGFloat k2 = len2 / (len2 + len3);
    CGFloat xm1 = xc1 + (xc2 - xc1) * k1;
    CGFloat ym1 = yc1 + (yc2 - yc1) * k1;
    CGFloat xm2 = xc2 + (xc3 - xc2) * k2;
    CGFloat ym2 = yc2 + (yc3 - yc2) * k2;
    ctrl1_x = xm1 + (xc2 - xm1) * smooth_value + x1 - xm1;
    ctrl1_y = ym1 + (yc2 - ym1) * smooth_value + y1 - ym1;
    ctrl2_x = xm2 + (xc2 - xm2) * smooth_value + x2 - xm2;
    ctrl2_y = ym2 + (yc2 - ym2) * smooth_value + y2 - ym2;
    [path addCurveToPoint:CGPointMake(x2, y2) controlPoint1:CGPointMake(ctrl1_x, ctrl1_y) controlPoint2:CGPointMake(ctrl2_x, ctrl2_y)];
}


- (CGSize)getTextSizeWithText:(NSString *)text fontSize:(CGFloat)fontSize maxSize:(CGSize)maxSize{
    CGSize size = CGSizeZero;
    if(text.length > 0){
        size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]} context:nil].size;
    }
    return CGSizeMake(ceilf(size.width), ceilf(size.height));
}

- (CAShapeLayer *)oneLayer{
    if (!_oneLayer) {
        _oneLayer = [self setupLayer:[UIColor redColor]];
        [self.layer addSublayer:_oneLayer];
    }
    return _oneLayer;
}
- (CAShapeLayer *)twoLayer{
    if (!_twoLayer) {
        _twoLayer  = [self setupLayer:[UIColor blueColor]];
        [self.layer addSublayer:_twoLayer];
    }
    return _twoLayer;
}
- (CAShapeLayer *)threeLayer{
    if (!_threeLayer) {
        _threeLayer = [self setupLayer:[UIColor yellowColor]];
        [self.layer addSublayer:_threeLayer];
    }
    return _threeLayer;
}
- (CAShapeLayer *)fourLayer{
    if (!_fourLayer) {
        _fourLayer = [self setupLayer:[UIColor orangeColor]];
        [self.layer addSublayer:_fourLayer];
    }
    return _fourLayer;
}
- (CAShapeLayer *)fiveLayer{
    if (!_fiveLayer) {
        _fiveLayer = [self setupLayer:[UIColor greenColor]];
        [self.layer addSublayer:_fiveLayer];
    }
    return _fiveLayer;
}
- (CAShapeLayer *)sixLayer{
    if (!_sixLayer) {
        _sixLayer = [self setupLayer:[UIColor purpleColor]];
        [self.layer addSublayer:_sixLayer];
    }
    return _sixLayer;
}
/**
 创建layer

 @param color 颜色
 @return layer
 */
- (CAShapeLayer *)setupLayer:(UIColor *)color{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.strokeColor = color.CGColor;
    layer.fillColor = [[UIColor clearColor] CGColor];
    // 默认设置路径宽度为0，使其在起始状态下不显示
    layer.lineWidth = 1.5;
    layer.lineCap = kCALineCapRound;
    layer.lineJoin = kCALineJoinRound;
    return layer;
}

- (UIButton *)oneBtn{
    if (!_oneBtn) {
        _oneBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_oneBtn setTitle:@"one" forState:(UIControlStateNormal)];
        [_oneBtn setImage:[UIImage createImageWithColor:[UIColor redColor] size:CGSizeMake(20, 15)] forState:(UIControlStateNormal)];
        [_oneBtn  setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_oneBtn addTarget:self action:@selector(clickOneAction) forControlEvents:(UIControlEventTouchUpInside)];
        _oneBtn.selected = YES;
    }
    return _oneBtn;
}
- (UIButton *)twoBtn{
    if (!_twoBtn) {
        _twoBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_twoBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_twoBtn setTitle:@"two" forState:(UIControlStateNormal)];
        [_twoBtn setImage:[UIImage createImageWithColor:[UIColor blueColor] size:CGSizeMake(20, 15)] forState:(UIControlStateNormal)];
        [_twoBtn addTarget:self action:@selector(clickTwoAction) forControlEvents:(UIControlEventTouchUpInside)];
        _twoBtn.selected = YES;
    }
    return _twoBtn;
}
- (UIButton *)threeBtn{
    if (!_threeBtn) {
        _threeBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_threeBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_threeBtn setTitle:@"three" forState:(UIControlStateNormal)];
        [_threeBtn setImage:[UIImage createImageWithColor:[UIColor yellowColor] size:CGSizeMake(20, 15)] forState:(UIControlStateNormal)];
        [_threeBtn addTarget:self action:@selector(clickThreeAction) forControlEvents:(UIControlEventTouchUpInside)];
        _threeBtn.selected = YES;
    }
    return _threeBtn;
}
- (UIButton *)fourBtn{
    if (!_fourBtn) {
        _fourBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_fourBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_fourBtn setTitle:@"four" forState:(UIControlStateNormal)];
        [_fourBtn setImage:[UIImage createImageWithColor:[UIColor orangeColor] size:CGSizeMake(20, 15)] forState:(UIControlStateNormal)];
        [_fourBtn addTarget:self action:@selector(clickFourAction) forControlEvents:(UIControlEventTouchUpInside)];
        _fourBtn.selected = YES;
    }
    return _fourBtn;
}
- (UIButton *)fiveBtn{
    if (!_fiveBtn) {
        _fiveBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_fiveBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_fiveBtn setTitle:@"five" forState:(UIControlStateNormal)];
        [_fiveBtn setImage:[UIImage createImageWithColor:[UIColor greenColor] size:CGSizeMake(20, 15)] forState:(UIControlStateNormal)];
        [_fiveBtn addTarget:self action:@selector(clickFiveAction) forControlEvents:(UIControlEventTouchUpInside)];
        _fiveBtn.selected = YES;
    }
    return _fiveBtn;
}
- (UIButton *)sixBtn{
    if (!_sixBtn) {
        _sixBtn  = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_sixBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [_sixBtn setTitle:@"six" forState:(UIControlStateNormal)];
        [_sixBtn setImage:[UIImage createImageWithColor:[UIColor purpleColor] size:CGSizeMake(20, 15)] forState:(UIControlStateNormal)];
        [_sixBtn addTarget:self action:@selector(clickSixAction) forControlEvents:(UIControlEventTouchUpInside)];
        _sixBtn.selected = YES; 
    }
    return _sixBtn;
}
@end
