//
//  AMThreeStepAnimation.m
//  MianBaoQ
//
//  Created by AiMi on 15/1/29.
//  Copyright (c) 2015年 HROCloud. All rights reserved.
//

#import "AMThreeStepAnimation.h"

@implementation AMThreeStepAnimation

+(void)threeStepAnimationWithStepOne:(void (^)(void))stepOneBlock andStepTwo:(void (^)(void))stepTwoBlock andStepThree:(void (^)(void))stepThreeBlock andCompletion:(void (^)(BOOL))completion andOneTime:(NSTimeInterval)oneTime andTwoTime:(NSTimeInterval)twoTime andThreeTime:(NSTimeInterval)threeTime{
    [UIView animateWithDuration:oneTime animations:stepOneBlock completion:^(BOOL finished) {
        [UIView animateWithDuration:twoTime animations:stepTwoBlock completion:^(BOOL finished) {
            [UIView animateWithDuration:threeTime animations:stepThreeBlock completion:completion];
        }];
    }];
}


@end
