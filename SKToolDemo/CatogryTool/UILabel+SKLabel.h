//
//  UILabel+SKLabel.h
//  SKAttendanceRecords
//
//  Created by youngxiansen on 15/9/11.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SKLabel)

/**  计算一行Label的宽度 */ 
+(CGFloat)caculateLabelWidth:(UILabel*)label;

/**  计算不确定行Label的高度 默认屏幕宽度-40 */
+(CGFloat)caculateLabelHeight:(UILabel*)label;

/**
 *  返回一个可变的字符串
 *  @param label        传入要改变属性的Label
 *  @param dic          改变的样式
 *  @param attributeStr 哪个字段要改变
 */
+(NSMutableAttributedString*)attributedTextWithLabel:(UILabel*)label attribute:(NSDictionary*)dic attributeStr:(NSString*)attributeStr;

/**
 *  设置Label的行高
 *
 *  @param label 传进去label
 *  @param size  label的字体
 *  @param space 间距
 */
+(NSAttributedString*)setLabelRowHeight:(UILabel*)label andFontSize:(CGFloat)size andLineSpace:(CGFloat)space;


@end
