//
//  TableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/6/29.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()

/// 知识点
@property (nonatomic, strong) NSArray<NSString *> *titleArray;

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

#pragma mark - TableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString * const ID = @"QQCellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

#pragma mark - Getters And Setters
- (NSArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = @[
                        @"01-OC对象的本质",
                        @"02-KVO",
                        @"03-Category",
                        ];
    }
    return _titleArray;
}

@end
