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

@end

@implementation RunloopKeepThreadAliveViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.thread = [[RunloopThread alloc] initWithTarget:self selector:@selector(run) object:nil];
    [self.thread start];
}

#pragma mark - Event Response
/**
 * 线程保活
 */
- (void)run {
    
    NSLog(@"start - %s - %@", __FUNCTION__, [NSThread currentThread]);
    
    [[NSRunLoop currentRunLoop] addPort:[[NSPort alloc] init] forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] run];
    
    NSLog(@"end - %s - %@", __FUNCTION__, [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self performSelector:@selector(test) onThread:self.thread withObject:nil waitUntilDone:NO];
}

/**
 * 真正要执行的方法
 */
- (void)test {
    
    NSLog(@"%s - %@", __FUNCTION__, [NSThread currentThread]);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"看控制台输出";
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.frame = self.view.bounds;
}

@end
