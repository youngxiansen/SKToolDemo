//
//  SKCaiPiao.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/4/15.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//

#import "SKCaiPiao.h"

@interface SKCaiPiao ()<UITableViewDelegate,UITableViewDataSource,UIWebViewDelegate,NSURLConnectionDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputNum;
@property (strong, nonatomic) UITableView* tableView;
@property(strong, nonatomic) NSMutableArray* dataArray;

@property (strong, nonatomic) UIWebView* webView;
@property (strong, nonatomic) NSURLConnection* urlConnection;
@property (assign, nonatomic) BOOL authenticated;
@property (strong, nonatomic) NSURLRequest* request;
@property (strong, nonatomic) NSMutableData* data;

@end

@implementation SKCaiPiao

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self initBaseData];
    
//    [self configTabelView];
    
    _data = [NSMutableData data];
    _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, kWidth, kHeight-64)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    _request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.google.com"]];
    
    [_webView loadRequest:_request];
    
    
    

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType;
{
    
    if (!_authenticated) {
        _authenticated = NO;
        
        _urlConnection = [[NSURLConnection alloc] initWithRequest:_request delegate:self];
        
        [_urlConnection start];
        
        return NO;
    }
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    // 102 == WebKitErrorFrameLoadInterruptedByPolicyChange
    NSLog(@"***********error:%@,errorcode=%d,errormessage:%@",error.domain,error.code,error.description);
    if (!([error.domain isEqualToString:@"WebKitErrorDomain"] && error.code ==102)) {
        //[self dismissWithError:error animated:YES];
    }
}

#pragma mark - NURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge;
{
    NSLog(@"WebController Got auth challange via NSURLConnection");
    
    if ([challenge previousFailureCount] ==0)
    {
        _authenticated =YES;
        
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        
    } else
    {
        [[challenge sender]cancelAuthenticationChallenge:challenge];
    }
}

-(void)connection:(NSURLConnection *)connection willSendRequestForAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        NSURL* baseURL = [NSURL URLWithString:@"https://www.google.com"];
        if ([challenge.protectionSpace.host isEqualToString:baseURL.host]) {
            NSLog(@"trusting connection to host %@", challenge.protectionSpace.host);
            [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
        } else
            NSLog(@"Not trusting connection to host %@", challenge.protectionSpace.host);
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse*)response;
{
    NSLog(@"WebController received response via NSURLConnection");
    
    // remake a webview call now that authentication has passed ok.
    _authenticated =YES;
    [_webView loadRequest:_request];
    
    // Cancel the URL connection otherwise we double up (webview + url connection, same url = no good!)
    [_urlConnection cancel];
}

// We use this method is to accept an untrusted site which unfortunately we need to do, as our PVM servers are self signed.
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    NSLog(@"challenge = %@",challenge.protectionSpace.serverTrust);
    //判断是否是信任服务器证书
    if (challenge.protectionSpace.authenticationMethod ==NSURLAuthenticationMethodServerTrust)
    {
        //创建一个凭据对象
        NSURLCredential *credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        //告诉服务器客户端信任证书
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    }
}


