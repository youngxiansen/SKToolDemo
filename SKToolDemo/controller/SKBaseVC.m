//
//  SKBaseVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKBaseVC.h"

@interface SKBaseVC ()

@end

@implementation SKBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消scrollview的自动像素下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //取消navigationbar导致的view层自动下移
    self.extendedLayoutIncludesOpaqueBars = YES;

}


@end
