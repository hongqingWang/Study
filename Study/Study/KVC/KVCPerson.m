//
//  KVCPerson.m
//  Study
//
//  Created by 王红庆 on 2019/5/22.
//  Copyright © 2019 王红庆. All rights reserved.
//

#import "KVCPerson.h"

@implementation KVCPerson

//- (void)setAge:(int)age {
//
//    NSLog(@"setAge: - %d", age);
//}

//- (void)_setAge:(int)age {
//
//    NSLog(@"_setAge: - %d", age);
//}

- (void)willChangeValueForKey:(NSString *)key {
    
    [super willChangeValueForKey:key];
    NSLog(@"willChangeValueForKey - %@", key);
}

- (void)didChangeValueForKey:(NSString *)key {
    
    NSLog(@"didChangeValueForKey - begin - %@", key);
    [super didChangeValueForKey:key];
    NSLog(@"didChangeValueForKey - end - %@", key);
}

+ (BOOL)accessInstanceVariablesDirectly {
    
    // setValue:forUndefinedKey:
//    return NO;
    return YES;
}

//- (int)getAge {
//
//    NSLog(@"getAge");
//    return 11;
//}
//
//- (int)age {
//    
//    NSLog(@"age");
//    return 12;
//}
//
//- (int)isAge {
//    
//    NSLog(@"isAge");
//    return 13;
//}
//
//- (int)_age {
//    
//    NSLog(@"_age");
//    return 14;
//}

@end
