//
//  UIColor+SKColor.m
//  BENBENDaiJia
//
//  Created by youngxiansen on 15/11/25.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import "UIColor+SKColor.h"

@implementation UIColor (SKColor)

/**
 *  直接填写数字就行(如200)
 */
+(UIColor*)skColorWithRed:(CGFloat)r andGreen:(CGFloat)g andBlack:(CGFloat)b andAlpha:(CGFloat)a{
    return [UIColor colorWithRed:r*1.0/255 green:g*1.0/255 blue:b*1.0/255 alpha:a*1.0];
}

/**
 *  传字符串Hex
 */
+ (UIColor *) skColorWithHexString: (NSString *)stringToConvert
{
    NSString *string = stringToConvert;
    if ([string hasPrefix:@"#"])
        string = [string substringFromIndex:1];
    
    NSScanner *scanner = [NSScanner scannerWithString:string];
    unsigned hexNum;
    if (![scanner scanHexInt: &hexNum]) return nil;
    return [UIColor skColorWithRGBHex:hexNum];
}

/**
 * 传6位二进制
 */
+ (UIColor *) skColorWithRGBHex: (UInt32)hex
{
    int a = (hex >> 24) & 0xFF; a = a? a:255;
    int r = (hex >> 16) & 0xFF;
    int g = (hex >> 8) & 0xFF;
    int b = (hex) & 0xFF;
    
    return [UIColor colorWithRed:r / 255.0f
                           green:g / 255.0f
                            blue:b / 255.0f
                           alpha:a / 255.0f];
}

@end
