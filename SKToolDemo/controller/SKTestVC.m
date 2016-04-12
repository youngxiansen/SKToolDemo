//
//  SKTestVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/4/6.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKTestVC.h"
#import "UIImage+SKImage.h"
@interface SKTestVC()

@end
@implementation SKTestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    [self creatQRImg];
    
}

-(void)creatQRImg
{
    UIImageView* imgv = [[UIImageView alloc]init];
    imgv.center = self.view.center;
    imgv.bounds = CGRectMake(0, 0, 150, 150);
    [self.view addSubview:imgv];
    
    NSString* str = @"You constraint me, I dote you, This is my promise to you.\n你管着我,我惯着你,这就是我对你的承诺!\n                              大楚to亚楠";
    UIImage* qrImg = [UIImage creatQRCodeWithString:str imageSize:150];
    imgv.image = qrImg;

}
@end
