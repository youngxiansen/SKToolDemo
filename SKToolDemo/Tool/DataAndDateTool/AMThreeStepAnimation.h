//
//  AMThreeStepAnimation.h
//  MianBaoQ
//
//  Created by AiMi on 15/1/29.
//  Copyright (c) 2015年 HROCloud. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface AMThreeStepAnimation : NSObject
@property(nonatomic,strong) void (^stepOneBlock)(void);
@property(nonatomic,strong) void (^stepTwoBlock)(void);
@property(nonatomic,strong) void (^stepThreeBlock)(void);

+(void)threeStepAnimationWithStepOne:(void (^)(void))stepOneBlock andStepTwo:(void (^)(void))stepTwoBlock andStepThree:(void (^)(void))stepThreeBlock andCompletion:(void (^)(BOOL finished))completion andOneTime:(NSTimeInterval)oneTime andTwoTime:(NSTimeInterval)twoTime andThreeTime:(NSTimeInterval)threeTime;
@end
