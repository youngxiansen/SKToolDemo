//
//  SKBaseVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKBaseVC.h"
#import <CoreLocation/CoreLocation.h>
@interface SKBaseVC ()<UIActionSheetDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property(nonatomic,strong)UIImagePickerController* pickerVC;
@property (assign, nonatomic) SKPhotoType photoType;
@property (copy, nonatomic) void(^cancleBlock)();/**< 取消点击事件 */
@property (copy, nonatomic) void(^enSureBlock)();/**< 确定点击事件 */

@end

@implementation SKBaseVC

-(SKHttpToolManager *)httpSessionManager{
    if (_httpSessionManager == nil) {
        _httpSessionManager = [SKHttpToolManager shareManager];
    }
    return _httpSessionManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //取消scrollview的自动像素下移
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //取消navigationbar导致的view层自动下移
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    [self inintNavigationBar];

}

-(void)inintNavigationBar
{
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,nil]];
    
    [self.navigationController.navigationBar setBarTintColor:kNavigationBarColor];
    self.navigationController.navigationBar.translucent = NO;
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

#pragma mark --判断用户是否开启定位服务
/** 判断系统定位是否开启 */
-(BOOL)checkIsLocationServiceEnabled;
{
    //判断定位服务是否可用
    if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined
         || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse))
    {
        return YES;
    }
    return NO;
}

#pragma mark --请求网络相关--
/**
 *  有网络进程
 *  @param interface 接口
 *  @param params    参数
 */
-(void)postProgressWithInterface:(NSString*)interface params:(NSDictionary*)params Success:(void (^)(NSURLSessionDataTask *task, NSDictionary* responseObject))success Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
{
    [self showNetWorkAlertWithTitleStr:@"请稍后"];
    
    NSDictionary* dic = [self reCombineDic:params];
    
    [self.httpSessionManager POST:interface parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self showResponseDataType:responseObject[@"data"]];
        
        MJLog(@"\n-----接口-----\n主地址:%@\n接口名:%@\n入参:\n%@\n出参:\n%@\n",kBaseUrl,interface,dic,responseObject);
        success(task,responseObject);
        [self endNetWorkAlertWithNoMessage];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJLog(@"\n-----接口-----\n主地址:%@\n接口名:%@\n入参:\n%@\n失败信息:%@",kBaseUrl,interface,dic,error);
        failure(task,error);
        [self showErroAlertWithTitleStr:@"连接超时"];
    }];

}


/** 没有有网络进程但是有小花 */
-(void)postWithInterface:(NSString*)interface params:(NSDictionary*)params Success:(void (^)(NSURLSessionDataTask *task, NSDictionary* responseObject))success Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
{
    [self monitorInternet];
    UIApplication *application = [UIApplication sharedApplication];
    application.networkActivityIndicatorVisible = YES;
    NSDictionary* dic = [self reCombineDic:params];
    [self.httpSessionManager POST:interface parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
        application.networkActivityIndicatorVisible = NO;
        
        [self showResponseDataType:responseObject[@"data"]];
        
        
        MJLog(@"\n-----接口-----\n主地址:%@\n接口名:%@\n入参:\n%@\n出参:\n%@\n",kBaseUrl,interface,dic,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        application.networkActivityIndicatorVisible = NO;
        MJLog(@"\n-----接口-----\n主地址:%@\n接口名:%@\n入参:\n%@\n失败信息:%@",kBaseUrl,interface,dic,error);
        failure(task,error);
        [self showErroAlertWithTitleStr:@"连接超时"];
    }];
}

/** 什么进程都没 */
-(void)postInterface:(NSString*)interface params:(NSDictionary*)params Success:(void (^)(NSURLSessionDataTask *task, NSDictionary* responseObject))success Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure
{
    [self monitorInternet];
    NSDictionary* dic = [self reCombineDic:params];
    [self.httpSessionManager POST:interface parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(task,responseObject);
        [self showResponseDataType:responseObject[@"data"]];
        MJLog(@"\n-----接口-----\n主地址:%@\n接口名:%@\n入参:\n%@\n出参:\n%@\n",kBaseUrl,interface,dic,responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        MJLog(@"\n-----接口-----\n主地址:%@\n接口名:%@\n入参:\n%@\n失败信息:%@",kBaseUrl,interface,dic,error);
        failure(task,error);
        [self showErroAlertWithTitleStr:@"连接超时"];
    }];
}


/**
 *  设置导航栏Item
 */
