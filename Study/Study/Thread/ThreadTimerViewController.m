//
//  ThreadTimerViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/19.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "ThreadTimerViewController.h"

@interface ThreadTimerViewController ()

@end

@implementation ThreadTimerViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    /**
     * 输出
     * 1
     * 3
     */
//    [self test1];
    
    /**
     * 输出
     * 1
     * 3
     * 2 (每隔两秒钟执行一次)
     */
//    [self test2];
    
//    [self test3];
    [self test4];
}

- (void)test1 {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"1");
        
        [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"2");
        }];
        
        NSLog(@"3");
    });
}

- (void)test2 {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"1");
        
        [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"2");
        }];
        
        NSLog(@"3");
        /**
         * timer 源码是在 Runloop 里, 相当于被添加到子线程的 Runloop, 但子线程的 Runloop 默认是不开启的,
         需要我们手动开启。
         */
//        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    });
}

- (void)test3 {
    
    NSThread *thread = [[NSThread alloc] initWithBlock:^{
        NSLog(@"1");
        
        /**
         * 加上这句就不会崩溃了
         */
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    }];
    [thread start];
    
    /**
     * [ThreadTimerViewController performSelector:onThread:withObject:waitUntilDone:modes:]: target thread exited while waiting for the perform
     * 执行`test`方法时, 线程已经退出了
     */
    [self performSelector:@selector(test) onThread:thread withObject:nil waitUntilDone:YES];
}

- (void)test {
    
    NSLog(@"2");
}

- (void)test4 {
    
    /**
     * 等待任务1和任务2执行完毕后
     * 再回到主线程执行任务3
     */
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("my_queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务1 - %d %@", i, [NSThread currentThread]);
        }
    });
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务2 - %d %@", i, [NSThread currentThread]);
        }
    });
    dispatch_group_async(group, dispatch_get_main_queue(), ^{
        for (int i = 0; i < 5; i++) {
            NSLog(@"任务3 - %d %@", i, [NSThread currentThread]);
        }
    });
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"停止线程" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 100, 35);
    //    [button addTarget:self action:@selector(stopThread) forControlEvents:UIControlEventTouchUpInside];
}

@end
