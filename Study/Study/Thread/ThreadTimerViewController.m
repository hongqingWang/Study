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
    [self test2];
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
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
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