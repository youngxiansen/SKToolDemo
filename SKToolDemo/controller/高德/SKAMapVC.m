//
//  SKAMapVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKAMapVC.h"
//#import <MAMapKit/MAMapKit.h>
@interface SKAMapVC ()
@property (strong, nonatomic) MAMapView* mapView;
@end

@implementation SKAMapVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"地图展示";
    self.view.backgroundColor = [UIColor whiteColor];
//    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
//    [self.view addSubview:_mapView];


    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.mapTool.mapView.frame = self.view.bounds;
    
    [self.view addSubview:self.mapTool.mapView];
    
    
    [self.mapTool startGetLocationSuccess:^(LocationModel *locationModel) {
        NSLog(@"-----%@----%@---",locationModel.detailAddress,locationModel.city);
        
    } Failure:^(NSString *errorInfo) {
        
    }];
//
//    KKLogFrame(self.mapTool.mapView);

}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    self.mapTool.mapView.showsUserLocation = NO;
}



@end