/**
 *  接收到服务器返回的数据时调用
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"接收到的数据%zd",data.length);
    [self.data appendData:data];
}
/**
 *  请求完毕
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *html = [[NSString alloc]initWithData:self.data encoding:NSUTF8StringEncoding];
    
    NSLog(@"请求完毕");
//    [self.webView loadHTMLString:html baseURL:self.url];
}


-(void)initBaseData
{
    self.view.backgroundColor = [UIColor whiteColor];
    _dataArray = [NSMutableArray array];
    
    [_dataArray addObjectsFromArray:[self getDecember2015]];
    [_dataArray addObjectsFromArray:[self getJanuary]];
    [_dataArray addObjectsFromArray:[self getFebruary]];
    [_dataArray addObjectsFromArray:[self getMarch]];
    [_dataArray addObjectsFromArray:[self getApril]];
    [_dataArray addObjectsFromArray:[self getMay]];
    
    //最新一期
    if (_dataArray.count) {
        NSDictionary* dic = [_dataArray lastObject];
        self.title = [NSString stringWithFormat:@"最新%@-期数%ld",dic[@"num"],_dataArray.count];
    }

    
    
    for (int i = 0; i < _dataArray.count-1; i++) {
        for (int j = 0; j < _dataArray.count-1-i; j++) {
            NSMutableDictionary* dic1 = [NSMutableDictionary dictionaryWithDictionary:_dataArray[j]];
            NSMutableDictionary* dic2 = [NSMutableDictionary dictionaryWithDictionary:_dataArray[j+1]];
            if ([dic1[@"num"] floatValue] > [dic2[@"num"] floatValue])
            {
                NSMutableDictionary* tempDic = [NSMutableDictionary dictionaryWithDictionary:[dic1 copy]];
                _dataArray[j] = [dic2 copy];
                _dataArray[j+1] = tempDic;
            }
            else if ([dic1[@"num"] floatValue] == [dic2[@"num"] floatValue]) {
                
                [dic1 setObject:@"1" forKey:@"color"];
                [_dataArray replaceObjectAtIndex:j withObject:[dic1 copy]];
                [dic2 setObject:@"1" forKey:@"color"];
                [_dataArray replaceObjectAtIndex:j+1 withObject:[dic2 copy]];
            }
        }
    }
    
    
    
}

-(void)configTabelView
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, kWidth, kHeight-114) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
    [_tableView reloadData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellid = @"SKCaipiaoCell";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
    }
    
    NSDictionary* dic = _dataArray[indexPath.row];
    cell.textLabel.text = dic[@"num"];
    cell.detailTextLabel.text = dic[@"date"];
    if ([dic[@"color"] isEqualToString:@"1"]) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else{
        cell.textLabel.textColor = [UIColor blackColor];
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

#pragma mark --月份数据--
-(NSArray*)getMay
{
    NSArray* arr = @[@{@"date":@"2016-05-01",
                       @"num":@"002"},
                     @{@"date":@"2016-05-02",
                       @"num":@"488"},
                     @{@"date":@"2016-05-03",
                       @"num":@"945"},
                     @{@"date":@"2016-05-04",
                       @"num":@"369"},
                     @{@"date":@"2016-05-05",
                       @"num":@"139"},
                     @{@"date":@"2016-05-06",
                       @"num":@"877"},
                     @{@"date":@"2016-05-07",
                       @"num":@"564"},
                     @{@"date":@"2016-05-08",
                       @"num":@"436"},
                     @{@"date":@"2016-05-09",
                       @"num":@"147"},
                     @{@"date":@"2016-05-10",
                       @"num":@"856"},
                     @{@"date":@"2016-05-11",
                       @"num":@"201"},
                     @{@"date":@"2016-05-12",
                       @"num":@"063"},
                     @{@"date":@"2016-05-13",
                       @"num":@"997"},
                     @{@"date":@"2016-05-14",
                       @"num":@"744"},
                     @{@"date":@"2016-05-15",
                       @"num":@"405"},
//                     @{@"date":@"2016-04-16",
//                       @"num":@"037"},
//                     @{@"date":@"2016-04-17",
//                       @"num":@"603"},
//                     @{@"date":@"2016-04-18",
//                       @"num":@"885"},
//                     @{@"date":@"2016-04-19",
//                       @"num":@"762"},
//                     @{@"date":@"2016-04-20",
//                       @"num":@"219"},
//                     @{@"date":@"2016-04-21",
//                       @"num":@"611"},
//                     @{@"date":@"2016-04-22",
//                       @"num":@"037"},
//                     @{@"date":@"2016-04-23",
//                       @"num":@"240"},
//                     @{@"date":@"2016-04-24",
//                       @"num":@"236"},
//                     @{@"date":@"2016-04-25",
//                       @"num":@"071"},
//                     @{@"date":@"2016-04-26",
//                       @"num":@"772"},
//                     @{@"date":@"2016-04-27",
//                       @"num":@"476"},
//                     @{@"date":@"2016-04-28",
//                       @"num":@"611"},
//                     @{@"date":@"2016-04-29",
//                       @"num":@"297"},
//                     @{@"date":@"2016-04-30",
//                       @"num":@"218"},
                     ];
    return arr;
}

-(NSArray*)getApril
{
    NSArray* arr = @[@{@"date":@"2016-04-01",
                       @"num":@"997"},
                     @{@"date":@"2016-04-02",
                       @"num":@"065"},
                     @{@"date":@"2016-04-03",
                       @"num":@"917"},
                     @{@"date":@"2016-04-04",
                       @"num":@"547"},
                     @{@"date":@"2016-04-05",
                       @"num":@"983"},
                     @{@"date":@"2016-04-06",
                       @"num":@"867"},
                     @{@"date":@"2016-04-07",
                       @"num":@"133"},
                     @{@"date":@"2016-04-08",
                       @"num":@"273"},
                     @{@"date":@"2016-04-09",
                       @"num":@"982"},
                     @{@"date":@"2016-04-10",
                       @"num":@"960"},
                     @{@"date":@"2016-04-11",
                       @"num":@"869"},
                     @{@"date":@"2016-04-12",
                       @"num":@"410"},
                     @{@"date":@"2016-04-13",
                       @"num":@"111"},
                     @{@"date":@"2016-04-14",
                       @"num":@"982"},
                     @{@"date":@"2016-04-15",
                       @"num":@"332"},
                     @{@"date":@"2016-04-16",
                       @"num":@"037"},
                     @{@"date":@"2016-04-17",
                       @"num":@"603"},
                     @{@"date":@"2016-04-18",
                       @"num":@"885"},
                     @{@"date":@"2016-04-19",
                       @"num":@"762"},
                     @{@"date":@"2016-04-20",
                       @"num":@"219"},
                     @{@"date":@"2016-04-21",
                       @"num":@"611"},
                     @{@"date":@"2016-04-22",
                       @"num":@"037"},
                     @{@"date":@"2016-04-23",
                       @"num":@"240"},
                     @{@"date":@"2016-04-24",
                       @"num":@"236"},
                     @{@"date":@"2016-04-25",
                       @"num":@"071"},
                     @{@"date":@"2016-04-26",
                       @"num":@"772"},
                     @{@"date":@"2016-04-27",
                       @"num":@"476"},
                     @{@"date":@"2016-04-28",
                       @"num":@"611"},
                     @{@"date":@"2016-04-29",
                       @"num":@"297"},
                     @{@"date":@"2016-04-30",
                       @"num":@"218"},
                     ];
    return arr;
}

-(NSArray*)getMarch
{
    NSArray* arr = @[@{@"date":@"2016-03-01",
                       @"num":@"736"},
                     @{@"date":@"2016-03-02",
                       @"num":@"323"},
                     @{@"date":@"2016-03-03",
                       @"num":@"665"},
                     @{@"date":@"2016-03-04",
                       @"num":@"764"},
                     @{@"date":@"2016-03-05",
                       @"num":@"119"},
                     @{@"date":@"2016-03-06",
                       @"num":@"078"},
                     @{@"date":@"2016-03-07",
                       @"num":@"686"},
                     @{@"date":@"2016-03-08",
                       @"num":@"675"},
                     @{@"date":@"2016-03-09",
                       @"num":@"477"},
                     @{@"date":@"2016-03-10",
                       @"num":@"491"},
                     @{@"date":@"2016-03-11",
                       @"num":@"455"},
                     @{@"date":@"2016-03-12",
                       @"num":@"016"},
                     @{@"date":@"2016-03-13",
                       @"num":@"455"},
                     @{@"date":@"2016-03-14",
                       @"num":@"445"},
                     @{@"date":@"2016-03-15",
                       @"num":@"013"},
                     @{@"date":@"2016-03-16",
                       @"num":@"995"},
                     @{@"date":@"2016-03-17",
                       @"num":@"789"},
                     @{@"date":@"2016-03-18",
                       @"num":@"530"},
                     @{@"date":@"2016-03-19",
                       @"num":@"299"},
                     @{@"date":@"2016-03-20",
                       @"num":@"972"},
                     @{@"date":@"2016-03-21",
                       @"num":@"951"},
                     @{@"date":@"2016-03-22",
                       @"num":@"637"},
                     @{@"date":@"2016-03-23",
                       @"num":@"606"},
                     @{@"date":@"2016-03-24",
                       @"num":@"782"},
                     @{@"date":@"2016-03-25",
                       @"num":@"467"},
                     @{@"date":@"2016-03-26",
                       @"num":@"390"},
                     @{@"date":@"2016-03-27",
                       @"num":@"670"},
                     @{@"date":@"2016-03-28",
                       @"num":@"150"},
                     @{@"date":@"2016-03-29",
                       @"num":@"748"},
                     @{@"date":@"2016-03-30",
                       @"num":@"234"},
                     @{@"date":@"2016-03-31",
                       @"num":@"023"},
                     ];
    
    return arr;
}

-(NSArray*)getFebruary
{
    NSArray* arr = @[@{@"date":@"2016-02-01",
                       @"num":@"555"},
                     @{@"date":@"2016-02-02",
                       @"num":@"002"},
                     @{@"date":@"2016-02-03",
                       @"num":@"102"},
                     @{@"date":@"2016-02-04",
                       @"num":@"051"},
                     @{@"date":@"2016-02-05",
                       @"num":@"258"},
                     @{@"date":@"2016-02-06",
                       @"num":@"624"},
                     @{@"date":@"2016-02-14",
                       @"num":@"823"},
                     @{@"date":@"2016-02-15",
                       @"num":@"503"},
                     @{@"date":@"2016-02-16",
                       @"num":@"047"},
                     @{@"date":@"2016-02-17",
                       @"num":@"720"},
                     @{@"date":@"2016-02-18",
                       @"num":@"729"},
                     @{@"date":@"2016-02-19",
                       @"num":@"944"},
                     @{@"date":@"2016-02-20",
                       @"num":@"012"},
                     @{@"date":@"2016-02-21",
                       @"num":@"612"},
                     @{@"date":@"2016-02-22",
                       @"num":@"126"},
                     @{@"date":@"2016-02-23",
                       @"num":@"132"},
                     @{@"date":@"2016-02-24",
                       @"num":@"337"},
                     @{@"date":@"2016-02-25",
                       @"num":@"618"},
                     @{@"date":@"2016-02-26",
                       @"num":@"140"},
                     @{@"date":@"2016-02-27",
                       @"num":@"102"},
                     @{@"date":@"2016-02-28",
                       @"num":@"792"},
                     @{@"date":@"2016-02-29",
                       @"num":@"447"},
                     ];
    
    return arr;
}

-(NSArray*)getJanuary
{
    NSArray* arr = @[@{@"date":@"2016-01-01",
                       @"num":@"828"},
                     @{@"date":@"2016-01-02",
                       @"num":@"567"},
                     @{@"date":@"2016-01-03",
                       @"num":@"573"},
                     @{@"date":@"2016-01-04",
                       @"num":@"543"},
                     @{@"date":@"2016-01-05",
                       @"num":@"439"},
                     @{@"date":@"2016-01-06",
                       @"num":@"101"},
                     @{@"date":@"2016-01-07",
                       @"num":@"174"},
                     @{@"date":@"2016-01-08",
                       @"num":@"967"},
                     @{@"date":@"2016-01-09",
                       @"num":@"648"},
                     @{@"date":@"2016-01-10",
                       @"num":@"823"},
                     @{@"date":@"2016-01-11",
                       @"num":@"461"},
                     @{@"date":@"2016-01-12",
                       @"num":@"530"},
                     @{@"date":@"2016-01-13",
                       @"num":@"019"},
                     @{@"date":@"2016-01-14",
                       @"num":@"925"},
                     @{@"date":@"2016-01-15",
                       @"num":@"686"},
                     @{@"date":@"2016-01-16",
                       @"num":@"841"},
                     @{@"date":@"2016-01-17",
                       @"num":@"861"},
                     @{@"date":@"2016-01-18",
                       @"num":@"646"},
                     @{@"date":@"2016-01-19",
                       @"num":@"883"},
                     @{@"date":@"2016-01-20",
                       @"num":@"693"},
                     @{@"date":@"2016-01-21",
                       @"num":@"402"},
                     @{@"date":@"2016-01-22",
                       @"num":@"744"},
                     @{@"date":@"2016-01-23",
                       @"num":@"041"},
                     @{@"date":@"2016-01-24",
                       @"num":@"091"},
                     @{@"date":@"2016-01-25",
                       @"num":@"500"},
                     @{@"date":@"2016-01-26",
                       @"num":@"403"},
                     @{@"date":@"2016-01-27",
                       @"num":@"729"},
                     @{@"date":@"2016-01-28",
                       @"num":@"262"},
                     @{@"date":@"2016-01-29",
                       @"num":@"225"},
                     @{@"date":@"2016-01-30",
                       @"num":@"988"},
                     @{@"date":@"2016-01-31",
                       @"num":@"457"},
                     ];

    return arr;
}

-(NSArray*)getDecember2015
{
    NSArray* arr = @[@{@"date":@"2015-12-01",
                       @"num":@"497"},
                     @{@"date":@"2015-12-02",
                       @"num":@"675"},
                     @{@"date":@"2015-12-03",
                       @"num":@"056"},
                     @{@"date":@"2015-12-04",
                       @"num":@"780"},
                     @{@"date":@"2015-12-05",
                       @"num":@"690"},
                     @{@"date":@"2015-12-06",
                       @"num":@"388"},
                     @{@"date":@"2015-12-07",
                       @"num":@"052"},
                     @{@"date":@"2015-12-08",
                       @"num":@"562"},
                     @{@"date":@"2015-12-09",
                       @"num":@"658"},
                     @{@"date":@"2015-12-10",
                       @"num":@"913"},
                     @{@"date":@"2015-12-11",
                       @"num":@"909"},
                     @{@"date":@"2015-12-12",
                       @"num":@"997"},
                     @{@"date":@"2015-12-13",
                       @"num":@"828"},
                     @{@"date":@"2015-12-14",
                       @"num":@"664"},
                     @{@"date":@"2015-12-15",
                       @"num":@"596"},
                     @{@"date":@"2015-12-16",
                       @"num":@"580"},
                     @{@"date":@"2015-12-17",
                       @"num":@"257"},
                     @{@"date":@"2015-12-18",
                       @"num":@"293"},
                     @{@"date":@"2015-12-19",
                       @"num":@"703"},
                     @{@"date":@"2015-12-20",
                       @"num":@"145"},
                     @{@"date":@"2015-12-21",
                       @"num":@"878"},
                     @{@"date":@"2015-12-22",
                       @"num":@"750"},
                     @{@"date":@"2015-12-23",
                       @"num":@"813"},
                     @{@"date":@"2015-12-24",
                       @"num":@"974"},
                     @{@"date":@"2015-12-25",
                       @"num":@"918"},
                     @{@"date":@"2015-12-26",
                       @"num":@"349"},
                     @{@"date":@"2015-12-27",
                       @"num":@"391"},
                     @{@"date":@"2015-12-28",
                       @"num":@"871"},
                     @{@"date":@"2015-12-29",
                       @"num":@"397"},
                     @{@"date":@"2015-12-30",
                       @"num":@"432"},
                     @{@"date":@"2015-12-31",
                       @"num":@"009"},
                     ];
    
    return arr;
}



@end
