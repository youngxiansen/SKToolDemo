//
//  SKCatogyVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKCatogyVC.h"
#import "UILabel+SKLabel.h"
@interface SKCatogyVC ()
@property (weak, nonatomic) IBOutlet UITextField *textTF;
@property (weak, nonatomic) IBOutlet UILabel *testLB;

@end

@implementation SKCatogyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"分类测试";
    [self testLBHeight];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
   
//
//     NSParameterAssert(_textTF.text);
}

-(void)testLBHeight
{
    NSString* str = @"本文首发在 CSDN《程序员》杂志，订阅地址 http://dingyue.programmer.com.cn/。Apple 在推出 Swift 时就将其冠以先进，安全和高效的新一代编程语言之名。前两点在 Swift 的语法和语言特性中已经表现得淋漓尽致：像是尾随闭包，枚举关联值，可选值和强制的类型安全等都是 Swift 显而易见的优点。但是对于高效一点，就没有那么明显了。在 2014 年 WWDC 大会上 Apple 宣称 Swift 具有超越 Objective-C 的性能，甚至某些情";
    _testLB.text = str;
//    _testLB.font = [UIFont systemFontOfSize:17];
    CGFloat height = [UILabel caculateLabelHeight:_testLB];
    
    CGRect frame = _testLB.frame;
    frame.size.height = height;
    _testLB.frame = frame;
    _testLB.backgroundColor = [UIColor redColor];
    _testLB.numberOfLines = 0;
    KKLogFrame(_testLB);
    
}



@end
