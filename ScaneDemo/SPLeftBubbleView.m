//
//  SPLeftBubbleView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/12.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPLeftBubbleView.h"
#import "Masonry.h"
#define kPopupTriangleHeigh 6
#define kPopupTriangleWidth 5
#define kPopupTriangleTopPointX 3 * (self.frame.size.width - kPopupTriangleWidth)/ 20.0f
#define kBorderOffset       0//0.5f

@interface SPLeftBubbleView ()

@end

@implementation SPLeftBubbleView

- (instancetype)init
{
    self = [super init];
    if (self) {
        _isRight = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.text = @"测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测试测";
        self.titleLabel.numberOfLines = 0;
        [self addSubview:self.titleLabel];
        [self dealLabelLayout];
    }
    return self;
}

- (void)dealLabelLayout{
    if (self.titleLabel.superview) {
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(self.isRight == NO ? 8 : 4);
            make.top.equalTo(self).offset(4);
            make.width.mas_greaterThanOrEqualTo(0);
            make.height.mas_greaterThanOrEqualTo(0);
            make.right.equalTo(self).offset(self.isRight == YES ? -8 : -4);
            make.bottom.equalTo(self.mas_bottom).offset(-4);
        }];
    }
}

- (void)setIsRight:(BOOL)isRight{
    _isRight = isRight;
   [self dealLabelLayout];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    
    CGFloat strokeWidth = 0.3;
    CGFloat borderRadius = 5;
    CGFloat offset = 0.2 + kBorderOffset;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // 设置填充颜色
    CGContextFillRect(context, rect);
    CGContextSetLineJoin(context, kCGLineJoinRound); //
    CGContextSetLineWidth(context, strokeWidth); // 设置画笔宽度
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 设置画笔颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // 设置填充颜色
    
    CGContextBeginPath(context);
    CGFloat pointY  = 20;
    if (_isRight) {
        
        CGContextMoveToPoint(context, viewW - kPopupTriangleWidth+offset, borderRadius + offset);
        CGContextAddLineToPoint(context,viewW -  kPopupTriangleWidth + offset,  pointY - kPopupTriangleHeigh/ 2  + offset);
        CGContextAddLineToPoint(context, viewW - offset, pointY + offset);
        CGContextAddLineToPoint(context, viewW - kPopupTriangleWidth +offset, pointY + kPopupTriangleHeigh / 2 +offset);
        
        CGContextAddArcToPoint(context, viewW - offset - kPopupTriangleWidth , viewH - offset, viewW - offset - kPopupTriangleWidth - borderRadius, viewH  - offset, borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, offset, viewH - offset, offset, viewH - borderRadius -  offset, borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, offset , offset , borderRadius + offset,offset , borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, viewW - kPopupTriangleWidth - offset ,  offset, viewW - offset - kPopupTriangleWidth, offset + borderRadius, borderRadius-strokeWidth);
        
    }else{
        CGContextMoveToPoint(context, kPopupTriangleWidth+offset, borderRadius + offset);
        CGContextAddLineToPoint(context, kPopupTriangleWidth + offset,  pointY - kPopupTriangleHeigh/ 2  + offset);
        CGContextAddLineToPoint(context, offset, pointY + offset);
        CGContextAddLineToPoint(context, kPopupTriangleWidth +offset, pointY + kPopupTriangleHeigh / 2 +offset);
        
        CGContextAddArcToPoint(context, offset + kPopupTriangleWidth, viewH - offset, offset + kPopupTriangleWidth + borderRadius, viewH  - offset, borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, viewW -offset, viewH - offset, viewW-offset, viewH - borderRadius -  offset, borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, viewW-offset , offset , viewW - borderRadius-offset,offset , borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, offset + kPopupTriangleWidth ,  offset,offset + kPopupTriangleWidth, offset + borderRadius, borderRadius-strokeWidth);
        
    }
 
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
    
//     CGContextStrokePath(context);
}

@end
