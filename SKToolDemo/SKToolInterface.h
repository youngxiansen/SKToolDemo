//
//  SKToolInterface.h
//  BENBENDaiJia
//
//  Created by youngxiansen on 15/12/4.
//  Copyright © 2015年 youngxiansen. All rights reserved.
//

#ifndef SKToolInterface_h
#define SKToolInterface_h

// 日志输出
#ifdef DEBUG
#define MJLog(...) NSLog(__VA_ARGS__)
#else
#define MJLog(...)
#endif

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

//判断模拟器还是真机
#define kSimulator @"simulator"
#define kRealPhone @"realPhone"

#if TARGET_IPHONE_SIMULATOR
#define kDevice @"simulator"
#elif TARGET_OS_IPHONE
//真机
#define kDevice @"realPhone"

#endif

//打印对象类名和地址
#define KKLogObject_Address(object) NSLog(@"地址%p--%@--类名%@",object,object,NSStringFromClass([object class]))

#define KKLog_MethodName NSLog(@"掉用了方法%@", NSStringFromSelector(_cmd))

#define KKLogController NSLog(@"_________%s_________",__func__);

#define KKLogNSSting(str) NSLog(@"#########%@########",str)

#define KKLogFrame(object) NSLog(@"%@的frame:%@",NSStringFromClass([object class]),NSStringFromCGRect(object.frame));

#pragma mark --判断程序之间执行的时间--
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: -----%f", -[startTime timeIntervalSinceNow])

//__OPTIMIZE__  :用于release和debug的判断，当选择了__OPTIMIZE__  时，可以让代码在release时执行，在debug时不执行。示例如下：

//#ifndef __OPTIMIZE__
////这里执行的是debug模式下
//#else
////这里执行的是release模式下
//#endif
//
////__i386__ 与 __x86_64__   ：用于模拟器环境和真机环境的判断。满足该条件的代码只在模拟器下执行。示例代码如下：
//
//#if defined (__i386__) || defined (__x86_64__)
//
////模拟器下执行
//#else
//
////真机下执行
//#endif
#pragma mark --Xcode颜色修改--

#define XCODE_COLORS_ESCAPE @"\033["

#define XCODE_COLORS_RESET_FG  XCODE_COLORS_ESCAPE @"fg;" // Clear any foreground color
#define XCODE_COLORS_RESET_BG  XCODE_COLORS_ESCAPE @"bg;" // Clear any background color
#define XCODE_COLORS_RESET     XCODE_COLORS_ESCAPE @";"   // Clear any foreground or background color
#define kkLogBlueColor(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg0,0,255;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)
#define kkLogRedColor(frmt, ...) NSLog((XCODE_COLORS_ESCAPE @"fg255,0,0;" frmt XCODE_COLORS_RESET), ##__VA_ARGS__)

// 时间间隔
#define kHUDDuration            (1.f)
// 一天的秒数
#define SecondsOfDay            (24.f * 60.f * 60.f)
// 秒数
#define Seconds(Days)           (24.f * 60.f * 60.f * (Days))
// 一天的毫秒数
#define MillisecondsOfDay       (24.f * 60.f * 60.f * 1000.f)
// 毫秒数
#define Milliseconds(Days)      (24.f * 60.f * 60.f * 1000.f * (Days))




#endif /* SKToolInterface_h */
