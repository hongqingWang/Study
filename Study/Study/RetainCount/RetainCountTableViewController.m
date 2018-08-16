
//
//  RetainCountTableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/8/16.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RetainCountTableViewController.h"
#import "RetainCountStringFirstViewController.h"
#import "RetainCountStringSecondViewController.h"

@interface RetainCountTableViewController ()

@property (nonatomic, strong) NSArray *retainCountTitleArray;

@end

@implementation RetainCountTableViewController

static NSString * const ID = @"RetainCountCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.retainCountTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.retainCountTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            RetainCountStringFirstViewController *vc = [[RetainCountStringFirstViewController alloc] init];
            vc.navigationItem.title = self.retainCountTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            RetainCountStringSecondViewController *vc = [[RetainCountStringSecondViewController alloc] init];
            vc.navigationItem.title = self.retainCountTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)retainCountTitleArray {
    if (_retainCountTitleArray == nil) {
        _retainCountTitleArray = @[
                                   @"01-字面量",
                                   @"02-initWithFormat",
                                   @"03-stringWithFormat",
                                   @"04-stringWithString"
                                   ];
    }
    return _retainCountTitleArray;
}

@end
