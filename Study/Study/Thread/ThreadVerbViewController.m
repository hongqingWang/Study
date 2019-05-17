//
//  ThreadVerbViewController.m
//  Study
//
//  Created by 王红庆 on 2019/5/17.
//  Copyright © 2019 王红庆. All rights reserved.
//

#import "ThreadVerbViewController.h"

@interface ThreadVerbViewController ()

@property (nonatomic, assign) int tickets;

@end

@implementation ThreadVerbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.tickets = 20;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSThread *thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    thread1.name = @"售票1";
    [thread1 start];
    
    NSThread *thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTickets) object:nil];
    thread2.name = @"售票2";
    [thread2 start];
}

- (void)saleTickets {

//    @synchronized (self) {
    while (YES) {
        
//        @synchronized (self) {
        [NSThread sleepForTimeInterval:1];
        
        // @synchronized 性能太差
        @synchronized (self) {
            if (self.tickets > 0) {
                self.tickets--;
                NSLog(@"%@ %d", [NSThread currentThread], self.tickets);
                continue;
            }
        }
        
        NSLog(@"没票了");
        break;
        
        // @synchronized 锁不到这里,只能锁到上面的代码块
//        NSLog(@"---");
    }
}

@end
