//
//  SKHTTPSessionManager.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//
#import "NSDictionary+SKDic.h"
#import "SKHTTPSessionManager.h"

@implementation SKHTTPSessionManager

+(void)postWithInterface:(NSString *)interface params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
//    securityPolicy.allowInvalidCertificates = YES;
//    manager.securityPolicy = securityPolicy;
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
    NSDictionary* dic = [NSDictionary reCombineDic:params];
    
    [manager POST:interface parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
        NSLog(@"\n接口地址:%@\n参数:%@\n出参:%@",interface,dic,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"\n接口地址:%@\n参数:%@\n失败信息:\n%@",interface,dic,error);
        failed(task,error);
    }];
}


+(void)postProgressWithInterface:(NSString *)interface params:(NSDictionary *)params success:(SuccessBlock)success failed:(FailedBlock)failed
{
    UIApplication* app = [UIApplication sharedApplication];
    app.networkActivityIndicatorVisible = YES;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", nil];
//    [manager setSecurityPolicy:[self customSecurityPolicy]];
    NSDictionary* dic = [NSDictionary reCombineDic:params];
    
    
    [manager POST:interface parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        app.networkActivityIndicatorVisible = NO;
        success(task,responseObject);
        NSLog(@"\n接口地址:%@\n参数:%@\n出参:%@",interface,dic,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        app.networkActivityIndicatorVisible = NO;
        NSLog(@"\n接口地址:%@\n参数:%@\n失败信息:\n%@",interface,dic,error);
        failed(task,error);
    }];
}

+ (AFSecurityPolicy*)customSecurityPolicy
{
    // /先导入证书
    
    NSString *cerPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"appclient.cer"];//证书的路径
    NSData *certData = [NSData dataWithContentsOfFile:cerPath];
    
    // AFSSLPinningModeCertificate 使用证书验证模式
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    
    // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
    // 如果是需要验证自建证书，需要设置为YES
    securityPolicy.allowInvalidCertificates = YES;
    
    //validatesDomainName 是否需要验证域名，默认为YES；
    //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
    //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
    //如置为NO，建议自己添加对应域名的校验逻辑。
    securityPolicy.validatesDomainName = NO;
    
    securityPolicy.pinnedCertificates = @[certData];
    
    return securityPolicy;
}

@end
