//
//  JMLoginUser.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/4/11.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#define kLoginBtnEnableColor [UIColor redColor]
#define kLoginBtnUnableColor [UIColor lightGrayColor]
#define kCodeUnableColor [UIColor lightGrayColor]
#define kCodeEnableColor [UIColor redColor]

#import "JMLoginUser.h"

@interface JMLoginUser ()
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;
@property (weak, nonatomic) IBOutlet UIButton *protocolBtn;


@property (strong, nonatomic) NSTimer* timer;

@end

@implementation JMLoginUser

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initBaseInfo];
}

-(void)initBaseInfo
{
    self.navigationItem.title = @"登陆";
    
    _loginBtn.backgroundColor = kLoginBtnUnableColor;
    _codeBtn.backgroundColor = kCodeUnableColor;
    _agreeBtn.selected = YES;
    _agreeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    // 设置按钮的内边距
    _agreeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    
    _protocolBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    // 设置按钮的内边距
    _protocolBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);


    [_phoneTF addTarget:self action:@selector(changeLoginBtnColor) forControlEvents:UIControlEventEditingChanged];
    [_codeTF addTarget:self action:@selector(changeLoginBtnColor) forControlEvents:UIControlEventEditingChanged];
    [_agreeBtn addTarget:self action:@selector(changeLoginBtnColor) forControlEvents:UIControlEventTouchUpInside];
}

-(void)changeLoginBtnColor
{
    
    if ([self isValidateMobileString:_phoneTF.text]) {
        _codeBtn.backgroundColor = kCodeEnableColor;
        _codeBtn.userInteractionEnabled = YES;
    }
    else{
        _codeBtn.userInteractionEnabled = NO;
        _codeBtn.backgroundColor = kCodeUnableColor;
    }
    
    if ([self isValidateMobileString:_phoneTF.text]&&![self isNilOrEmptyString:_codeTF.text]&&[_codeTF.text length] >= 4&&_agreeBtn.selected) {
        
        _loginBtn.userInteractionEnabled = YES;
        _loginBtn.backgroundColor = kLoginBtnEnableColor;
    }
    else{
        _loginBtn.userInteractionEnabled = NO;
        _loginBtn.backgroundColor = kLoginBtnUnableColor;
    }
    
}


#pragma mark --点击事件--
- (IBAction)clickGetCodeBtn:(UIButton *)sender {
    
    //掉接口成功之后执行
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(numCountReduce) userInfo:nil repeats:YES];
    _codeBtn.userInteractionEnabled = NO;
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

-(void)numCountReduce
{
    static int second = 60;
    second--;
    if (second == 0) {
        
        [_timer invalidate];
        _timer = nil;
        second = 60;
        [_codeBtn setTitle:@"重新获取" forState:UIControlStateNormal];
        _codeBtn.userInteractionEnabled = YES;
        return;
    }

    [_codeBtn setTitle:[NSString stringWithFormat:@"已发送(%d) S",second] forState:UIControlStateNormal];
    
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
