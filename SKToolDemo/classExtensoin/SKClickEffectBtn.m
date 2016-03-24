//
//  SKClickEffectBtn.m
//  BENBENDaiJia
//
//  Created by youngxiansen on 15/12/19.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import "SKClickEffectBtn.h"

@implementation SKClickEffectBtn

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
    
    [self setBackgroundImage:[UIImage imageNamed:@"choose"] forState:UIControlStateHighlighted];
}

@end
