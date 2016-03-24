//
//  SKClassExtensionVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/24.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKClassExtensionVC.h"
#import "SKCountDownBtn.h"
#import "SKClickEffectBtn.h"
@interface SKClassExtensionVC ()
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation SKClassExtensionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"类扩展";
}

- (IBAction)clickBtn:(UIButton *)sender {
    
    self.title = @"按钮测试";
}


@end
