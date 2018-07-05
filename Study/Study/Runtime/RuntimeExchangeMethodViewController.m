//
//  RuntimeExchangeMethodViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/5.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimeExchangeMethodViewController.h"

@interface RuntimeExchangeMethodViewController ()

@end

@implementation RuntimeExchangeMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Event Response

- (IBAction)buttonClick1:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}

- (IBAction)buttonClick2:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}

- (IBAction)buttonClick3:(UIButton *)sender {
    NSLog(@"%s", __FUNCTION__);
}
@end
