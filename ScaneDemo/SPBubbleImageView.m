//
//  SPBubbleImageView.m
//  ScaneDemo
//
//  Created by okdeer on 2018/6/12.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import "SPBubbleImageView.h"
#import "Masonry.h"
#define kPopupTriangleHeigh 8
#define kPopupTriangleWidth 5
#define kBorderOffset       0//0.5f

@interface SPBubbleImageView()



@end

@implementation SPBubbleImageView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.imageView];
        [self dealImageLayout];
    }
    return self;
}
- (void)dealImageLayout{
    if (self.imageView.superview) {
        [self.imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self).offset(0);
            make.left.equalTo(self).offset(self.isRight ? 0 : kPopupTriangleWidth);
            make.right.equalTo(self).offset(self.isRight ? -kPopupTriangleWidth : 0);
        }];
    }
}
- (void)setIsRight:(BOOL)isRight{
    _isRight  = isRight;
    [self dealImageLayout];
}

-(void)drawRect:(CGRect)rect{
    [super drawRect:rect];
    

    
    CGFloat viewW = rect.size.width;
    CGFloat viewH = rect.size.height;
    
    CGFloat strokeWidth = 0.2;
    CGFloat borderRadius = 5;
    CGFloat offset = 0.2 + kBorderOffset;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextClearRect(context, rect);
    CGContextSetLineJoin(context, kCGLineJoinRound); //
    CGContextSetLineWidth(context, strokeWidth); // 设置画笔宽度
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor); // 设置画笔颜色
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor); // 设置填充颜色
    
    CGContextBeginPath(context);
    
    if (_isRight) {
        CGFloat pointY  = 20;
        CGContextMoveToPoint(context, viewW - kPopupTriangleWidth+offset, borderRadius + offset);
        CGContextAddLineToPoint(context,viewW -  kPopupTriangleWidth + offset,  pointY - kPopupTriangleHeigh/ 2  + offset);
        CGContextAddLineToPoint(context, viewW - offset, pointY + offset);
        CGContextAddLineToPoint(context, viewW - kPopupTriangleWidth +offset, pointY + kPopupTriangleHeigh / 2 +offset);
        CGContextAddArcToPoint(context, viewW - offset - kPopupTriangleWidth , viewH - offset, viewW - offset - kPopupTriangleWidth - borderRadius, viewH  - offset, borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, offset, viewH - offset, offset, viewH - borderRadius -  offset, borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, offset , offset , borderRadius + offset,offset , borderRadius-strokeWidth);
        CGContextAddArcToPoint(context, viewW - kPopupTriangleWidth - offset ,  offset, viewW - offset - kPopupTriangleWidth, offset + borderRadius, borderRadius-strokeWidth);
        
    }else{
        CGFloat pointY  = 20;
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
}
- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.layer.cornerRadius = 5;
        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}



@end
