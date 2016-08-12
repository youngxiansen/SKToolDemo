//
//  AppDelegate.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//




#import "AppDelegate.h"
#import "SKHomeTableVC.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
//以下分享和第三方登陆
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"

#import "SKTestVC.h"

#pragma mark --暂时测试--
#import "JMLoginUser.h"
#import "JMLoginVC.h"
#import "SKCaiPiao.h"
const NSString* AMapAndSearchKey = @"ff5c7938ed2f0d81eb1e4005710fef19";
const NSString* UMAppKey = @"570c8bae67e58e7bd7000853";
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    

    [MAMapServices sharedServices].apiKey = (NSString*)AMapAndSearchKey;
    [AMapSearchServices sharedServices].apiKey = (NSString*)AMapAndSearchKey;
    
    //分享和第三方登陆
    [UMSocialData setAppKey:(NSString*)UMAppKey];
    [self UMShareLogin];
    
    
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[SKHomeTableVC alloc] init]];
//    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:[[SKCaiPiao alloc] init]];
    return YES;
}


-(void)UMShareLogin
{
    //微博注意事项  记得修改安全域名和回调
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"2468035343"
                                              secret:@"9fdeebc4604630d5e8601f7a09ef3851"
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
    [UMSocialQQHandler setQQWithAppId:@"100424468" appKey:@"c7394704798a158208a74ab60104f0ba" url:@"http://www.umeng.com/social"];
    
    
    //设置微信AppId、appSecret，分享url 必须认证才行
//    [UMSocialWechatHandler setWXAppId:@"wxd930ea5d5a258f4f" appSecret:@"db426a9829e4b49a0dcac7b4162da6b6" url:@"http://www.umeng.com/social"];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

@implementation NSURLRequest(DataController)
+ (BOOL)allowsAnyHTTPSCertificateForHost:(NSString *)host
{
    return YES;
}
@end
