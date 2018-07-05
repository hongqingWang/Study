//
//  RunloopTableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/5.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RunloopTableViewController.h"
#import "RunloopKeepThreadAliveViewController.h"

@interface RunloopTableViewController ()

@property (nonatomic, strong) NSArray *runloopTitleArray;

@end

@implementation RunloopTableViewController

static NSString * const ID = @"RuntimeCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.runloopTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.runloopTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            RunloopKeepThreadAliveViewController *vc = [[RunloopKeepThreadAliveViewController alloc] init];
            vc.navigationItem.title = self.runloopTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)runloopTitleArray {
    if (_runloopTitleArray == nil) {
        _runloopTitleArray = @[
                               @"01-线程保活"
                               ];
    }
    return _runloopTitleArray;
}

@end
