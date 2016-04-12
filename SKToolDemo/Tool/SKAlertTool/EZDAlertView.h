//
//  EZDAlertView.h
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/31.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

/*
     EZDAlertView* alertView = [[EZDAlertView alloc]init];
     [self.view.window addSubview:alertView];
     
     [alertView showAlertViewContent:@"EZD测试弹框" EnSureBlock:^{
     NSLog(@"确定");
     } cancleBlock:^{
     NSLog(@"取消");
 }];

 */

#import <UIKit/UIKit.h>

@interface EZDAlertView : UIView

-(void)showAlertViewContent:(NSString*)content EnSureBlock:(void(^)())enSureBlock cancleBlock:(void(^)())cancleBlock;

/**
 *  设置这个可以改变确定按钮的文字
 */
@property (copy, nonatomic) NSString* confirmBtnText;
@end
