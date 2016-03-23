//
//  UILabel+SKLabel.m
//  SKAttendanceRecords
//
//  Created by youngxiansen on 15/9/11.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import "UILabel+SKLabel.h"

@implementation UILabel (SKLabel)

/**  计算一行Label的宽度 */
+(CGFloat)caculateLabelWidth:(UILabel*)label
{
    if ([label.text isEqualToString:@""] || !label.text) {
        return 0;
    }
    CGRect rectOfText=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 999);
    rectOfText=[label textRectForBounds:rectOfText limitedToNumberOfLines:1];
    return rectOfText.size.width;
}

/**  计算不确定行Label的高度 默认屏幕宽度-40 */
+(CGFloat)caculateLabelHeight:(UILabel*)label
{
    if ([label.text isEqualToString:@""] || !label.text) {
        return 20;
    }
    CGRect rectOfText=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 9999999);
    rectOfText=[label textRectForBounds:rectOfText limitedToNumberOfLines:0];
    return rectOfText.size.height+20;
}

/**
 *  返回一个可变的字符串
 *  @param label        传入要改变属性的Label
 *  @param dic          改变的样式
 *  @param attributeStr 哪个字段要改变
 */
+(NSMutableAttributedString*)attributedTextWithLabel:(UILabel*)label attribute:(NSDictionary*)dic attributeStr:(NSString*)attributeStr
{
    //修改的属性
//    NSDictionary* ddd = @{NSForegroundColorAttributeName:[UIColor whiteColor],
//                          NSFontAttributeName:[UIFont systemFontOfSize:14]};
    
    
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithAttributedString:label.attributedText];
    
    if (!attributeStr || [attributeStr isEqualToString:@""]) {
        return attributedText;
    }
    [attributedText setAttributes:dic range:[label.text rangeOfString:attributeStr]];
    return attributedText;
}

/**
 *  设置Label的行高
 *
 *  @param label 传进去label
 *  @param size  label的字体
 *  @param space 间距
 */
+(NSAttributedString*)setLabelRowHeight:(UILabel*)label andFontSize:(CGFloat)size andLineSpace:(CGFloat)space
{
    if (label.text == nil || [label.text isEqualToString:@""])
    {
        NSLog(@"------label属性字符串为空-----");
        return nil;
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineSpacing = space;
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:size], NSParagraphStyleAttributeName:paragraphStyle};
    label.attributedText = [[NSAttributedString alloc]initWithString:label.text attributes:attributes];
    return label.attributedText;
}





@end
