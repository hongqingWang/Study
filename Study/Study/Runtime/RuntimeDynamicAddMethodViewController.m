//
//  RuntimeDynamicAddMethodViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/4.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimeDynamicAddMethodViewController.h"

@interface RuntimeDynamicAddMethodViewController ()

@end

@implementation RuntimeDynamicAddMethodViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    int age = 10;
    
    void (^block)(void) = ^{
        
        // age is 10
        NSLog(@"age is %d", age);
    };
    
    age = 20;
    
    // block outside age is 20
    NSLog(@"block outside age is %d", age);
    
    block();
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
