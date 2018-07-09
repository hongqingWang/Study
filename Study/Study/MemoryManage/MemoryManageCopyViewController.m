//
//  MemoryManageCopyViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/9.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "MemoryManageCopyViewController.h"

@interface MemoryManageCopyViewController ()

@end

@implementation MemoryManageCopyViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    [self copyString];
    [self copyMutableString];
}

- (void)copyString {
    
    NSString *str = @"abc";
    
    NSString *str1 = [str copy];
    NSMutableString *str2 = [str mutableCopy];
    
    NSLog(@"str = %@ %p", str, str);
    NSLog(@"str1 = %@ %p", str1, str1);
    NSLog(@"str2 = %@ %p", str2, str2);
    
    // Attempt to mutate immutable object with appendString:
    //    [str1 appendString:@"123"];
    [str2 appendString:@"123"];
    
//    NSLog(@"str1 - appendString = %@", str1);
    NSLog(@"str2 - appendString = %@", str2);
}

- (void)copyMutableString {
    
    NSMutableString *str = [NSMutableString stringWithFormat:@"abc"];
    
    NSMutableString *str1 = [str copy];
    NSMutableString *str2 = [str mutableCopy];
    
    // 改变 str
    [str appendString:@"456"];
    
    NSLog(@"str = %@ %p", str, str);
    NSLog(@"str1 = %@ %p", str1, str1);
    NSLog(@"str2 = %@ %p", str2, str2);
    
    // [NSTaggedPointerString appendString:]: unrecognized selector sent to instance 0xa000000006362613
//    [str1 appendString:@"123"];
    [str2 appendString:@"123"];
    
//    NSLog(@"str1 - appendString = %@", str1);
    NSLog(@"str2 - appendString = %@", str2);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"abc"];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"看控制台输出";
//    label.text = mutableString;
//    [mutableString appendString:@"def"];
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.frame = self.view.bounds;
}

@end
