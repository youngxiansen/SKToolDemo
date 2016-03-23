//
//  AMPickerChooseView.m
//  palmhospital
//
//  Created by Aimi on 15/6/11.
//  Copyright (c) 2015年 joyskim. All rights reserved.
//

#import "AMPickerChooseView.h"
#import "AMThreeStepAnimation.h"
@implementation AMPickerChooseView 

-(instancetype)init{
    self = [[[NSBundle mainBundle]loadNibNamed:@"AMPickerChooseView" owner:self options:nil]lastObject];
    if (self) {
        [self initialize];
    }
    return self;
}

+(instancetype)choosePickerViewWithType:(AMChooseColorType)colorType andDataArray:(NSArray*)dataArray andInitPickStr:(NSString*)pickstr{
    AMPickerChooseView* chooseView = [[AMPickerChooseView alloc]init];
    chooseView.colorType = colorType;
    chooseView.dataArray = dataArray;
    chooseView.pickStr = pickstr;
    return chooseView;
}

-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titleLB.text = _titleStr;
}

-(void)initialize{
    self.layer.cornerRadius = 5.0;
    self.layer.masksToBounds = YES;
    
    self.cannelBtn.layer.cornerRadius = 3.0;
    self.cannelBtn.layer.borderWidth = 1;
    
    self.commitBtn.layer.cornerRadius = 3.0;
    self.commitBtn.layer.borderWidth = 1;
    
    self.pickerView.delegate = self;
}

-(void)setPickStr:(NSString *)pickStr{
    _pickStr = pickStr;
    for (int i =0; i<self.dataArray.count; i++) {
        NSString* tmpStr = self.dataArray[i];
        if ([pickStr isEqualToString:tmpStr]) {
            self.row = i;
            [self.pickerView selectRow:i inComponent:0 animated:NO];
        }
    }
}

-(void)setColorType:(AMChooseColorType)colorType{
    _colorType = colorType;
    switch (colorType) {
        case AMChooseColorTypePink:
            self.cannelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            self.commitBtn.layer.borderColor = [UIColor colorWithRed:252.0/255 green:111.0/255 blue:143.0/255 alpha:1.0].CGColor;
            break;
            
        case AMChooseColorTypeGreen:
            self.cannelBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
            [self.commitBtn setTitleColor:[UIColor colorWithRed:6.0/255 green:157.0/255 blue:71.0/255 alpha:1.0] forState:UIControlStateNormal];
            self.commitBtn.layer.borderColor = [UIColor colorWithRed:6.0/255 green:157.0/255 blue:71.0/255 alpha:1.0].CGColor;
            self.titleLB.backgroundColor =[UIColor colorWithRed:6.0/255 green:157.0/255 blue:71.0/255 alpha:1.0];
            break;
        case AMChooseColorTypeBenBen:
            self.cannelBtn.layer.borderColor = [UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0].CGColor;
            [self.cannelBtn setTitleColor:[UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1.0] forState:UIControlStateNormal];
            
            [self.commitBtn setTitleColor:[UIColor colorWithRed:95.0/255 green:201.0/255 blue:243.0/255 alpha:1.0] forState:UIControlStateNormal];
            self.commitBtn.layer.borderColor = [UIColor colorWithRed:95.0/255 green:201.0/255 blue:243.0/255 alpha:1.0].CGColor;
            self.titleLB.backgroundColor =[UIColor colorWithRed:95.0/255 green:201.0/255 blue:243.0/255 alpha:1.0];
            break;

            
        default:
            break;
    }
}


-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    self.pickStr = self.dataArray[row];
    self.row = row;
}


- (IBAction)tapCommitBtn:(id)sender {
    if (self.selectBlock) {
        self.selectBlock(self.pickStr,self.row);
    }
}

- (IBAction)tapCannelBtn:(id)sender {
    if (self.cannelBlock) {
        self.cannelBlock();
    }
}


@end
