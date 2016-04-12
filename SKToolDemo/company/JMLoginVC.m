//
//  JMLoginVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/4/12.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//
#define kLoginBtnEnableColor [UIColor redColor]
#define kLoginBtnUnableColor [UIColor lightGrayColor]


#import "JMLoginVC.h"

@interface JMLoginVC ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;

@end

@implementation JMLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initBaseInfo];
}

-(void)initBaseInfo
{
    self.navigationItem.title = @"登陆";
    
    _loginBtn.backgroundColor = kLoginBtnUnableColor;
    _agreeBtn.selected = YES;
    _agreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    // 设置按钮的内边距
    _agreeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    _protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 设置按钮的内边距
    _protocolBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    
    
    [_phoneTF addTarget:self action:@selector(changeLoginBtnColor) forControlEvents:UIControlEventEditingChanged];
    [_passwordTF addTarget:self action:@selector(changeLoginBtnColor) forControlEvents:UIControlEventEditingChanged];
    [_agreeBtn addTarget:self action:@selector(changeLoginBtnColor) forControlEvents:UIControlEventTouchUpInside];
}

-(void)changeLoginBtnColor
{
    
    //密码长度必须大于6位
    if ([self isValidateMobileString:_phoneTF.text]&&![self isNilOrEmptyString:_passwordTF.text]&&[_passwordTF.text length] >= 6&&_agreeBtn.selected) {
        
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = kLoginBtnEnableColor;
    }
    else{
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = kLoginBtnUnableColor;
    }
    
}

- (IBAction)clickAgreeBtn:(UIButton *)sender {
    _agreeBtn.selected = !_agreeBtn.selected;
    if (_agreeBtn.selected) {
        [_agreeBtn setImage:[UIImage imageNamed:@"loginAgree"] forState:UIControlStateNormal];
    }
    else{
        [_agreeBtn setImage:[UIImage imageNamed:@"loginDisAgree"] forState:UIControlStateNormal];
    }
}

- (IBAction)clickForgetBtn:(UIButton *)sender {
    NSLog(@"forget");
}

- (IBAction)clickRegistBtn:(UIButton *)sender {
    NSLog(@"regist");
}

- (IBAction)clickProtocolBtn:(UIButton *)sender {
    NSLog(@"protocol");
}


- (IBAction)clickLoginBtn:(UIButton *)sender {
    //loginEvent
    NSLog(@"loginEvent");
}

#pragma mark --判断事件--

/** 判断手机号是否合法 */
-(BOOL)isValidateMobileString:(NSString *)mobile{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(17[0-9])|(147)|(145)|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}


/**
 *  判断字符串是否为nil或者"",或者null
 */
-(BOOL)isNilOrEmptyString:(NSString*)string
{
    
    if ([string isKindOfClass:[NSNull class]]) {
        NSLog(@"**********传入的字符串%@为NULL**********",string);
        return YES;
    }
    
    if ([string isEqualToString:@""] ) {
        NSLog(@"**********传入的字符串%@为空**********",string);
        return YES;
    }
    
    if ([string isEqualToString:@"<null>"]) {
        return YES;
    }
    
    if (!string) {
        NSLog(@"**********传入的字符串%@为nil**********",string);
        return YES;
    }
    return NO;
}

@end
