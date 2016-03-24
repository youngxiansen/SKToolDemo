//
//  SKAMapTableVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKAMapTableVC.h"
#import "SKAMapVC.h"
#import "SKAMapSearchVC.h"
@interface SKAMapTableVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) NSArray* dataArray;

@end

@implementation SKAMapTableVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    [self initBaseData];
    
    [self configTabelView];
}

-(void)initBaseData
{
    self.title = @"地图工具";
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = @[@"地图",@"搜索"];
}

-(void)configTabelView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStylePlain];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _tableView.tableFooterView = [[UIView alloc]init];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"AMapCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    }
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            
            SKAMapVC* amapVC = [[SKAMapVC alloc]init];
            [self.navigationController pushViewController:amapVC animated:YES];

        }
        break;
        
        case 1:
        {
            
            SKAMapSearchVC* searchVC = [[SKAMapSearchVC alloc]init];
            [self.navigationController pushViewController:searchVC animated:YES];

        }
        break;
            
        default:
            break;
    }
    
}

@end
