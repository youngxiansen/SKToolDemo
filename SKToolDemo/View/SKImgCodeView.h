//
//  SKImgCodeView.h
//  ImgCodeDemo
//
//  Created by youngxiansen on 16/8/3.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKImgCodeView : UIView

@property (nonatomic, strong) NSArray *changeArray; //字符素材数组
@property (nonatomic, strong) NSMutableString *changeString;  //验证码的字符串

@end
