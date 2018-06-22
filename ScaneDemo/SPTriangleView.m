//
//  SPTriangleView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/22.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPTriangleView.h"
#define kBorderOffset       0//0.5f
@implementation SPTriangleView

- (void)drawRect:(CGRect)rect{
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
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor); // 设置填充颜色
    
    CGContextBeginPath(context);
    
    CGContextMoveToPoint(context, 0, viewH);
    CGContextAddLineToPoint(context, viewW / 2.0f, 0);
    CGContextAddLineToPoint(context, viewW, viewH);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathFillStroke);
}

@end
