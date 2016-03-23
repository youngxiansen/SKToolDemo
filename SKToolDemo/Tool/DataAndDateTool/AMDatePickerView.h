//
//  AMDatePickerView.h
//  palmhospital
//
//  Created by Aimi on 15/6/11.
//  Copyright (c) 2015年 joyskim. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AMDateColorType) {
    AMDateColorTypePink   = 1,
    AMDateColorTypeGreen  = 2
};
@interface AMDatePickerView : UIView
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property(nonatomic)AMDateColorType colorType;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@property(nonatomic,strong) void (^selectBlock)(NSDate* date);
@property(nonatomic,strong) void (^cannelBlock)(void);



/**
 *  创建时间选择器控件
 *
 *  @param colorType      颜色类型
 *  @param minimumDate    最小时间
 *  @param maximumdate    最大时间
 *  @param datePickerMode 显示的时间类型
 *  @param date           当前选中的时间
 *
 *  @return 时间选择器控件
 */
+(instancetype)choosePickerViewWithType:(AMDateColorType)colorType andMinimumDate:(NSDate*)minimumDate andMaximumDate:(NSDate*)maximumdate andDatePickerMode:(UIDatePickerMode)datePickerMode andSelectDate:(NSDate*)date;


/**
 *  选择后回调block
 *
 *  @param selectBlock 返回所选择的日期
 */
-(void)setSelectBlock:(void (^)(NSDate* date))selectBlock;


/**
 *  取消选择后回调block
 *
 *  @param cannelBlock 取消选择回调
 */
-(void)setCannelBlock:(void (^)(void))cannelBlock;
@end
