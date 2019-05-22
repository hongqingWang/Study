//
//  KVCSetYuanLiViewController.m
//  Study
//
//  Created by 王红庆 on 2019/5/22.
//  Copyright © 2019 王红庆. All rights reserved.
//

#import "KVCSetYuanLiViewController.h"
#import "KVCPerson.h"

@interface KVCSetYuanLiViewController ()

@property (nonatomic, strong) KVCPerson *person;

@end

@implementation KVCSetYuanLiViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
//    KVCPerson *person = [[KVCPerson alloc] init];
//
//    NSKeyValueObservingOptions optinons = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
//    [person addObserver:self forKeyPath:@"age" options:optinons context:nil];
//    [person setValue:@(10) forKey:@"age"];
    
    KVCPerson *person = [[KVCPerson alloc] init];
    NSKeyValueObservingOptions optinons = NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew;
    [person addObserver:self forKeyPath:@"age" options:optinons context:nil];
    [person setValue:@(10) forKey:@"age"];
//    NSLog(@"aaa");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%@", change);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
}

@end
