//
//  EZDAlertView.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/31.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//
#define kNoticeWidth 280
#define kBtnWidth (kNoticeWidth-30)/2
#define kNoticeHeight 180
#define kConformBtnColor [UIColor colorWithRed:231.0/255 green:76.0/255 blue:60.0/255 alpha:1]

#import "EZDAlertView.h"
@interface EZDAlertView()

@property (nonatomic, strong) UILabel* textLB;
@property (strong, nonatomic) UIButton* cancleBtn;
@property (strong, nonatomic) UIButton* confirmBtn;
@property (copy, nonatomic) void(^cancleBlock)();/**< 取消点击事件 */
@property (copy, nonatomic) void(^enSureBlock)();/**< 确定点击事件 */

@end
@implementation EZDAlertView

-(instancetype)init{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    
        [self addNoticeView];
    }
    return self;
}

-(void)addNoticeView
{
    UIView* noticeView = [[UIView alloc]init];
    noticeView.center = self.center;
    noticeView.bounds = CGRectMake(0, 0, kNoticeWidth, kNoticeHeight);
    noticeView.layer.cornerRadius = 4;
    noticeView.clipsToBounds = YES;
    noticeView.backgroundColor = [UIColor whiteColor];
    [self addSubview:noticeView];
    
    //添加标题
    UILabel* titleLB = [[UILabel alloc]init];
    titleLB.text = @"操作提示!";
    CGRect rectOfText=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-40, 999);
    rectOfText=[titleLB textRectForBounds:rectOfText limitedToNumberOfLines:1];
    CGFloat titleLBWidth = rectOfText.size.width;
    titleLB.frame = CGRectMake((kNoticeWidth-titleLBWidth)/2, 10, titleLBWidth, 30);
    titleLB.font = [UIFont systemFontOfSize:14];
    titleLB.textColor = [UIColor colorWithRed:50.0/255 green:50.0/255 blue:50.0/255 alpha:1];
    [noticeView addSubview:titleLB];
    
    //添加线
    UILabel* lineLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLB.frame)+10, kNoticeWidth, 2)];
    
    lineLB.backgroundColor = [UIColor colorWithRed:0.89 green:0.88 blue:0.88 alpha:1];
    [noticeView addSubview:lineLB];
    
    //添加内容文字
    _textLB = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineLB.frame)+10, kNoticeWidth-20, 40)];
    _textLB.font = [UIFont systemFontOfSize:12];
    _textLB.numberOfLines = 0;
    _textLB.textAlignment = NSTextAlignmentCenter;
    [noticeView addSubview:_textLB];
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.backgroundColor = kConformBtnColor;
    _confirmBtn.frame = CGRectMake(10,CGRectGetMaxY(_textLB.frame)+30, kBtnWidth, 35);
    _confirmBtn.layer.cornerRadius = 3;
    _confirmBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn setTitle:@"余额支付" forState:UIControlStateNormal];
    [noticeView addSubview:_confirmBtn];
    [_confirmBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleBtn.frame = CGRectMake(CGRectGetMaxX(_confirmBtn.frame)+10,CGRectGetMaxY(_textLB.frame)+30, kBtnWidth, 35);
    _cancleBtn.layer.cornerRadius = 3;
    _cancleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    _cancleBtn.clipsToBounds = YES;
    _cancleBtn.layer.borderColor = kConformBtnColor.CGColor;
    _cancleBtn.layer.borderWidth = 1;
    [_cancleBtn setTitleColor:kConformBtnColor forState:UIControlStateNormal];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [noticeView addSubview:_cancleBtn];
    [_cancleBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];

    
}

-(void)setConfirmBtnText:(NSString *)confirmBtnText
{
    _confirmBtnText = confirmBtnText;
    [_confirmBtn setTitle:_confirmBtnText forState:UIControlStateNormal];
    
}

-(void)clickEvent:(UIButton*)btn
{
    if ([btn isEqual:_cancleBtn]) {
        
        if (self.cancleBlock) {
            self.cancleBlock();
        }
        [self removeFromSuperview];
    }
    else if ([btn isEqual:_confirmBtn])
    {
        
        if (self.enSureBlock) {
            self.enSureBlock();
        }
        [self removeFromSuperview];
    }
}

-(void)showAlertViewContent:(NSString*)content EnSureBlock:(void(^)())enSureBlock cancleBlock:(void(^)())cancleBlock{
    if (!content || [content isEqualToString:@""]) {
        _textLB.text = @"提示文字";
    }
    else{

        _textLB.text = content;
        
    }
    
    self.cancleBlock = cancleBlock;
    self.enSureBlock = enSureBlock;
}

-(void)dealloc
{
    NSLog(@"*******提示框销毁*******");
}

@end
