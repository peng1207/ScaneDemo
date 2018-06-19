//
//  SPKeyboardView.h
//  ScaneDemo
//
//  Created by okdeer on 2018/6/15.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SPClickBlock)(void);

@interface SPKeyboardView : UIView

/**
 加载键盘上的最顶部的控件

 @param finishBlock 完成
 @param canceBlock 取消
 @return 当前对象
 */
+ (instancetype)initWithFinish:(SPClickBlock)finishBlock cance:(SPClickBlock)canceBlock ;

@end
