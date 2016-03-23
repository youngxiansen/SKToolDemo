//
//  UIViewController+AMPickerTool.h
//  AMToolsDemo
//
//  Created by Aimi on 15/8/12.
//  Copyright (c) 2015年 Aimi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMPickerChooseView.h"
#import "AMDatePickerView.h"

@interface UIViewController (AMPickerTool)

/**
 *  创建数据选择器控件
 *
 *  @param colorType 颜色类型
 *  @param dataArray 选择器中的数据数组 (元素为NSString对象)
 *  @param pickstr   当前选中的数据 (字符串)
 */
-(void)showChoosePickerWithType:(AMChooseColorType)colorType titleStr:(NSString*)title andDataArray:(NSArray *)dataArray andInitPickStr:(NSString *)pickstr andSelectBlock:(void (^)(NSString *, NSInteger))selectBlock;


/**
 *  创建时间选择器控件
 *
 *  @param colorType      颜色类型
 *  @param minimumDate    最小时间
 *  @param maximumdate    最大时间
 *  @param datePickerMode 显示的时间类型
 *  @param date           当前选中的时间
 */
-(void)showDatePickerWithType:(AMDateColorType)colorType andMinimumDate:(NSDate*)minimumDate andMaximumDate:(NSDate*)maximumdate andDatePickerMode:(UIDatePickerMode)datePickerMode andSelectDate:(NSDate*)date andSelectBlock:(void (^)(NSDate* date))selectBlock;




@end
