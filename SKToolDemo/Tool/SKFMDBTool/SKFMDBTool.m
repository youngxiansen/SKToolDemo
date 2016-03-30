//
//  SKFMDBTool.m
//  FMDBDemo
//
//  Created by youngxiansen on 16/1/26.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKFMDBTool.h"
#import "FMDB.h"

@interface SKFMDBTool()
{
    FMDatabase* _fmdb;
}
@end
@implementation SKFMDBTool

static SKFMDBTool* _fm = nil;
+(id)shareManager
{
    //给下面这一段代码加锁:线程锁,同一时刻只能有一个线程访问
    static dispatch_once_t once = 0;
    dispatch_once(&once, ^{
        if (!_fm)
        {
            _fm = [[SKFMDBTool alloc]init];
        }
    });
    
    return _fm;
}

//当调用alloc方法的时候,系统会调用这个方法
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    if (!_fm) {
        _fm = [super allocWithZone:zone];
    }
    return _fm;
}

//初始化fmdb的运行环境
-(instancetype)init
{
    if (self = [super init])
    {
        
        NSString* path = [[self cachePath] stringByAppendingPathComponent:@"data.db"];
        
        NSLog(@"path : %@",path);
        _fmdb = [[FMDatabase alloc]initWithPath:path];
        
        if ([_fmdb open])
        {
            //打开或者创建成功
            NSLog(@"open success");
            //此处修改模型的参数
            NSString* sql = @"create table if not exists dataTable(news_id varchar(1024), name varchar(1024))";
            [_fmdb executeUpdate:sql];
 
        }
    }
    return self;
}



-(void)insertModel:(dataModel*)model
{
    if ([self isNilOrEmptyString:model.news_id]) {
        return;
    }
    
    BOOL isExists =[self isModelExistWithFlag:model.news_id];
    if (isExists) {
        NSLog(@"new_id存在,插入失败");
        return;
    }
    NSString* sql = @"insert into dataTable(news_id,name)values(?,?)";
    [_fmdb executeUpdate:sql,model.news_id, model.name];
}

/**
 *  删除一条数据
 *
 *  @param flag 唯一的标识,一般是id
 */
- (void)deleteModelWithFlag:(NSString*)flag
{
    if ([self isModelExistWithFlag:flag]) {
        NSString *deleteSql = @"delete from dataTable where news_id = ?";
        BOOL ret = [_fmdb executeUpdate:deleteSql,flag];
    
        
        if (!ret) {
            NSLog(@"%@",_fmdb.lastErrorMessage);
        }
        else{
            NSLog(@"**********删除成功*********");
        }
    }
    else{
        NSLog(@"数据不存在---删除失败");
    }

}

/**
 *  移除所有的数据模型
 */
-(void)removeAllData
{
    NSString* sql = @"delete from dataTable";
    [_fmdb executeUpdate:sql];
}

-(NSMutableArray*)fetchAll
{
    NSMutableArray* array = [[NSMutableArray alloc]init];
    NSString* sql = @"select * from dataTable";
    FMResultSet* result = [_fmdb executeQuery:sql];
    
    while ([result next])
    {
        dataModel* model = [[dataModel alloc]init];
        model.news_id = [result stringForColumn:@"news_id"];
        model.name = [result stringForColumn:@"name"];
  
        [array addObject:model];
    }
    return array;
}

/**
 *  更新数据的某个字段
 *  @param model 所有的字段都要传,只需改变需要改的
 */
- (void)updateUserModel:(dataModel *)model
{
    NSString *sql = @"update dataTable set name = ? where news_id = ?";
    BOOL ret = [_fmdb executeUpdate:sql,model.name,model.news_id];
    
    if (!ret) {
        NSLog(@"%@",_fmdb.lastErrorMessage);
    }
    else{
        NSLog(@"**********更新成功*********");
    }
}


/**
 *  在插入和删除的时候判断
 *  @param flag 唯一的标识
 */
-(BOOL)isModelExistWithFlag:(NSString *)flag
{
    NSString *sql = @"select * from dataTable where news_id = ?";
    FMResultSet *rs = [_fmdb executeQuery:sql,flag];
    
    if ([rs next]) {
        return YES;
    }
    return NO;
    
}


-(NSString *)cachePath{
    
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray* urls = [fileManager URLsForDirectory:NSCachesDirectory
                                         inDomains:NSUserDomainMask];
    NSURL* cachesURL =[urls objectAtIndex:0];
    NSString* cachesPath = [cachesURL path];
    return cachesPath;
}

/**
 *  判断字符串是否为nil或者nil,或者null
 */
-(BOOL)isNilOrEmptyString:(NSString*)string
{
    if ([string isKindOfClass:[NSNull class]]) {
        NSLog(@"传入的字符串%@为NULL",string);
        return YES;
    }
    
    if ([string isEqualToString:@""] ) {
        NSLog(@"传入的字符串%@为空",string);
        return YES;
    }
    
    if (!string) {
        NSLog(@"传入的字符串%@为nil",string);
        return YES;
    }
    return NO;
}
@end
