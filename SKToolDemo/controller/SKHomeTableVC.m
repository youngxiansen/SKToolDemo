//
//  SKHomeTableVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/23.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKHomeTableVC.h"
#import "SKCatogyVC.h"
#import "SKNetworkVC.h"
#import "SKAlertVC.h"
#import "SKAMapTableVC.h"
#import "SKClassExtensionVC.h"
#import "SKSearchToolVC.h"
@interface SKHomeTableVC ()<UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray* dataArray;

@end

@implementation SKHomeTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initInfo];
}

-(void)initInfo
{
    self.title = @"工具类";
    _tableView.tableFooterView = [[UIView alloc]init];
    _dataArray = @[@"分类",@"网络",@"自定义提示框",@"高德地图",@"类扩展",@"搜索"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"SKUITableViewCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
        cell.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1];
    }
    
    if (_dataArray.count) {
        cell.textLabel.text = _dataArray[indexPath.row];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.row) {
        case 0:
        {
            SKCatogyVC* catogy = [[SKCatogyVC alloc]init];
            [self.navigationController pushViewController:catogy animated:YES];
        }
        break;
            
        case 1:
        {
            
            SKNetworkVC* network = [[SKNetworkVC alloc]init];
            [self.navigationController pushViewController:network animated:YES];

        }
        break;
            
        case 2:
        {
            
            SKAlertVC* alert = [[SKAlertVC alloc]init];
            [self.navigationController pushViewController:alert animated:YES];

        }
        break;
            
        case 3:
        {
            
            SKAMapTableVC* amapTB = [[SKAMapTableVC alloc]init];
            [self.navigationController pushViewController:amapTB animated:YES];

        }
        break;
            
        case 4:
        {
            
            
            SKClassExtensionVC* classExtension = [[SKClassExtensionVC alloc]init];
            [self.navigationController pushViewController:classExtension animated:YES];
        }
            break;
        case 5:
        {
            
            SKSearchToolVC* search = [[SKSearchToolVC alloc]init];
            [self.navigationController pushViewController:search animated:YES];

        }
            break;
            
        default:
            break;
    }

}

@end
