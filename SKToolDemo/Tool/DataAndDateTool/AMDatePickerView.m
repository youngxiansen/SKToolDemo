//
//  AMDatePickerView.m
//  palmhospital
//
//  Created by Aimi on 15/6/11.
//  Copyright (c) 2015年 joyskim. All rights reserved.
//

#import "AMDatePickerView.h"

@implementation AMDatePickerView

-(instancetype)init{
    self = [[[NSBundle mainBundle]loadNibNamed:@"AMDatePickerView" owner:self options:nil]lastObject];
    if (self) {
        [self initialize];
    }
    return self;
}

-(void)willMoveToWindow:(UIWindow *)newWindow{
    self.datePicker.frame = CGRectMake(0, 44, 280, 190);
}

-(void)layoutSubviews{
    self.datePicker.frame = CGRectMake(0, 44, 280, 190);
}
+(instancetype)choosePickerViewWithType:(AMDateColorType)colorType andMinimumDate:(NSDate*)minimumDate andMaximumDate:(NSDate*)maximumdate andDatePickerMode:(UIDatePickerMode)datePickerMode andSelectDate:(NSDate*)date{
    AMDatePickerView* dateView = [[AMDatePickerView alloc]init];
    dateView.colorType = colorType;
    dateView.datePicker.minimumDate = minimumDate;
    dateView.datePicker.maximumDate = maximumdate;
    dateView.datePicker.datePickerMode = datePickerMode;
    dateView.datePicker.date = date;
    return dateView;
}

-(void)initialize{
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    
    self.cannelBtn.layer.cornerRadius = 3.0;
    self.cannelBtn.layer.borderWidth = 1;
    
    self.commitBtn.layer.cornerRadius = 3.0;
    self.commitBtn.layer.borderWidth = 1;
}

-(void)setColorType:(AMDateColorType)colorType{
    _colorType = colorType;
    switch (colorType) {
        case AMDateColorTypePink:
            self.cannelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.commitBtn.layer.borderColor = [UIColor colorWithRed:252.0/255 green:111.0/255 blue:143.0/255 alpha:1.0].CGColor;
            break;
            
        case AMDateColorTypeGreen:
            self.cannelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [self.commitBtn setTitleColor:[UIColor colorWithRed:6.0/255 green:157.0/255 blue:71.0/255 alpha:1.0] forState:UIControlStateNormal];
            self.commitBtn.layer.borderColor = [UIColor colorWithRed:6.0/255 green:157.0/255 blue:71.0/255 alpha:1.0].CGColor;
            self.titleLB.backgroundColor =[UIColor colorWithRed:6.0/255 green:157.0/255 blue:71.0/255 alpha:1.0];
            break;
            
        default:
            break;
    }
}

- (IBAction)tapCommitBtn:(id)sender {
    if (self.selectBlock) {
        self.selectBlock(self.datePicker.date);
    }
}

- (IBAction)tapCannelBtn:(id)sender {
    if (self.cannelBlock) {
        self.cannelBlock();
    }
}

@end
