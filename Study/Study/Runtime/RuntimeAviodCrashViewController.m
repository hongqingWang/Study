//
//  RuntimeAviodCrashViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/4.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimeAviodCrashViewController.h"
#import "RuntimeAviodCrash.h"

@interface RuntimeAviodCrashViewController ()

@end

@implementation RuntimeAviodCrashViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    RuntimeAviodCrash *aviodCrash = [[RuntimeAviodCrash alloc] init];
    [aviodCrash noImplementationInstanceMethod];
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
