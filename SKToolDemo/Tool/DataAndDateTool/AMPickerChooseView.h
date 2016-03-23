//
//  AMPickerChooseView.h
//  palmhospital
//
//  Created by Aimi on 15/6/11.
//  Copyright (c) 2015年 joyskim. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, AMChooseColorType) {
    AMChooseColorTypePink   = 1,
    AMChooseColorTypeGreen  =2,
    AMChooseColorTypeBenBen = 3,
};
@interface AMPickerChooseView : UIView <UIPickerViewDataSource,UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;
@property (weak, nonatomic) IBOutlet UILabel *titleLB;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property(nonatomic)AMChooseColorType colorType;
@property(nonatomic)NSArray* dataArray;
@property(nonatomic,strong)NSString* pickStr;
@property(nonatomic)NSInteger row;
@property (copy, nonatomic) NSString* titleStr;



@property(nonatomic,strong) void (^selectBlock)(NSString* str,NSInteger row);
@property(nonatomic,strong) void (^cannelBlock)(void);


/**
 *  创建数据选择器控件
 *
 *  @param colorType 颜色类型
 *  @param dataArray 选择器中的数据数组 (元素为NSString对象)
 *  @param pickstr   当前选中的数据 (字符串)
 *
 *  @return 数据选择器控件
 */
+(instancetype)choosePickerViewWithType:(AMChooseColorType)colorType andDataArray:(NSArray*)dataArray andInitPickStr:(NSString*)pickstr;

/**
 *  选中回调
 *
 *  @param selectBlock 选中的字符串及在数据数组中的下表
 */
-(void)setSelectBlock:(void (^)(NSString* str, NSInteger row))selectBlock;


/**
 *  取消回调
 *
 *  @param cannelBlock 点击取消后的回调
 */
-(void)setCannelBlock:(void (^)(void))cannelBlock;

@end
