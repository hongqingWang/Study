//
//  RunloopKeepThreadAliveViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/5.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RunloopKeepThreadAliveViewController.h"
#import "RunloopThread.h"

@interface RunloopKeepThreadAliveViewController ()

@property (nonatomic, strong) RunloopThread *thread;
@property (nonatomic, assign, getter=isStopped) BOOL stopped;

@end

@implementation RunloopKeepThreadAliveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    __weak typeof(self) weakSelf = self;
    self.thread = [[RunloopThread alloc] initWithBlock:^{
        
        NSLog(@"start - %s - %@", __FUNCTION__, [NSThread currentThread]);
        
        [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
        
        while (weakSelf && !weakSelf.isStopped) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
        }
        
        NSLog(@"end - %s - %@", __FUNCTION__, [NSThread currentThread]);
    }];
    [self.thread start];
}

- (void)dealloc {
    NSLog(@"%s", __FUNCTION__);
    [self stopThread];
}

#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

/**
 * 真正要执行的方法
 */
- (void)test {
    
    NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
}

/**
 * button 点击方法
 */
- (void)stopThread {
    
    [self performSelector:@selector(stopSubThread) onThread:self.thread withObject:nil waitUntilDone:YES];
}

/**
 * 停止Runloop
 */
- (void)stopSubThread {
    
    self.stopped = YES;
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"停止线程" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.frame = CGRectMake(100, 100, 100, 35);
    [button addTarget:self action:@selector(stopThread) forControlEvents:UIControlEventTouchUpInside];
}

@end
