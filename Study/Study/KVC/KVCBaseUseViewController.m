//
//  KVCBaseUseViewController.m
//  Study
//
//  Created by 王红庆 on 2019/5/22.
//  Copyright © 2019 王红庆. All rights reserved.
//

#import "KVCBaseUseViewController.h"
#import "KVCPerson.h"

@interface KVCBaseUseViewController ()

@property (nonatomic, strong) KVCPerson *person;

@end

@implementation KVCBaseUseViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    KVCPerson *person = [[KVCPerson alloc] init];
//    [person setValue:@10 forKey:@"age"];
//    NSLog(@"person.age = %d", person.age);

    KVCPerson *person = [[KVCPerson alloc] init];
    person.age = 10;
    NSLog(@"person valueForKey = %@", [person valueForKey:@"age"]);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
//
//    UILabel *label = [[UILabel alloc] init];
//    label.text = @"点击屏幕";
//    label.font = [UIFont systemFontOfSize:24];
//    label.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:label];
//    label.frame = self.view.bounds;
}

@end
