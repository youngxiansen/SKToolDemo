//
//  SKInterFace.h
//  SKTools
//
//  Created by youngxiansen on 15/7/26.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#ifndef __SKTools__SKInterFace__
#define __SKTools__SKInterFace__
#endif /* defined(__SKTools__SKInterFace__) */

#define kApp @"BenBenDaijia"
#define kBenBenDaijia @"BenBenDaijia"
#define kBenBenTexi @"BenBenTexi"
#define kBenBenSpecial @"BenBenSpecial"
/**
 *  以下定义常用的接口
 */
//#define kBaseUrl @"http://123.59.45.187/api.php/"
//#define kBaseImgUrl @"http://123.59.45.187"

#define kAppStoreId @"1092391131"
#define kBaseUrl @"http://www.88benben.joyskim.com/api.php/"
#define kBaseImgUrl @"http://www.88benben.joyskim.com"

#define kLogin @"Index/driversLogin"//OK
#define kRegist @"Index/register"
#define kLogOut @"Index/driversLogout"
#define kGetCode @"Index/getCode"//OK
#define kForgetPassword @"Index/forgetPassword"
#define kCheckVersion @"Index/checkVersion"//检查版本OK
#define kUploadDriverLocation @"Drivers/uploadDriverLocation"//实时上传经纬度 OK
#define kMessageList @"Drivers/messageList"//消息列表
#define kMessageDetailInfo @"Drivers/messageInfo"//消息详情
#define kDriverCount @"Drivers/driverCount"//司机信息统计接口OK
#define kChangeWorkStatus @"Drivers/changeWorkStatus"//上下班接口 OK
#define kChangeModel @"Drivers/changeModel"//OK
#define kNewOrderInfo @"DriversOrder/newOrderInfo"//根据推送订单号显示订单信息OK
#define kGrabOrder @"DriversOrder/getOrder"//OK
#define kIgnoreOrder @"DriversOrder/ignoreOrder"//0K
#define kChangeOrder @"DriversOrder/changeOrder"//改派订单OK
#define kChangeDestination @"DriversOrder/editOrderEndAddress"//修改终点
#define kDriverArrive @"DriversOrder/driverArrive"//司机到达OK
#define kCharging @"DriversOrder/charging"//计价接口OK
#define kArriveDestination @"DriversOrder/arriver"//到达终点OK
#define kConfirmFee @"DriversOrder/confirmFee"//确定费用OK
#define kReceivables @"DriversOrder/receivables"//代收款OK
#define kComplainUsers @"Drivers/complainUsers"//OK
#define kOrderDetailInfo @"DriversOrder/orderInfo"//订单详情OK
#define kOrderPayInfo @"DriversOrder/payInfo"//支付详情OK
#define kMyOrderList @"DriversOrder/myOrderList"//我的订单列表
#define kWithDraw @"Drivers/withdraw"//提现OK
//#define kAccountList @"Drivers/accountList"//收支明细
#define kGetDriverInfo @"Drivers/getDriverInfo"//获取个人信息（我首页）OK
#define kChangeDriverInfo @"Drivers/editDriversInfo"//不知道那个页面
#define kMyMoneyAndBalance @"Drivers/myBalance" //我的余额/账户查询OK


#define kRecommand @"Drivers/recomand"
#define kModifyPassWord @"Drivers/moditifyPassword"
#define kFeedBack @"Drivers/feedBack"//OK
#define kDivide @"Drivers/Divide"//暂时去掉
#define kDealRate @"Drivers/volume"//成交率OK
#define kScoreCheck @"Drivers/checkMark"//成绩查询OK
#define kServiceQuality @"Drivers/serviceQuality"//OK

#define kAlliance @"Index/alliance"
/**
 *  以下定义一些常量
 */
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define kTimeInternal5 5.0
#define KWS(weakSelf) __weak typeof (&*self) weakSelf = self;
#define kGuaranteeMoney 100.0//保证金

//5FC9F3   导航栏色值
//105 221 204  按钮浅绿色

#pragma mark --常用的头文件--
#import "UILabel+SKLabel.h"
#import "NSString+SKString.h"
#import "UIColor+SKColor.h"
#import "NSDate+SKDate.h"
#import "NSDate+AMCalendar.h"
#import "SKToolInterface.h"
#import "NSDictionary+SKDic.h"
#import "NSArray+SKArray.h"




//RGB颜色设置
#define kRGBRed CGFloat
#define kRGBGreen CGFloat
#define kRGBlue CGFloat
#define kRGBColor(kRGBRed,kRGBGreen,kRGBlue) [UIColor colorWithRed:kRGBRed/255.0 green:kRGBGreen/255.0 blue:kRGBlue/255.0 alpha:1]
#define kWhiteColor [UIColor whiteColor]
#define kLightBlueColor [UIColor colorWithRed:0.37 green:0.79 blue:0.95 alpha:1]
#define kGreenBtnColor [UIColor colorWithRed:105.0/255 green:221.0/255 blue:204.0/255 alpha:1]
#define kBackGroundColor [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1]

#define kEnableNoBtnColor [UIColor colorWithRed:204.0/255 green:204.0/255 blue:204.0/255 alpha:1]
#define kEnableYesBtnColor [UIColor colorWithRed:105.0/255 green:221.0/255 blue:204.0/255 alpha:1]

#define kNavigationBarColor [UIColor colorWithRed:95.0/255 green:201.0/255 blue:243.0/255 alpha:1]