-(void)setNavigationItemEventWithTitle:(NSString*)title action:(SEL)action type:(SKItemType)itemType itemImgName:(NSString*)imgName
{
    if (itemType == SKItemTypeRightTitle) {//右边titile
        if (!title) {
            title = @"rightItem";
        }
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
        
        [self.navigationItem.rightBarButtonItem setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
        
    }else if (itemType == SKItemTypeRightImg){//右边图片
        
        if (!imgName||[imgName isEqualToString:@""]) {
            [self showAlertVCContent:@"请设置rightBarButtonItem图片" enSureBlock:^{
                
            }];
            return;
        }
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:imgName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    }
    else if (itemType == SKItemTypeLeftTitle){//左边titile
        if (!title) {
            title = @"leftItem";
        }
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:action];
        
        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:
         @{NSForegroundColorAttributeName:[UIColor whiteColor],
           NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    }
    else if (itemType == SKItemTypeLeftImg){//左边图片
        
        if (!imgName||[imgName isEqualToString:@""]) {
            [self showAlertVCContent:@"请设置leftBarButtonItem图片" enSureBlock:^{
                
            }];
            return;
        }
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:imgName]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:action];
    }
    else{
        [self showAlertVCContent:@"请检查点击事件" enSureBlock:^{
            
        }];
        return;
    }
    
}

/**
 *  判断是否成功返回数据
 *  @param responseObject 返回的字典
 */
-(BOOL)isSuccessReturnData:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]]) {
        if ([responseObject[@"data"] isKindOfClass:[NSNull class]]) {
            return NO;
        }
        
        if ([responseObject[@"status"] intValue] == 1) {
            return  YES;
        }
        else
        {
            return NO;
        }
    }
    MJLog(@"返回的数据格式不是字典");
    return NO;
}

/** 经纬度是否是有数值的 */
-(BOOL)isValidLocation:(NSDictionary*)dic
{
    BOOL isValidLocation = YES;
    NSString* latStr = dic[@"lat"];
    NSString* lonStr = dic[@"lon"];
    if (!latStr || !lonStr) {
        //        NSLog(@"取出的经纬度是lat:%@  lon:%@",latStr,lonStr);
        isValidLocation = NO;
    }
    
    if (![latStr floatValue] || ![lonStr floatValue]) {
        NSLog(@"取出本地的经纬度是lat:%.6f  lon:%.6f",[latStr floatValue],[lonStr floatValue]);
        isValidLocation = NO;
    }
    return isValidLocation;
}
#pragma mark --生命周期--

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self stepNavi];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
    self.title = @"";
    self.navigationItem.title = @"";
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

-(void)dealloc
{
    
}
-(void)stepNavi
{
    
}

/** 获取系统的缓存路径 */
-(NSString *)cachePath{
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* urls = [fileManager URLsForDirectory:NSCachesDirectory
                                        inDomains:NSUserDomainMask];
    NSURL* cachesURL =[urls objectAtIndex:0];
    NSString* cachesPath = [cachesURL path];
    
    return cachesPath;
}



#pragma mark --弹框提示--



/** 只有确定点击事件 */
-(void)showAlertVCContent:(NSString*)content enSureBlock:(void (^)())enSureBlock
{
    //    此处是因为下面的alertView只有一个点击事件,所以用取消的block代替确定事件
    self.cancleBlock = enSureBlock;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        //        MJLog(@"8.0以上");
        UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:content preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (self.cancleBlock) {
                self.cancleBlock();
            }
            
        }]];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else{
        //        MJLog(@"8.0以下");
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:content delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
    }
}

/** 有点击事件 */
-(void)showAlertVCContent:(NSString*)content cancleBlock:(void (^)())cancleBlock enSureBlock:(void (^)())enSureBlock
{
    //    MJLog(@"systemVersion-%f",[UIDevice currentDevice].systemVersion.floatValue );
    self.cancleBlock = cancleBlock;
    self.enSureBlock = enSureBlock;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0)
    {
        //        MJLog(@"8.0以上");
        UIAlertController* alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:content preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            if (self.enSureBlock) {
                self.enSureBlock();
            }
            
        }]];
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (self.cancleBlock) {
                self.cancleBlock();
            }
        }]];
        
        [self presentViewController:alertVC animated:YES completion:nil];
    }
    else{
        //        MJLog(@"8.0以下");
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"温馨提示" message:content delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alert show];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
            if (self.cancleBlock)
            {
                self.cancleBlock();
            }
            
            break;
        case 1:
            if (self.enSureBlock)
            {
                self.enSureBlock();
            }
        default:
            break;
    }
}

#pragma mark --监控网络状态--
/** 实时监测网络的变化 */
-(void)monitorInternet
{
    
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status)
        {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                break;
                
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
            {
                [self showErroAlertWithTitleStr:@"请检查是否开启网络"];
            }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                break;
        }
    }];
    
    // 3.开始监控
    [mgr startMonitoring];
    
    //    mgr.isReachableViaWiFi
    //    mgr.isReachableViaWWAN
    
}

