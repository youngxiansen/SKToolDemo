//
//  SKSearchToolVC.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/24.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKSearchToolVC.h"
#import "PinYin4Objc.h"
@interface SKSearchToolVC ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray* dataArray;
@property (strong, nonatomic) NSMutableArray* showArray;
@property (strong, nonatomic) NSMutableArray* searchArray;
@property (strong, nonatomic) UITableView* tableView;
@property (strong, nonatomic) UITextField* searchTF;

@end

@implementation SKSearchToolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"搜索";
    
    [self initBaseData];
    
    [self configTabelView];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(searchTFDidChange) name:UITextFieldTextDidChangeNotification object:_searchTF];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:_searchTF];
}

-(void)initBaseData
{
    self.view.backgroundColor = [UIColor whiteColor];
    NSArray* arr = @[@"你是谁",@"13056988912",@"静静",@"ABC",@"北京"];
    
    _dataArray = [NSMutableArray arrayWithArray:arr];
    _showArray = [NSMutableArray array];
    _searchArray = [NSMutableArray array];
    
    _showArray = _dataArray;
    
    _searchTF = [[UITextField alloc]init];
    _searchTF.frame = CGRectMake(20, 64+10, kWidth-40, 44);
    _searchTF.borderStyle = UITextBorderStyleNone;
    _searchTF.placeholder = @"搜索内容";
    _searchTF.returnKeyType = UIReturnKeyDone;
    _searchTF.backgroundColor = [UIColor lightGrayColor];
    
    [_searchTF addTarget:self action:@selector(startSearch) forControlEvents:UIControlEventEditingDidEnd|UIControlEventEditingDidEndOnExit];
    [self.view addSubview:_searchTF];
}

-(void)configTabelView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_searchTF.frame)+10, kWidth, kHeight-CGRectGetMaxY(_searchTF.frame)+10) style:UITableViewStylePlain];

//    _tableView.backgroundColor = [UIColor redColor];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"SKSearchToolCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    
    if (_showArray.count) {
       cell.textLabel.text = _showArray[indexPath.row];
    }
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _showArray.count;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

#pragma mark --搜索相关--
-(void)startSearch
{
    
}

#pragma mark --搜索--
-(void)searchTFDidChange
{
    if ([NSString isNilOrEmptyString:self.searchTF.text]) {
        _showArray = _dataArray;
        [_tableView reloadData];
        return;
    }
    
    
    [_searchArray removeAllObjects];
    
    for (int i = 0; i < _dataArray.count; i++)
    {
        NSString* str = _dataArray[i];
        if ([self isFindObject:str searchTF:_searchTF]) {
            [_searchArray addObject:_dataArray[i]];
            continue;
        }
        if([str rangeOfString:_searchTF.text].location !=NSNotFound)
        {
            [_searchArray addObject:_dataArray[i]];
        }
    }
    _showArray = _searchArray;
    [_tableView reloadData];
    
}

/**
 *  根据拼音、首字母、全拼、汉字查找
 *  @param string   要查找遍历的字段
 *  @param searchTF 输入的字段
 */
-(BOOL)isFindObject:(NSString*)string searchTF:(UITextField*)searchTF
{
    //筛选的条件
    HanyuPinyinOutputFormat *fmt = [[HanyuPinyinOutputFormat alloc] init];
    fmt.caseType = CaseTypeUppercase;
    fmt.toneType = ToneTypeWithoutTone;
    fmt.vCharType = VCharTypeWithUUnicode;
    
    // 1.拼音  把所有的要查找的字段都转成拼音之后和输入的拼音做比较
    NSString* pinyin = [PinyinHelper toHanyuPinyinStringWithNSString:string withHanyuPinyinOutputFormat:fmt withNSString:@"#"];
    
    //2拼音首字母
    NSArray* words = [pinyin componentsSeparatedByString:@"#"];
    NSMutableString* headerString = [NSMutableString string];
    
    //3拼音的全部
    pinyin = [pinyin stringByReplacingOccurrencesOfString:@"#" withString:@""];
    
    for (NSString* str in words)
    {
        [headerString appendString:[str substringToIndex:1]];
        
    }
    
    if([string rangeOfString:_searchTF.text].location !=NSNotFound ||[string rangeOfString:_searchTF.text].length != 0||[headerString rangeOfString:_searchTF.text.uppercaseString].length != 0||[pinyin rangeOfString:_searchTF.text.uppercaseString].length != 0)
    {
        return  YES;
    }
    return NO;
}



@end
