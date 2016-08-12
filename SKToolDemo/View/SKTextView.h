//
//  SKTextView.h
//  SKToolDemo
//
//  Created by youngxiansen on 16/8/2.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *  继承此TextView实现placeHolder
 */
@interface SKTextView : UITextView

@property (copy, nonatomic) NSString* placeStr;

@end
