//
//  UIColor+SKColor.h
//  BENBENDaiJia
//
//  Created by youngxiansen on 15/11/25.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (SKColor)

/**
 *  直接填写数字就行(如200)
 */
+(UIColor*)skColorWithRed:(CGFloat)r andGreen:(CGFloat)g andBlack:(CGFloat)b andAlpha:(CGFloat)a;

/**
 *  传字符串Hex
 */
+ (UIColor *) skColorWithHexString: (NSString *)stringToConvert;

/**
 * 传6位二进制
 */
+ (UIColor *) skColorWithRGBHex: (UInt32)hex;

@end
