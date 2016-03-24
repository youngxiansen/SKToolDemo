//
//  SKAMapSearchVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/24.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKAMapSearchVC.h"

@interface SKAMapSearchVC ()

@end

@implementation SKAMapSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.mapTool searchPoiByKeyword:@"饭店" SearchType:SKSearchTypeNearby searchArray:^(NSArray *amapPoiArray) {
        NSLog(@"-----%@",amapPoiArray);
    }];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.mapTool stopGetLocation];
    
    self.mapTool.mapView.showsUserLocation = NO;
}



@end
