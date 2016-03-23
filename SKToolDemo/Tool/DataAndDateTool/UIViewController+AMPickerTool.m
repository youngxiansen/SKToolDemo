//
//  UIViewController+AMPickerTool.m
//  AMToolsDemo
//
//  Created by Aimi on 15/8/12.
//  Copyright (c) 2015年 Aimi. All rights reserved.
//

#import "UIViewController+AMPickerTool.h"
#import "AMThreeStepAnimation.h"
#import <objc/runtime.h>

@interface UIViewController()
@property (weak, nonatomic) UIView *blackView;
@end

@implementation UIViewController (AMPickerTool)

#pragma -------- set&get --------
static char AMPickerBlackViewKey;
- (void)setBlackView:(UIView *)blackView {
    [self willChangeValueForKey:@"AMPickerBlackViewKey"];
    
    objc_setAssociatedObject(self, &AMPickerBlackViewKey,
                             blackView,
                             OBJC_ASSOCIATION_ASSIGN);
    [self didChangeValueForKey:@"AMPickerBlackViewKey"];
}

- (UIView *)blackView {
    return objc_getAssociatedObject(self, &AMPickerBlackViewKey);
}


#pragma -------- 弹出数据选择器 --------
-(void)showChoosePickerWithType:(AMChooseColorType)colorType titleStr:(NSString*)title andDataArray:(NSArray *)dataArray andInitPickStr:(NSString *)pickstr andSelectBlock:(void (^)(NSString *, NSInteger))selectBlock{
    UIView * view = [[UIView alloc]initWithFrame:self.view.window.bounds];
    view.backgroundColor = [UIColor colorWithWhite:.1 alpha:.7];
    [self.view.window addSubview:view];
    self.blackView =  view;

    __weak AMPickerChooseView* picker = [AMPickerChooseView choosePickerViewWithType:colorType andDataArray:dataArray andInitPickStr:pickstr];
    picker.titleStr = title;//设置标题
    __weak UIViewController* blockSelf = self;
    [picker setSelectBlock:^(NSString *str, NSInteger row) {
        
        selectBlock(str,row);
        
        [AMThreeStepAnimation threeStepAnimationWithStepOne:^{
            picker.transform = CGAffineTransformMakeScale(1.1, 1.1);
            
        } andStepTwo:^{
            picker.transform = CGAffineTransformMakeScale(.4, .4);
            picker.alpha = .3;
            blockSelf.blackView.alpha = .3;
        } andStepThree:^{
            picker.transform = CGAffineTransformMakeScale(.1, .1);
        } andCompletion:^(BOOL finished) {
            [picker removeFromSuperview];
            [self.blackView removeFromSuperview];
            picker.transform = CGAffineTransformIdentity;
            picker.alpha = 1;
            blockSelf.blackView.alpha = 1;
        } andOneTime:.2 andTwoTime:.2 andThreeTime:.0];
    }];
    
    
    [picker setCannelBlock:^{
        [AMThreeStepAnimation threeStepAnimationWithStepOne:^{
            picker.transform = CGAffineTransformMakeScale(1.1, 1.1);
            
        } andStepTwo:^{
            picker.transform = CGAffineTransformMakeScale(.4, .4);
            picker.alpha = .3;
            self.blackView.alpha = .3;
        } andStepThree:^{
            picker.transform = CGAffineTransformMakeScale(.1, .1);
        } andCompletion:^(BOOL finished) {
            [picker removeFromSuperview];
            [self.blackView removeFromSuperview];
            picker.transform = CGAffineTransformIdentity;
            picker.alpha = 1;
            blockSelf.blackView.alpha = 1;
        } andOneTime:.2 andTwoTime:.2 andThreeTime:.0];
        
    }];
    
    picker.center = self.blackView.center;
    [blockSelf.blackView addSubview:picker];
    
    picker.transform = CGAffineTransformMakeScale(.4, .4);
    [AMThreeStepAnimation threeStepAnimationWithStepOne:^{
        picker.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } andStepTwo:^{
        picker.transform = CGAffineTransformMakeScale(.8, .8);
    } andStepThree:^{
        picker.transform = CGAffineTransformMakeScale(1, 1);
    } andCompletion:^(BOOL finished) {
        
    } andOneTime:.2 andTwoTime:.2 andThreeTime:.2];

}



#pragma -------- 弹出时间选择器 --------
-(void)showDatePickerWithType:(AMDateColorType)colorType andMinimumDate:(NSDate*)minimumDate andMaximumDate:(NSDate*)maximumdate andDatePickerMode:(UIDatePickerMode)datePickerMode andSelectDate:(NSDate*)date andSelectBlock:(void (^)(NSDate* date))selectBlock{
    UIView* view = [[UIView alloc]initWithFrame:self.view.window.bounds];
    view.backgroundColor = [UIColor colorWithWhite:.1 alpha:.7];
    [self.view.window addSubview:view];
    self.blackView = view;
    
    __weak AMDatePickerView* picker = [AMDatePickerView choosePickerViewWithType:colorType andMinimumDate:(NSDate*)minimumDate andMaximumDate:(NSDate*)maximumdate andDatePickerMode:(UIDatePickerMode)datePickerMode andSelectDate:(NSDate*)date];
    
    __weak UIViewController* blockSelf = self;
    
    [picker setSelectBlock:^(NSDate* date) {
        
        selectBlock(date);
        
        [AMThreeStepAnimation threeStepAnimationWithStepOne:^{
            picker.transform = CGAffineTransformMakeScale(1.1, 1.1);
            
        } andStepTwo:^{
            picker.transform = CGAffineTransformMakeScale(.4, .4);
            picker.alpha = .3;
            blockSelf.blackView.alpha = .3;
        } andStepThree:^{
            picker.transform = CGAffineTransformMakeScale(.1, .1);
        } andCompletion:^(BOOL finished) {
            [picker removeFromSuperview];
            [blockSelf.blackView removeFromSuperview];
            picker.transform = CGAffineTransformIdentity;
            picker.alpha = 1;
            blockSelf.blackView.alpha = 1;
        } andOneTime:.2 andTwoTime:.2 andThreeTime:.0];
    }];
    
    
    [picker setCannelBlock:^{
        [AMThreeStepAnimation threeStepAnimationWithStepOne:^{
            picker.transform = CGAffineTransformMakeScale(1.1, 1.1);
            
        } andStepTwo:^{
            picker.transform = CGAffineTransformMakeScale(.4, .4);
            picker.alpha = .3;
            blockSelf.blackView.alpha = .3;
        } andStepThree:^{
            picker.transform = CGAffineTransformMakeScale(.1, .1);
        } andCompletion:^(BOOL finished) {
            [picker removeFromSuperview];
            [self.blackView removeFromSuperview];
            picker.transform = CGAffineTransformIdentity;
            picker.alpha = 1;
            blockSelf.blackView.alpha = 1;
        } andOneTime:.2 andTwoTime:.2 andThreeTime:.0];
        
    }];
    
    picker.center = self.blackView.center;
    [blockSelf.blackView addSubview:picker];
    
    picker.transform = CGAffineTransformMakeScale(.4, .4);
    [AMThreeStepAnimation threeStepAnimationWithStepOne:^{
        picker.transform = CGAffineTransformMakeScale(1.2, 1.2);
    } andStepTwo:^{
        picker.transform = CGAffineTransformMakeScale(.8, .8);
    } andStepThree:^{
        picker.transform = CGAffineTransformMakeScale(1, 1);
    } andCompletion:^(BOOL finished) {
        
    } andOneTime:.2 andTwoTime:.2 andThreeTime:.2];
}

@end
