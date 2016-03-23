//
//  SKHttpToolManager.h
//  SKTools
//
//  Created by youngxiansen on 15/9/21.
//  Copyright (c) 2015年 youngxiansen. All rights reserved.
//

#import "AFHTTPSessionManager.h"
#import "SKInterFace.h"
@interface SKHttpToolManager : AFHTTPSessionManager

+(id)shareManager;

@end
