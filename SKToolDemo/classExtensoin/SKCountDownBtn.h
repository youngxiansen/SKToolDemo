//
//  SKCountDownBtn.h
//  BENBENDaiJia
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

/**
 *  如果碰到按钮的字体变化的时候一闪一闪的,是因为没有把按钮设置成customer
 *
 *  @return <#return value description#>
 */

#import <UIKit/UIKit.h>
/**
 *  倒计时按钮
 */
@interface SKCountDownBtn : UIButton

-(void)startTimer;

/**
 *  最好在viewDisAppear中调用一下
 */
-(void)reSetCountBnt;

@end
