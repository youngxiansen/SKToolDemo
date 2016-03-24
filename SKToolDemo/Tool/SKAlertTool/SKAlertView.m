//
//  SKAlertView.m
//  BENBENDaiJia
//
//  Created by youngxiansen on 15/11/26.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#import "SKAlertView.h"
#import "UILabel+SKLabel.h"
#define kNoticeWidth 250
#define kNoticeHeight 200
#define kConformBtnColor [UIColor colorWithRed:105.0/255 green:221.0/255 blue:204.0/255 alpha:1]
@interface SKAlertView()

@property (nonatomic, strong) UILabel* textLB;
@property (strong, nonatomic) UIButton* cancleBtn;
@property (strong, nonatomic) UIButton* confirmBtn;
@property (copy, nonatomic) void(^cancleBlock)();/**< 取消点击事件 */
@property (copy, nonatomic) void(^enSureBlock)();/**< 确定点击事件 */


@end
@implementation SKAlertView

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
    
    //添加照片
    UIImage* img = [UIImage imageNamed:@"alertNotice"];
    UIImageView* imgv = [[UIImageView alloc]initWithFrame:CGRectMake((kNoticeWidth-img.size.width)/2, 15, img.size.width, img.size.height)];
    imgv.image = img;
    [noticeView addSubview:imgv];
    
    //添加文字
    _textLB = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(imgv.frame)+10, kNoticeWidth, 40)];
    _textLB.font = [UIFont systemFontOfSize:14];
    _textLB.numberOfLines = 0;
    _textLB.textAlignment = NSTextAlignmentCenter;
    [noticeView addSubview:_textLB];
    
    _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleBtn.frame = CGRectMake(20,kNoticeHeight-44-20, 190/2, 44);
    _cancleBtn.layer.cornerRadius = 4;
    _cancleBtn.clipsToBounds = YES;
    _cancleBtn.layer.borderColor = [UIColor colorWithRed:0.77 green:0.77 blue:0.77 alpha:1].CGColor;
    _cancleBtn.layer.borderWidth = 1;
    [_cancleBtn setTitleColor:[UIColor colorWithRed:153.0/255 green:153.0/255 blue:153.0/255 alpha:1] forState:UIControlStateNormal];
    [_cancleBtn setTitle:@"取消" forState:UIControlStateNormal];
    [noticeView addSubview:_cancleBtn];
    [_cancleBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    
    _confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _confirmBtn.backgroundColor = kConformBtnColor;
    _confirmBtn.frame = CGRectMake(kNoticeWidth-190/2-20,kNoticeHeight-44-20, 190/2, 44);
    _confirmBtn.layer.cornerRadius = 4;
    _confirmBtn.clipsToBounds = YES;
    [_confirmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [noticeView addSubview:_confirmBtn];
    [_confirmBtn addTarget:self action:@selector(clickEvent:) forControlEvents:UIControlEventTouchUpInside];
    
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
        _textLB.text = @"温馨提示";
    }
    else{
        if ([content rangeOfString:@"#"].location!=NSNotFound) {//找到了
            
            NSArray* arr = [content componentsSeparatedByString:@"#"];
           _textLB.text = [content stringByReplacingOccurrencesOfString:@"#" withString:@""];
            _textLB.attributedText = [UILabel attributedTextWithLabel:_textLB attribute:@{NSForegroundColorAttributeName:[UIColor lightGrayColor],NSFontAttributeName:[UIFont systemFontOfSize:12]} attributeStr:arr[1]];
        }
        else{
            _textLB.text = content;
        }
}
    
    self.cancleBlock = cancleBlock;
    self.enSureBlock = enSureBlock;
}

@end
