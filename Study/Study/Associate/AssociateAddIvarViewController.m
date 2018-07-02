//
//  AssociateAddIvarViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/2.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "AssociateAddIvarViewController.h"
#import "AssociatePerson.h"
#import "AssociatePerson+Category.h"

@interface AssociateAddIvarViewController ()

@end

@implementation AssociateAddIvarViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    AssociatePerson *person = [[AssociatePerson alloc] init];
    person.age = 10;
    // [AssociatePerson setName:]: unrecognized selector sent to instance 0x600000001f60'
//    person.name = @"wanghongqing";
    person.name = @"wanghongqing";
    
    NSLog(@"%d", person.age);
    NSLog(@"%@", person.name);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
