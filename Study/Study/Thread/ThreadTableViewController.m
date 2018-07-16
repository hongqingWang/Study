//
//  ThreadTableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/16.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "ThreadTableViewController.h"
#import "ThreadBarrierViewController.h"

@interface ThreadTableViewController ()

@property (nonatomic, strong) NSArray *threadTitleArray;

@end

@implementation ThreadTableViewController

static NSString * const ID = @"ThreadCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.threadTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.threadTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            ThreadBarrierViewController *vc = [[ThreadBarrierViewController alloc] init];
            vc.navigationItem.title = self.threadTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)threadTitleArray {
    if (_threadTitleArray == nil) {
        _threadTitleArray = @[
                              @"01-死锁"
                              ];
    }
    return _threadTitleArray;
}

@end
