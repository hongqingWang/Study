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
    dispatch_sync(dispatch_get_main_queue(), ^{
        
        NSLog(@"aaa");
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
