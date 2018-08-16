//
//  RetainCountStringSecondViewController.m
//  Study
//
//  Created by 王红庆 on 2018/8/16.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RetainCountStringSecondViewController.h"

@interface RetainCountStringSecondViewController () {
    
    __weak NSString *string01;
}

@end

@implementation RetainCountStringSecondViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%s", __FUNCTION__);
    
    /*
     string02 = 123
     - retainCount = 1152921504606846975
     string02 = 123adasdasdasdasdasdadsadsasdasd
     - retainCount = 1152921504606846975
     */
    NSString *string02 = @"123";
    //    NSString *string02 = @"123adasdasdasdasdasdadsadsasdasd";
    /*
     string02 = 123
     - retainCount = 9223372036854775807
     string02 = 123adasdasdasdasdasdadsadsasdasd
     - retainCount = 1
     */
    //    NSString *string02 = [[NSString alloc] initWithFormat:@"123"];
    //    NSString *string02 = [[NSString alloc] initWithFormat:@"123adasdasdasdasdasdadsadsasdasd"];
    
    NSLog(@"string02 retainCount = %ld", (long)CFGetRetainCount((__bridge CFTypeRef)(string02)));
    
    string01 = string02;
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    /*
     string02 = 123
     - string01 = 123
     string02 = 123adasdasdasdasdasdadsadsasdasd
     - string01 = (null)
     */
    NSLog(@"%s - string01 = %@", __FUNCTION__, string01);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    /*
     string02 = 123
     - string01 = 123
     string02 = 123adasdasdasdasdasdadsadsasdasd
     - string01 = (null)
     */
    NSLog(@"%s - string01 = %@", __FUNCTION__, string01);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"请看控制台输出";
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.frame = self.view.bounds;
}

@end
