//
//  SPRangGanNumView.h
//  ScaneDemo
//
//  Created by okdeer on 2018/6/20.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SPRangGanNumBlock)(NSArray *listArray);   //  点击回调 listArray 为空时为取消

@interface SPRangGanNumView : UIView

+ (void)showView:(NSString *)title complete:(SPRangGanNumBlock)complete;

@end

@interface SPRangGanNumInputerView : UIView

@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *numLabel;

@end
