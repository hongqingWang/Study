//
//  KVCGetYuanLiViewController.m
//  Study
//
//  Created by 王红庆 on 2019/5/22.
//  Copyright © 2019 王红庆. All rights reserved.
//

#import "KVCGetYuanLiViewController.h"
#import "KVCPerson.h"

@interface KVCGetYuanLiViewController ()

@end

@implementation KVCGetYuanLiViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    KVCPerson *person = [[KVCPerson alloc] init];
    [person setValue:@(10) forKey:@"age"];
//    person->_age = 10;
    /**
     * 取值按照下列顺序
     * - getKey
     * - key
     * - isKey
     * - _key
     */
    NSLog(@"%@", [person valueForKey:@"age"]);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
