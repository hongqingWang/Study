//
//  TableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/6/29.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "TableViewController.h"
#import "KVOTableViewController.h"
#import "AssociateTableViewController.h"
#import "BlockTableViewController.h"
#import "RuntimeTableViewController.h"
#import "RunloopTableViewController.h"
#import "ThreadTableViewController.h"
#import "MemoryManageTableViewController.h"
#import "RetainCountTableViewController.h"

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
    
    static NSString * const ID = @"CellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            NSLog(@"未完成");
        }
            break;
        case 1:
        {
            KVOTableViewController *vc = [[KVOTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            NSLog(@"02-KVC(未完) - 未完成");
        }
        case 3:
        {
            NSLog(@"03-Category(未完) - 未完成");
        }
            break;
        case 4:
        {
            AssociateTableViewController *vc = [[AssociateTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            BlockTableViewController *vc = [[BlockTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            RuntimeTableViewController *vc = [[RuntimeTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            RunloopTableViewController *vc = [[RunloopTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 8:
        {
            ThreadTableViewController *vc = [[ThreadTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 9:
        {
            MemoryManageTableViewController *vc = [[MemoryManageTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 10:
        {
            NSLog(@"11-性能优化(未完)");
        }
            break;
        case 11:
        {
            NSLog(@"12-架构相关(未完)");
        }
            break;
        case 12:
        {
            RetainCountTableViewController *vc = [[RetainCountTableViewController alloc] init];
            vc.navigationItem.title = self.titleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;

            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)titleArray {
    if (_titleArray == nil) {
        _titleArray = @[
                        @"01-OC对象的本质(未完)",
                        @"02-KVO",
                        @"03-KVC(未完)",
                        @"04-Category(未完)",
                        @"05-关联对象",
                        @"06-Block",
                        @"07-Runtime",
                        @"08-Runloop",
                        @"09-多线程",
                        @"10-内存管理",
                        @"11-性能优化(未完)",
                        @"12-架构相关(未完)",
                        @"13-RetainCount"
                        ];
    }
    return _titleArray;
}

@end
