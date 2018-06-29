//
//  KVOTableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/6/29.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "KVOTableViewController.h"
#import "KVOBaseUseViewController.h"
#import "KVOExplorationEssenceViewController.h"
#import "KVOPrintMethodClassNameViewController.h"

@interface KVOTableViewController ()

@property (nonatomic, strong) NSArray *kvoTitleArray;

@end

@implementation KVOTableViewController

static NSString * const ID = @"KVOCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.kvoTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.kvoTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            KVOBaseUseViewController *vc = [[KVOBaseUseViewController alloc] init];
            vc.navigationItem.title = self.kvoTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            KVOExplorationEssenceViewController *vc = [[KVOExplorationEssenceViewController alloc] init];
            vc.navigationItem.title = self.kvoTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            KVOPrintMethodClassNameViewController *vc = [[KVOPrintMethodClassNameViewController alloc] init];
            vc.navigationItem.title = self.kvoTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)kvoTitleArray {
    if (_kvoTitleArray == nil) {
        _kvoTitleArray = @[
                           @"01-KVO基本使用",
                           @"02-探究KVO的本质",
                           @"03-打印KVO新生成类中的方法"
                           ];
    }
    return _kvoTitleArray;
}

@end
