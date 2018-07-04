//
//  RuntimeCat.m
//  Study
//
//  Created by 王红庆 on 2018/7/4.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimeCat.h"

@implementation RuntimeCat

- (void)runtimeInstanceMethod {
    NSLog(@"%s", __FUNCTION__);
}

+ (void)runtimeClassMethod {
    NSLog(@"%s", __FUNCTION__);
}

@end
