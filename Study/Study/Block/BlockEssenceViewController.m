//
//  BlockEssenceViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/2.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "BlockEssenceViewController.h"

@interface BlockEssenceViewController ()

@end

@implementation BlockEssenceViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    void (^block)(void) = ^{
        
        NSLog(@"hello world");
    };
    
    // __NSGlobalBlock__
    NSLog(@"%@", [block class]);
    // __NSGlobalBlock
    NSLog(@"%@", [[block class] superclass]);
    // NSBlock
    NSLog(@"%@", [[[block class] superclass] superclass]);
    // NSObject
    NSLog(@"%@", [[[[block class] superclass] superclass] superclass]);
    
    int a = 10;
    void (^block2)(void) = ^{
        
        NSLog(@"a is %d", a);
    };
    
    // __NSGlobalBlock__
    NSLog(@"%@", [block class]);
    
    // __NSMallocBlock__
    NSLog(@"%@", [block2 class]);
    
    // __NSStackBlock__
    NSLog(@"%@", [^{
        NSLog(@"%d", a);
    } class]);
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
