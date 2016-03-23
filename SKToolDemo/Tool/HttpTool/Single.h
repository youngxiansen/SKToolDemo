//
//  Single.h
//  新浪
//
//  Created by qianfeng on 15-6-4.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#ifndef ______Single__
#define ______Single__

//.h
#define single_interface(class) +(class*)shared##class;//有#号系统会把它识别为两个部分,分隔符

//.m\代表下一行也属于宏
#define sigle_implemetation(class) \
static class* _a;\
\
+(class*)shared##class\
{\
    if (!_a)\
    {\
        _a = [[self alloc]init];\
    }\
    return _a;\
}\
\
+(id)allocWithZone:(struct _NSZone *)zone\
{\
    static dispatch_once_t onceToken;\
    dispatch_once(&onceToken, ^{\
        _a = [super allocWithZone:zone];\
    });\
    return _a;\
   \
}
//保证只调用一次
//alloc底层调用了allocwithzone
#endif /* defined(______Single__) */
