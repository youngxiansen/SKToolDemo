//
//  SKCountDownBtn.m
//  BENBENDaiJia
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKCountDownBtn.h"

@interface SKCountDownBtn()
{
    NSTimer* _timer;
    NSInteger _second;
}
@end

@implementation SKCountDownBtn

-(instancetype)init{
    self = [super init];
    if (self) {
        [self initialze];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initialze];
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialze];
    }
    return self;
}

-(void)initialze{
    
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    [self setTitleColor:[UIColor colorWithRed:95.0/255 green:201.0/255 blue:243.0/255 alpha:1] forState:UIControlStateNormal];
    self.backgroundColor = [UIColor whiteColor];
    
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    _second = 60;
}

-(void)countNumberDown
{
    _second--;
    NSLog(@"------%ld",_second);
    if (_second == 0) {
        
        [_timer invalidate];
        _timer = nil;
        _second = 60;
        [self setTitle:@"重新获取" forState:UIControlStateNormal];
        self.userInteractionEnabled = YES;
        return;
    }
    
    [self setTitle:[NSString stringWithFormat:@"已发送(%ld) S",_second] forState:UIControlStateNormal];
}

-(void)startTimer{
    self.userInteractionEnabled = NO;
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countNumberDown) userInfo:nil repeats:YES];
}

-(void)reSetCountBnt
{
    [_timer invalidate];
    _timer = nil;
    _second = 60;
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.userInteractionEnabled = YES;
}
@end
