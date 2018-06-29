//
//  KVOExplorationEssenceViewController.m
//  Study
//
//  Created by 王红庆 on 2018/6/29.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "KVOExplorationEssenceViewController.h"
#import "Person.h"

@interface KVOExplorationEssenceViewController ()

@property (nonatomic, strong) Person *person;

@end

@implementation KVOExplorationEssenceViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    self.person = [[Person alloc] init];
    self.person.age = 1;
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.person addObserver:self forKeyPath:@"age" options:options context:nil];
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"age"];
}

#pragma mark - Event Response
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    self.person.age = 10;
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
