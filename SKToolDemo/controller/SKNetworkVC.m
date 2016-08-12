//
//  SKNetworkVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKNetworkVC.h"
#import "SKHTTPSessionManager.h"

@interface SKNetworkVC ()

@end

@implementation SKNetworkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib
}


- (IBAction)clickNetworkBtn:(UIButton *)sender {
    
    NSDictionary* dic = @{@"mobile":@"13056988912"};
    
    [SKHTTPSessionManager postProgressWithInterface:[NSString stringWithFormat:@"%@/%@",kBaseUrl,kGetCode] params:dic success:^(NSURLSessionDataTask *operation, id responseObject) {
        if ([self isSuccessReturnData:responseObject]) {
    
                [self showSuccessAlertWithTitleStr:@"已发送"];
        }

    } failed:^(NSURLSessionDataTask *operation, NSError *error) {
        
    }];
    
    [self postProgressWithInterface:kGetCode params:dic Success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        if ([self isSuccessReturnData:responseObject]) {
            
            [self showSuccessAlertWithTitleStr:@"已发送"];

        }
        else
        {
//            [self showAlertVCContentWithoutEvent:responseObject[@"msg"]];
        }
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}

@end
