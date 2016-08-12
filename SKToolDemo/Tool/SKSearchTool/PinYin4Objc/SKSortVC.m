//
//  SKSortVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/7/20.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKSortVC.h"
#import "PinYin4Objc.h"
@interface SKSortVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) NSMutableArray* sectionHeadsKeys;
@property (strong, nonatomic) NSMutableArray* sortedArrForArrays;
@property (strong, nonatomic) UITableView* tableView;
@end


@implementation SKSortVC

-(NSMutableArray *)sortedArrForArrays{
    if (!_sortedArrForArrays) {
        _sortedArrForArrays = [NSMutableArray array];
    }
    return _sortedArrForArrays;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"排序";
    _sectionHeadsKeys = [NSMutableArray array];
    _dataArray =[NSMutableArray array];
    [_dataArray addObject:@"郭靖"];
    [_dataArray addObject:@"黄蓉"];
    [_dataArray addObject:@"杨过"];
    [_dataArray addObject:@"苗若兰"];
    [_dataArray addObject:@"令狐冲"];
    [_dataArray addObject:@"小龙女"];
    [_dataArray addObject:@"胡斐"];
    [_dataArray addObject:@"水笙"];
    [_dataArray addObject:@"任盈盈"];
    [_dataArray addObject:@"白琇"];
    [_dataArray addObject:@"狄云"];
    [_dataArray addObject:@"石破天"];
    [_dataArray addObject:@"殷素素"];
    [_dataArray addObject:@"张翠山"];
    [_dataArray addObject:@"张无忌"];
    [_dataArray addObject:@"青青"];
    [_dataArray addObject:@"袁冠南"];
    [_dataArray addObject:@"萧中慧"];
    [_dataArray addObject:@"袁承志"];
    [_dataArray addObject:@"乔峰"];
    [_dataArray addObject:@"王语嫣"];
    [_dataArray addObject:@"段玉"];
    [_dataArray addObject:@"虚竹"];
    [_dataArray addObject:@"苏星河"];
    [_dataArray addObject:@"丁春秋"];
    [_dataArray addObject:@"庄聚贤"];
    [_dataArray addObject:@"阿紫"];
    [_dataArray addObject:@"阿朱"];
    [_dataArray addObject:@"阿碧"];
    [_dataArray addObject:@"鸠魔智"];
    [_dataArray addObject:@"萧远山"];
    [_dataArray addObject:@"慕容复"];
    [_dataArray addObject:@"慕容博"];
    [_dataArray addObject:@"Jim"];
    [_dataArray addObject:@"Lily"];
    [_dataArray addObject:@"Ethan"];
    [_dataArray addObject:@"Green小"];
    [_dataArray addObject:@"Green大"];
    [_dataArray addObject:@"DavidSmall"];
    [_dataArray addObject:@"DavidBig"];
    [_dataArray addObject:@"James"];
    [_dataArray addObject:@"Kobe Brand"];
    [_dataArray addObject:@"Kobe Crand"];
    

    self.sortedArrForArrays = [self getSortArray];
    
    [self createTableView];
}

-(NSMutableArray*)getSortArray{
    //筛选的条件
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase;
    fmt.toneType = ToneTypeWithoutTone;
    fmt.vCharType = VCharTypeWithUUnicode;
    
    //    // 1.拼音  把所有的要查找的字段都转成拼音之后和输入的拼音做比较
    NSMutableArray *TempArrForGrouping = nil;
    BOOL checkValueAtIndex= NO;
    
//    NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"pinYin" ascending:YES]];
//    [chineseStringsArray sortUsingDescriptors:sortDescriptors];
    
    NSMutableArray* arrayForArrays=[NSMutableArray array];
    for (int i = 0; i < _dataArray.count; i++) {
        NSString* pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:_dataArray[i] withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
        NSArray* words = [pinyin componentsSeparatedByString:@"#"];
        
        NSString* firstLetter = [[words firstObject] substringToIndex:1];
        kkLogRedColor(@"%@",firstLetter);
        if(![_sectionHeadsKeys containsObject:firstLetter])//here I'm checking whether the character already in the selection header keys or not
        {
            [_sectionHeadsKeys addObject:firstLetter];
            TempArrForGrouping = [[NSMutableArray alloc]init];
            checkValueAtIndex = NO;
        }
        
        if([_sectionHeadsKeys containsObject:firstLetter])
        {
            [TempArrForGrouping addObject:[_dataArray objectAtIndex:i]];
            if(checkValueAtIndex == NO)
            {
                [arrayForArrays addObject:TempArrForGrouping];
                checkValueAtIndex = YES;
            }
        }
    }
    
    NSLog(@"---%@",arrayForArrays);
    return arrayForArrays;

}

#pragma mark --tableView--
- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    [self.view addSubview:_tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [[self.sortedArrForArrays objectAtIndex:section] count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.sortedArrForArrays count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [_sectionHeadsKeys objectAtIndex:section];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return self.sectionHeadsKeys;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellId = @"CellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if ([self.sortedArrForArrays count] > indexPath.section) {
        NSArray *arr = [self.sortedArrForArrays objectAtIndex:indexPath.section];
        if ([arr count] > indexPath.row) {
           
            cell.textLabel.text = arr[indexPath.row];
        } else {
            NSLog(@"arr out of range");
        }
    } else {
        NSLog(@"sortedArrForArrays out of range");
    }
    
    return cell;
}


@end
