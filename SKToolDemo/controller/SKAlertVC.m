//
//  SKAlertVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKAlertVC.h"
#import "SKAlertView.h"
@interface SKAlertVC ()

@end

@implementation SKAlertVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    


    [self addBtn];
}

-(void)addBtn
{
    UIButton* btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.center = CGPointMake(self.view.center.x, self.view.center.y-44);
    btn1.bounds = CGRectMake(0, 0, 200, 44);
    [btn1 setTitle:@"自定义提示框" forState:UIControlStateNormal];
    btn1.backgroundColor = [UIColor lightGrayColor];
    [btn1 addTarget:self action:@selector(showAlertView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.center = self.view.center;
    btn.bounds = CGRectMake(0, 0, 200, 44);
    [btn setTitle:@"封装系统点击事件1" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor lightGrayColor];
    [btn addTarget:self action:@selector(showAlertView1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton* btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.center = CGPointMake(self.view.center.x, self.view.center.y+44);
    btn2.bounds = CGRectMake(0, 0, 200, 44);
    [btn2 setTitle:@"封装系统点击事件2" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor lightGrayColor];
    [btn2 addTarget:self action:@selector(showAlertView2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];

}

-(void)showAlertView
{
    SKAlertView* alertView = [[SKAlertView alloc]init];
    [self.view.window addSubview:alertView];
    
    [alertView showAlertViewContent:@"自定义文字" EnSureBlock:^{
        KKLogNSSting(@"确定");
    } cancleBlock:^{
        KKLogNSSting(@"取消");
    }];

}

-(void)showAlertView1
{
    [self showAlertVCContent:@"只有确定点击事件" enSureBlock:^{
        KKLogNSSting(@"点击了确定");
    }];
}

-(void)showAlertView2
{
    [self showAlertVCContent:@"有确定和取消点击事件" cancleBlock:^{
        KKLogNSSting(@"点击了取消");
    } enSureBlock:^{
        KKLogNSSting(@"点击了确定");
    }];
}

@end
