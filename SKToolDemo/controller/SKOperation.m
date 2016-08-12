//
//  SKOperation.m
//  SKToolDemo
//
//  Created by youngxiansen on 16/3/29.
//  Copyright © 2016年 youngxiansen. All rights reserved.
//
#define KKLOG_Thread(str) NSLog(@"*********%@##########%@",str,[NSThread currentThread])
#import "SKOperation.h"

@interface SKOperation ()

@end

@implementation SKOperation

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"多线程的实例";
    
    
//    [self operationQueue];
    
//    [self oprationQueueDepend];
    
//    不能单独使用,否则还是在主线程
//    [self nsInvocationOperation];
    
//    [self blockOperation];
    
//    以下是学习中的总结
    
//    [self uiThread];
    
//    效率慢不推荐使用
//    [self nsThread];
    
    [self GCDOperation];
    
    
}

/**
 *  最简单的用法
 */
-(void)operationQueue
{
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    [queue addOperationWithBlock:^{
        //做自己的事情
        for (int i = 0; i < 100; i++) {
            NSLog(@"---%d",i);
        }
    }];
    NSLog(@"*******你好******");

}



/**
 *  奇怪没打印
 */
-(void)blockOperation
{
    /**
     
     通过三次不同结果的比较，我们可以看到，NSBlockOperation确实实现了多线程。但是我们可以看到，它并非是将所有的block都放到放到了子线程中。通过上面的打印记录我们可以发现，它会优先将block放到主线程中执行，若主线程已有待执行的代码，就开辟新的线程，但最大并发数为4（包括主线程在内）。如果block数量大于了4，那么剩下的Block就会等待某个线程空闲下来之后被分配到该线程，且依然是优先分配到主线程。
     另外，同一个block中的代码是同步执行的
     
     我们可以看到，最大并发数为4，使用同一个线程的block一定是等待前一个block的代码全部执行结束后才执行，且同步执行。
     关于最大并发数
     在刚才的结果中我们看到最大并发数为4，但这个值并不是一个固定值。4是我在模拟器上运行的结果，而如果我使用真机来跑的话，最大并发数始终为2。因此，具体的最大并发数和运行环境也是有关系的。我们不必纠结于这个数字
     */
    NSBlockOperation* blockOperation =[NSBlockOperation blockOperationWithBlock:^{
        KKLOG_Thread(@"A");
    }];
    
    [blockOperation addExecutionBlock:^{
        KKLOG_Thread(@"B");
    }];
    
    [blockOperation addExecutionBlock:^{
        KKLOG_Thread(@"C");
    }];
    
    [blockOperation addExecutionBlock:^{
        KKLOG_Thread(@"D");
    }];
    
    [blockOperation addExecutionBlock:^{
        KKLOG_Thread(@"E");
    }];
}


/**
 *   NSOperationQueue最吸引人的无疑是它的添加依赖的功能。
 */
-(void)oprationQueueDepend
{
    NSInvocationOperation* invocationA = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testTReadA) object:nil];
     NSInvocationOperation* invocationB = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testTReadB) object:nil];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    //    B依赖于A，那么在A执行结束之前，B永远不会执行   一定要先添加依赖
    [invocationB addDependency:invocationA];
    [queue addOperation:invocationB];
    [queue addOperation:invocationA];

    
}

#pragma mark --学习中的总结--

/**
 *  1UI封装的
 */
-(void)uiThread
{
    [self performSelectorInBackground:@selector(testTReadA) withObject:nil];
    [self performSelectorInBackground:@selector(testTReadB) withObject:nil];
    [self performSelectorInBackground:@selector(testTReadC) withObject:nil];
    [self delayTHing];
    
}

/**
 *  2所有三种方法里面,效率最慢的
 */
-(void)nsThread
{
    //用类方法创建,直接运行
    [NSThread detachNewThreadSelector:@selector(testTReadA) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(testTReadB) toTarget:self withObject:nil];
    //使用对象
    NSThread *th = [[NSThread alloc]initWithTarget:self selector:@selector(testTReadC) object:nil];
    //必须手动触发
    [th start];
    
    [self delayTHing];
    
}

/**
 *  3NSInvocationOperation 单独使用还是放在主线程,要后台执行必须放在线程队里
 */
-(void)nsInvocationOperation
{
    NSInvocationOperation * invo = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testTReadA) object:nil];
    //执行
    //    [invo start];
    
    NSInvocationOperation * invo2 = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(testTReadB) object:nil];
    //执行
    //    [invo2 start];
    
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    [queue addOperation:invo];
    [queue addOperation:invo2];
    
}

