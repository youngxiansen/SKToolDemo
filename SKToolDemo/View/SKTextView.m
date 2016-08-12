//
//  SKTextView.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/8/2.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKTextView.h"
@interface SKTextView()

@property (strong, nonatomic) UILabel* placeLB;

@end

@implementation SKTextView

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
    _placeLB = [[UILabel alloc]initWithFrame:CGRectMake(4, 5, self.bounds.size.width-20, 20)];
    _placeLB.font = [UIFont systemFontOfSize:14];
    _placeLB.textColor = [UIColor grayColor];
    [self addSubview:_placeLB];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
}

-(void)setPlaceStr:(NSString *)placeStr{
    _placeStr = placeStr;
    _placeLB.text = placeStr;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextViewTextDidChangeNotification object:nil];
}

-(void)textChange{
    if ([self.text isEqualToString:@""]||!self.text) {
        _placeLB.hidden = NO;
    }
    else{
        _placeLB.hidden = YES;
    }
}


@end
