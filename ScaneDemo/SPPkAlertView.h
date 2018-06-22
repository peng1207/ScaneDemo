//
//  SPPkAlertView.h
//  ScaneDemo
//
//  Created by okdeer on 2018/6/22.
//  Copyright © 2018年 okdeer. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SPTableViewSelectBlock)(NSIndexPath *indexPath);

@interface SPPkAlertView : UIView

/**
 展示view

 @param title 标题
 @param dataArray 数据
 @param complete 回调
 */
+ (void)showViewForTitle:(NSString *)title dataArray:(NSArray *)dataArray complete:(SPTableViewSelectBlock)complete;

@end