#pragma mark --以下是GCD的用法--

-(void)GCDOperation
{
//    [self GCDBase];
    
//    [self GCDStandard];
    
//    [self GCDApply];
    
    [self GCDGroup];
}

/**
 *  基本的方法
 *  最好的就是创建异步队列,异步的添加任务
 */
-(void)GCDBase
{
    //创建一个线程队列
    //第一个参数是名字,作为当前的线程队列的一个标识
    //第二个参数,指定当前的线程队列是什么类型的:同步还是异步
    //DISPATCH_QUEUE_CONCURRENT:异步队列
    //DISPATCH_QUEUE_SERIAL:同步队列
    dispatch_queue_t qt = dispatch_queue_create("com.joyskim", DISPATCH_QUEUE_CONCURRENT);
    
    //异步将一个任务加到线程队列中
    dispatch_async(qt, ^{
        [self testTReadA];
    });
    //同步加入
    dispatch_async(qt, ^{
        [self testTReadB];
    });
    
    //同步加入
    dispatch_async(qt, ^{
        [self testTReadC];
    });
    [self delayTHing];
    /*
     同步地将任务加入到异步队列,是按同步地方式执行
     异步地将任务加入到同步队列,是按同步地方式执行
     要想异步执行多个任务,必须'异'步地将任务加入到'异'步的队列
     */
}

-(void)GCDStandard
{
    //常用的方式:
    //先开辟一个子线程,执行任务,任务执行完成以后,回到主线程刷新UI
    
    //dispatch_get_global_queue(0, 0)
    //获取到一个系统自带的全局的子线程
    //第一个参数0:表示默认优先级
    //优先级有四个2,0,-2,INT16_MIN
    
    //dispatch_get_main_queue():获取到主线程:同步
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        
        //做子线程的工作:耗时的工作
        KKLOG_Thread(@"A");
        dispatch_async(dispatch_get_main_queue(), ^{
            KKLOG_Thread(@"b");
            //主线程的工作,刷新UI
        });
    });
    [self delayTHing];
    
}

/**
 *  同时开辟N个线程
 */
-(void)GCDApply
{
    NSLog(@"---%@",[NSDate date]);
//    NSMutableArray *dataArray = [[NSMutableArray alloc]init];
//    for (int i = 0; i<100; i++) {
//        [dataArray addObject:@""];
//        //针对模型做某些操作,如果特别耗时:1s
//        //        sleep(1);
//    }
//    其实最多开的就是四个线程
    dispatch_apply(100, dispatch_get_global_queue(0, 0), ^(size_t n) {
        sleep(1);
    });
    NSLog(@"%@",[NSDate date]);
}

/**
 *  线程组监视一组线程的完成,在这一组线程里面的所有任务执行完成以后,再执行另外一个任务
 */
-(void)GCDGroup
{
    //线程组
    dispatch_group_t gt = dispatch_group_create();
    //线程队列
    dispatch_queue_t qt = dispatch_queue_create("com", DISPATCH_QUEUE_CONCURRENT);
    
    //将任务放到线程组里面进行管理gt
    //这个任务要想执行必须放到一个线程队列中,所以需要qt
    dispatch_group_async(gt, qt, ^{
        [self testTReadA];
    });
    
    dispatch_async(qt, ^{
        sleep(10);
        NSLog(@"---------------");
    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        sleep(6);
        NSLog(@"================");
    });
    
//    先执行组1 在执行组2
    dispatch_queue_t qt2 = dispatch_queue_create("d", DISPATCH_QUEUE_SERIAL);
    dispatch_group_async(gt, qt2, ^{
        sleep(10);
        NSLog(@"10--sleep");
    });
    dispatch_group_async(gt, qt2, ^{
        sleep(10);
        NSLog(@"10--sleep2");
    });
    
    dispatch_group_async(gt, dispatch_get_global_queue(0, 0), ^{
        [self testTReadB];
    });
    

    
    //线程组中的所有任务全部执行完成以后执行此任务
    dispatch_group_notify(gt, qt, ^{
        NSLog(@"----结束了-----");
    });
    
}

-(void)testTReadA
{
    KKLOG_Thread(@"AAA");
}

-(void)testTReadB
{
    KKLOG_Thread(@"BBB");
}

-(void)testTReadC{
    KKLOG_Thread(@"CCC");
}

-(void)delayTHing
{
    for (int i = 0; i < 500; i++) {
        NSLog(@"---%d",i);
    }

}





@end