#pragma mark --上传照片--
-(void)addPhoto:(SKPhotoType)photoType SuccessBlock:(void (^)(NSString *, UIImage *))imgInfo
{
    _imgInfo = imgInfo;
    _photoType = photoType;
    UIActionSheet* actionSheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相机选择",nil];
    [actionSheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            if ([kDevice isEqualToString:kSimulator]) {
                MJLog(@"模拟器不能拍照");
                return;
            }
            
            [self goCameraVC];
            break;
        case 1:
            MJLog(@"点击了从相机选择");
            [self goPhotoPickerVC];
            break;
            
        case 2:
            //            MJLog(@"点击了取消");
            break;
            
        default:
            break;
    }
}

-(void)goCameraVC{
    
    self.pickerVC = [[UIImagePickerController alloc]init];
    
    self.pickerVC.sourceType =UIImagePickerControllerSourceTypeCamera;
    
    
    self.pickerVC.delegate = self;
    if (_photoType == SKPhotoTypeEdit) {
        self.pickerVC.allowsEditing = YES;
    }
    else if (_photoType == SKPhotoTypeOriginal){
        self.pickerVC.allowsEditing = NO;
    }
    
    
    [self presentViewController:self.pickerVC animated:YES completion:nil];
}

//跳转至选择相片
-(void)goPhotoPickerVC{
    self.pickerVC = [[UIImagePickerController alloc]init];
    self.pickerVC.sourceType =UIImagePickerControllerSourceTypePhotoLibrary;
    self.pickerVC.delegate = self;
    if (_photoType == SKPhotoTypeEdit) {
        self.pickerVC.allowsEditing = YES;
    }
    else if (_photoType == SKPhotoTypeOriginal){
        self.pickerVC.allowsEditing = NO;
    }
    
    [self presentViewController:self.pickerVC animated:YES completion:nil];
    
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage* editImage;
    if (_photoType == SKPhotoTypeEdit) {
        editImage = info[@"UIImagePickerControllerEditedImage"];
    }
    else if (_photoType == SKPhotoTypeOriginal){
        editImage = info[@"UIImagePickerControllerOriginalImage"];
    }
    NSData* newDataImg=UIImageJPEGRepresentation(editImage,.2);
    
    NSString* imagePath= [newDataImg base64EncodedStringWithOptions:0];
    UIImage* newImage = [UIImage imageWithData:newDataImg];
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
    
    if (_imgInfo) {
        _imgInfo(imagePath,newImage);
    }
    
}

#pragma mark --打电话--

-(void)configCall:(NSString*)phone
{
    if ([NSString isNilOrEmptyString:phone]) {
        return;
    }
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",phone];
    UIWebView * callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];
}


-(NSDictionary*)reCombineDic:(NSDictionary*)dic{
    
    if (!dic[@"driver_id"]) {
        return dic;
    }
    
    if (!dic[@"token"]){
        return dic;
    }
    else{
        
        NSMutableDictionary* muDic = [dic mutableCopy];
        
        NSMutableString* tokenStr = [NSMutableString string];
        [tokenStr appendString:@"driver_id:"];
        [tokenStr appendString:dic[@"driver_id"]];
        
        NSString* time = [NSString stringWithFormat:@"%.0f",[[NSDate date] timeIntervalSince1970]];
        [muDic setObject:time forKey:@"time_stamp"];
        
        [tokenStr appendString:@"time_stamp:"];
        [tokenStr appendString:time];
        
        [tokenStr appendString:@"token:"];
        [tokenStr appendString:dic[@"token"]];
        [muDic setObject:tokenStr forKey:@"token"];
        //        NSLog(@"未加密：%@\n加密：%@",dic,muDic);
        [muDic setObject:[tokenStr MD5] forKey:@"token"];
        
        if (![NSString isNilOrEmptyString:muDic[@"phone_time"]]) {
            
            [muDic setObject:time forKey:@"phone_time"];
        }
        
        return [muDic copy];
    }
}

#pragma mark --打印类设置--

-(void)showTestData:(NSString*)str
{
#ifdef DEBUG
    [self showErroAlertWithTitleStr:str];
#else
    
#endif
}

-(void)showResponseDataType:(id)responseData
{
#ifdef DEBUG
    if (![responseData isKindOfClass:[NSNull class]]) {
        
        if ([responseData isKindOfClass:[NSDictionary class]]) {
            NSDictionary* dic = (NSDictionary*)responseData;
            [dic NSLogDicValueType];
        }
        
        else if([responseData isKindOfClass:[NSArray class]]){
            
            NSArray* arr = (NSArray*)responseData;
            [arr NSLogArrayValueType];
        }
    }
#else
    
#endif
}

@end
