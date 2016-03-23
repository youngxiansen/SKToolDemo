//
//  SKBaseVC.h
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//


#import "ViewController.h"
#import "SKToolInterface.h"
#import "UIViewController+AMNoticeAlertView.h"
#import "SKHttpToolManager.h"
#import "UIViewController+AMPickerTool.h"


typedef NS_ENUM(NSUInteger, SKPhotoType) {
    SKPhotoTypeEdit = 1,
    SKPhotoTypeOriginal,
};

typedef NS_ENUM(NSUInteger, SKItemType) {
    SKItemTypeLeftTitle = 1,
    SKItemTypeLeftImg,
    SKItemTypeRightTitle,
    SKItemTypeRightImg,
};
@interface SKBaseVC : ViewController

@property (strong, nonatomic) SKHttpToolManager* httpSessionManager;/**< 网络请求单例 */

#pragma mark --常用方法--
-(void)configCall:(NSString*)phone;

-(void)showTestData:(NSString*)str;

/** 经纬度是否是有数值的 */
-(BOOL)isValidLocation:(NSDictionary*)dic;


/** 判断系统定位是否开启 */
-(BOOL)checkIsLocationServiceEnabled;

#pragma mark --请求网络相关--
/**
 *  有网络进程
 *  @param interface 接口
 *  @param params    参数
 */
-(void)postProgressWithInterface:(NSString*)interface params:(NSDictionary*)params Success:(void (^)(NSURLSessionDataTask *task, NSDictionary* responseObject))success Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;

/** 没有有网络进程但是有小花 */
-(void)postWithInterface:(NSString*)interface params:(NSDictionary*)params Success:(void (^)(NSURLSessionDataTask *task, NSDictionary* responseObject))success Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;

/** 什么进程都没 */
-(void)postInterface:(NSString*)interface params:(NSDictionary*)params Success:(void (^)(NSURLSessionDataTask *task, NSDictionary* responseObject))success Failure:(void (^)(NSURLSessionDataTask *task,NSError *error))failure;

/**
 *  设置导航栏Item
 */
-(void)setNavigationItemEventWithTitle:(NSString*)title action:(SEL)action type:(SKItemType)itemType itemImgName:(NSString*)imgName;

/**
 *  判断是否成功返回数据
 *  @param responseObject 返回的字典
 */
-(BOOL)isSuccessReturnData:(id)responseObject;

#pragma mark --上传照片相关--
/**
 *  imgPath 上传路径
 *  img     压缩后的图片
 */
@property (copy, nonatomic) void(^imgInfo)(NSString*imgPath,UIImage* img);

/**
 *  imgPath 上传路径
 *  img     压缩后的图片
 */
-(void)addPhoto:(SKPhotoType)photoType SuccessBlock:(void (^)(NSString *imgPath, UIImage *img))imgInfo;

-(void)configCall:(NSString*)phone;

/** 设置导航栏标题*/
-(void)stepNavi;


-(NSDictionary*)reCombineDic:(NSDictionary*)dic;

/** 获取系统的缓存路径 */
-(NSString *)cachePath;
@end
