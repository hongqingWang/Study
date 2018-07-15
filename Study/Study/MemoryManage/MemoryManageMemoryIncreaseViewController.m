//
//  MemoryManageMemoryIncreaseViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/15.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "MemoryManageMemoryIncreaseViewController.h"

@interface MemoryManageMemoryIncreaseViewController ()

@end

@implementation MemoryManageMemoryIncreaseViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    /**
     * 以下哪种情况运行时可能会造成内存飙升？为什么？
     * A.image;     B.label;    C.string;   D.都不会;
     */
    for (int i = 0; i < MAXFLOAT; i++) {
        
        @autoreleasepool {
            
            /**
             * A.image;
             */
//            UIImage *image = [[UIImage alloc] init];
            
            /**
             * B.label;
             */
//            UILabel *label = [[UILabel alloc] init];
            
            /**
             * C.string;
             */
//            NSString *string = @"abc";
//            string = [string stringByAppendingString:@"xyz"];
        }
    }
    
    /**
     * 答案是
     * B.label;
     * 原因:
     * ---
     */
}

#pragma mark - SetupUI
- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"MemoryManageMemoryIncreaseViewController";
    label.font = [UIFont systemFontOfSize:24];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    label.frame = self.view.bounds;
}

@end
