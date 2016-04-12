//
//  SKThirdLoginVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/4/12.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKThirdLoginVC.h"
#import "UMSocial.h"
#import "UIImageView+AFNetworking.h"
@interface SKThirdLoginVC ()
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *iconImgv;

@end

@implementation SKThirdLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
}


- (IBAction)clickSinaLogin:(UIButton *)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    KWS(weakSelf);
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToSina];
            
            weakSelf.userName.text = snsAccount.userName;
            [weakSelf.iconImgv setImageWithURL:[NSURL URLWithString:snsAccount.iconURL]];
            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}

- (IBAction)clickQQLogin:(UIButton *)sender {
    
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToQQ];
    
    KWS(weakSelf);
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        //          获取微博用户名、uid、token等
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            UMSocialAccountEntity *snsAccount = [[UMSocialAccountManager socialAccountDictionary] valueForKey:UMShareToQQ];
            weakSelf.userName.text = snsAccount.userName;
            [weakSelf.iconImgv setImageWithURL:[NSURL URLWithString:snsAccount.iconURL]];

            NSLog(@"username is %@, uid is %@, token is %@ url is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
            
        }});
}


@end
