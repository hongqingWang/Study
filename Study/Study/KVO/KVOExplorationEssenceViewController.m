//
//  KVOExplorationEssenceViewController.m
//  Study
//
//  Created by 王红庆 on 2018/6/29.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "KVOExplorationEssenceViewController.h"
#import "Person.h"
#import <objc/runtime.h>

@interface KVOExplorationEssenceViewController ()

@property (nonatomic, strong) Person *person1;
@property (nonatomic, strong) Person *person2;

@end

@implementation KVOExplorationEssenceViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.person1 = [[Person alloc] init];
    self.person1.age = 1;

    self.person2 = [[Person alloc] init];
    self.person2.age = 2;
    
    // person1 监听之前 - Person, Person
//    NSLog(@"person1 监听之前 - %@, %@", object_getClass(self.person1), object_getClass(self.person2));

    // person1 监听之前 - 0x10abbb140, 0x10abbb140
    NSLog(@"person1 监听之前 - %p, %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person1 addObserver:self forKeyPath:@"age" options:options context:nil];

    // person1 监听之后 - NSKVONotifying_Person, Person
//    NSLog(@"person1 监听之后 - %@, %@", object_getClass(self.person1), object_getClass(self.person2));
    
    // person1 监听之后 - 0x10af64f8e, 0x10abbb140
    NSLog(@"person1 监听之后 - %p, %p", [self.person1 methodForSelector:@selector(setAge:)], [self.person2 methodForSelector:@selector(setAge:)]);
}

- (void)dealloc {
    [self.person1 removeObserver:self forKeyPath:@"age"];
}

#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    // isa -> NSKVONotifying_Person
    self.person1.age = 10;
    // isa -> Person
    self.person2.age = 20;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"keyPath = %@", keyPath);
    NSLog(@"change = %@", change);
    NSLog(@"context = %@", context);
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"点击屏幕";
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.frame = self.view.bounds;
}

@end
