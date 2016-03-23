//
//  UIImage+SKImage.h
//  二维码
//
//  Created by youngxiansen on 15/9/19.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SKImage)

/**
 *  生成清晰的二维码
 *  @param string 纯文本,名片,URL
 */
+ (UIImage *)creatQRCodeWithString:(NSString *)string imageSize:(CGFloat)size;

/**
 *  二维码可以放纯文本,名片,URL
 *  @param str 纯文本,名片,URL
 */
+(UIImage*)creatQRCodeWithStr:(NSString*)str;

/**
 *  可以自由拉伸的图片
 */
+(UIImage *)resizedImageNamed:(NSString *)imgName;

/**
 *  返回截图后的图片
 *  @param view 要截取的view
 *  @param name 保存的截图名称
 */
+ (instancetype)screenShotWithView:(UIView *)view name:(NSString*)name;

+(UIImage*)eeeeeee;

@end
