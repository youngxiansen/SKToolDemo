//
//  UIImage+SKImage.m
//  二维码
//
//  Created by youngxiansen on 15/9/19.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#define qr_margin 0
#import "UIImage+SKImage.h"
#import "qrencode.h"

@implementation UIImage (SKImage)

+ (void)drawQRCode:(QRcode *)code context:(CGContextRef)ctx size:(CGFloat)size {
    unsigned char *data = 0;
    int width;
    data = code->data;
    width = code->width;
    float zoom = (double)size / (code->width + 2.0 * qr_margin);
    CGRect rectDraw = CGRectMake(0, 0, zoom, zoom);
    
    // draw
    CGContextSetFillColor(ctx, CGColorGetComponents([UIColor blackColor].CGColor));
    for(int i = 0; i < width; ++i) {
        for(int j = 0; j < width; ++j) {
            if(*data & 1) {
                rectDraw.origin = CGPointMake((j + qr_margin) * zoom,(i + qr_margin) * zoom);
                CGContextAddRect(ctx, rectDraw);
            }
            ++data;
        }
    }
    CGContextFillPath(ctx);
}

+ (UIImage *)creatQRCodeWithString:(NSString *)string imageSize:(CGFloat)size {
    if (![string length]) {
        return nil;
    }
    
    QRcode *code = QRcode_encodeString([string UTF8String], 0, QR_ECLEVEL_L, QR_MODE_8, 1);
    if (!code) {
        return nil;
    }
    
    // create context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(0, size, size, 8, size * 4, colorSpace, kCGImageAlphaPremultipliedLast);
    
    CGAffineTransform translateTransform = CGAffineTransformMakeTranslation(0, -size);
    CGAffineTransform scaleTransform = CGAffineTransformMakeScale(1, -1);
    CGContextConcatCTM(ctx, CGAffineTransformConcat(translateTransform, scaleTransform));
    // draw QR on this context
    [self drawQRCode:code context:ctx size:size];
    
    // get image
    CGImageRef qrCGImage = CGBitmapContextCreateImage(ctx);
    UIImage * qrImage = [UIImage imageWithCGImage:qrCGImage];
    
    // some releases
    CGContextRelease(ctx);
    CGImageRelease(qrCGImage);
    CGColorSpaceRelease(colorSpace);
    QRcode_free(code);
    
    return qrImage;
}

/**
 *  二维码的实现是将字符串传递给滤镜,滤镜直接转成二维码图片
 *
 *  @param str <#str description#>
 *
 *  @return <#return value description#>
 */
+(UIImage*)creatQRCodeWithStr:(NSString*)str
{
    
    //1.实例化一个滤镜
    CIFilter* filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    //2设置filter的默认值,如果之前使用过滤镜,输入有可能被保留
    [filter setDefaults];
    
    //3将传入的字符串转成NSData
    NSData* QRCodeData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    //4将NSData传递给滤镜(通过KVC方式),设置inputMessage
    [filter setValue:QRCodeData forKey:@"inputMessage"];
    
    //5由filter输出图像
    CIImage* outputImg = [filter outputImage];
    
    return [UIImage imageWithCIImage:outputImg];
    
}

#pragma mark 可以自由拉伸的图片
+ (UIImage *)resizedImageNamed:(NSString *)imgName
{
    return [self resizedImage:imgName xPos:0.5 yPos:0.5];
}

+ (UIImage *)resizedImage:(NSString *)imgName xPos:(CGFloat)xPos yPos:(CGFloat)yPos
{
    UIImage *image = [UIImage imageNamed:imgName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * xPos topCapHeight:image.size.height * yPos];
}

#pragma mark --屏幕的截图--
/**
 *  返回截图后的图片
 *  @param view 要截取的view
 *  @param name 保存的截图名称
 */
+ (instancetype)screenShotWithView:(UIView *)view name:(NSString*)name
{
    // 1.开启上下文
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, 0.0);
    
    // 2.将控制器view的layer渲染到上下文
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    
    // 3.取出图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 4.结束上下文
    UIGraphicsEndImageContext();
    
    
    // 5.保存图片
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSData *data = UIImagePNGRepresentation(newImage);

        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSArray* urls = [fileManager URLsForDirectory:NSCachesDirectory
                                            inDomains:NSUserDomainMask];
        NSURL* cachesURL =[urls objectAtIndex:0];
        NSString* cachesPath = [cachesURL path];
        
        NSString* str = [NSString stringWithFormat:@"/screenShot/%@.png",name];
        NSString* path = [cachesPath stringByAppendingString:str];
        [data writeToFile:path atomically:YES];
        
    });
    return newImage;
}

+(UIImage*)eeeeeee
{
    CIContext *context = [CIContext contextWithOptions:nil];
//    CIImage *image = [CIImage imageWithContentsOfURL:imageURL];
    CIImage *image = [UIImage imageNamed:@"Map"].CIImage;
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:image forKey:kCIInputImageKey];
    [filter setValue:@2.0f forKey: @"inputRadius"];
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage = [context createCGImage: result fromRect:[result extent]];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    return blurImage;
}
@end
