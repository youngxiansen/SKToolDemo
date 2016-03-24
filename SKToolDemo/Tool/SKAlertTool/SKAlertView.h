//
//  SKAlertView.h
//  BENBENDaiJia
//
//  Created by youngxiansen on 15/11/26.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义的View点击事件
 */
@interface SKAlertView : UIView

-(void)showAlertViewContent:(NSString*)content EnSureBlock:(void(^)())enSureBlock cancleBlock:(void(^)())cancleBlock;
@end
