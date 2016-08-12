//
//  Util.h
//  iOS-UIWebView-Cache
//
//  Created by 雷亮 on 16/7/25.
//  Copyright © 2016年 Leiliang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (NSString *)sha1:(NSString *)str;

+ (NSString *)md5Hash:(NSString *)str;

@end
