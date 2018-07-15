//
//  MemoryManageTableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/9.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "MemoryManageTableViewController.h"
#import "MemoryManageCopyViewController.h"
#import "MemoryManageMemoryIncreaseViewController.h"

@interface MemoryManageTableViewController ()

@property (nonatomic, strong) NSArray *memoryManageTitleArray;

@end

@implementation MemoryManageTableViewController

static NSString * const ID = @"MemoryManageCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.memoryManageTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.memoryManageTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            MemoryManageCopyViewController *vc = [[MemoryManageCopyViewController alloc] init];
            vc.navigationItem.title = self.memoryManageTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            MemoryManageMemoryIncreaseViewController *vc = [[MemoryManageMemoryIncreaseViewController alloc] init];
            vc.navigationItem.title = self.memoryManageTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)memoryManageTitleArray {
    if (_memoryManageTitleArray == nil) {
        _memoryManageTitleArray = @[
                                    @"01-Copy",
                                    @"02-内存飙升问题"
                                    ];
    }
    return _memoryManageTitleArray;
}

@end
