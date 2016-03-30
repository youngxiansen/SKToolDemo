//
//  SKSQliteVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/30.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKSQliteVC.h"
#import "SKFMDBTool.h"
@interface SKSQliteVC ()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic) SKFMDBTool* fmdb;
@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) UITableView* tableView;

@end

@implementation SKSQliteVC

-(SKFMDBTool *)fmdb
{
    if (!_fmdb) {
        _fmdb = [SKFMDBTool shareManager];
    }
    return _fmdb;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    [self initBaseData];
    
    [self configTabelView];
}

-(void)addModel
{
    
    dataModel* model = [[dataModel alloc]init];
    model.name = @"呵呵";
    model.news_id = [NSString stringWithFormat:@"%d",arc4random()%30];
    [self.fmdb insertModel:model];
    
    _dataArray = [self.fmdb fetchAll];
    [_tableView reloadData];
}

-(void)deletModel
{
    dataModel* model = [[dataModel alloc]init];
    model.name = @"呵呵";
    model.news_id = [NSString stringWithFormat:@"%d",arc4random()%30];
    [self.fmdb deleteModelWithFlag:model.news_id];
    _dataArray = [self.fmdb fetchAll];
    [_tableView reloadData];
}

-(void)initBaseData
{
    self.title = @"SQLite";
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    
    [self setNavigationItemEventWithTitle:@"添加模型" action:@selector(addModel) type:SKItemTypeLeftTitle itemImgName:@""];
    [self setNavigationItemEventWithTitle:@"删除模型" action:@selector(deletModel) type:SKItemTypeRightTitle itemImgName:@""];
    
    _dataArray = [self.fmdb fetchAll];
    [_tableView reloadData];

}

-(void)configTabelView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"SKFMDBCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    if (_dataArray.count) {
        dataModel* model = _dataArray[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@***%@",model.name,model.news_id];
    }
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
