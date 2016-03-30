//
//  SKFMDBTool.h
//  FMDBDemo
//
//  Created by youngxiansen on 16/1/26.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "dataModel.h"
@interface SKFMDBTool : NSObject

+(id)shareManager;

@property (strong, nonatomic) dataModel* model;

-(void)insertModel:(dataModel*)model;

/**
 *  删除一条数据
 *
 *  @param flag 唯一的标识,一般是id
 */
- (void)deleteModelWithFlag:(NSString*)flag;

/**
 *  移除所有的数据模型
 */
-(void)removeAllData;

-(NSMutableArray*)fetchAll;

/**
 *  更新数据的某个字段
 *  @param model 所有的字段都要传,只需改变需要改的
 */
- (void)updateUserModel:(dataModel *)model;



@end
