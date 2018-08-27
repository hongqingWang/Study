//
//  ThreadBarrierViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/16.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "ThreadBarrierViewController.h"

@interface ThreadBarrierViewController ()

@end

@implementation ThreadBarrierViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    /**
     * 下面代码会造成死锁
     */
//    dispatch_sync(dispatch_get_main_queue(), ^{
//
//        NSLog(@"aaa");
//    });
    
//    NSLog(@"1");
//
//    NSLog(@"1 - %@", [NSThread currentThread]);
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSLog(@"2");
//        NSLog(@"2 - %@", [NSThread currentThread]);
//
//        dispatch_sync(dispatch_get_main_queue(), ^{
//            NSLog(@"3");
//            NSLog(@"3 - %@", [NSThread currentThread]);
//        });
//
//        NSLog(@"4");
//        NSLog(@"4 - %@", [NSThread currentThread]);
//    });
//
//    NSLog(@"5");
//    NSLog(@"5 - %@", [NSThread currentThread]);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"1");
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"2");
        });
        
        NSLog(@"3");
    });
    
    NSLog(@"4");
    
    while (1) {

    }

    NSLog(@"5");
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
