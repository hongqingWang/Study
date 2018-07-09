//
//  MemoryManageCopyViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/9.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "MemoryManageCopyViewController.h"

@interface MemoryManageCopyViewController ()

@property (nonatomic, strong) NSString *myStrongString;
@property (nonatomic, copy) NSString *myCopyString;

@end

@implementation MemoryManageCopyViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    [self copyStringInstanceMethod];
//    [self copyMutableString];
//    [self test];
    [self testMutable];
}

- (void)copyStringInstanceMethod {
    
    NSString *str = @"abc";
    
    NSString *str1 = [str copy];
    NSMutableString *str2 = [str mutableCopy];
    
    NSLog(@"str = %@ %p", str, str);
    NSLog(@"str1 = %@ %p", str1, str1);
    NSLog(@"str2 = %@ %p", str2, str2);
    
    // Attempt to mutate immutable object with appendString:
    //    [str1 appendString:@"123"];
//    [str2 appendString:@"123"];
    [str1 stringByAppendingString:@"123"];
    [str2 stringByAppendingString:@"123"];
    
    NSLog(@"str1 - appendString = %@", str1);
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
//    [str2 appendString:@"123"];
    
    
    
    [str1 stringByAppendingString:@"123"];
    [str2 stringByAppendingString:@"123"];
    
    NSLog(@"str1 - appendString = %@", str1);
    NSLog(@"str2 - appendString = %@", str2);
}

- (void)test {
    
    //新创建两个NSString对象
    NSString * strong1 = @"I am Strong!";
    NSString * copy1 = @"I am Copy!";
    
    //初始化两个字符串
    self.myStrongString = strong1;
    self.myCopyString = copy1;
    
    //两个NSString进行操作
    [strong1 stringByAppendingString:@"11111"];
    [copy1 stringByAppendingString:@"22222"];
    
    NSLog(@"%@", strong1);
    NSLog(@"%@", self.myStrongString);
    NSLog(@"%@", copy1);
    NSLog(@"%@", self.myCopyString);
}

- (void)testMutable {
    
    NSMutableString *strong1 = [NSMutableString stringWithFormat:@"I am Strong!"];
    NSMutableString *copy1 = [NSMutableString stringWithFormat:@"I am Copy!"];
    
    //初始化两个字符串
    self.myStrongString = strong1;
    self.myCopyString = copy1;
    
    //两个NSString进行操作
//    [strong1 stringByAppendingString:@"11111"];
//    [copy1 stringByAppendingString:@"22222"];

    [strong1 appendString:@"111111"];
    [copy1 appendString:@"222222"];
    
    NSLog(@"%@", strong1);
    NSLog(@"%@", self.myStrongString);
    NSLog(@"%@", copy1);
    NSLog(@"%@", self.myCopyString);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"abc"];

    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:@"abc"];
    self.myStrongString = mutableString;
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"看控制台输出";
//    label.text = mutableString;
//    [mutableString appendString:@"def"];
    label.text = self.myStrongString;
    
    [mutableString appendString:@"def"];
    label.text = self.myStrongString;
    
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.frame = self.view.bounds;
}

@end
