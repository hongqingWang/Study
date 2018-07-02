//
//  AssociateTableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/2.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "AssociateTableViewController.h"

@interface AssociateTableViewController ()

@property (nonatomic, strong) NSArray *associateTitleArray;

@end

@implementation AssociateTableViewController

static NSString * const ID = @"AssociateCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.associateTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.associateTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
//            KVOBaseUseViewController *vc = [[KVOBaseUseViewController alloc] init];
//            vc.navigationItem.title = self.kvoTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
//            KVOExplorationEssenceViewController *vc = [[KVOExplorationEssenceViewController alloc] init];
//            vc.navigationItem.title = self.kvoTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
//            KVOPrintMethodClassNameViewController *vc = [[KVOPrintMethodClassNameViewController alloc] init];
//            vc.navigationItem.title = self.kvoTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
//            KVOInterviewQuestionViewController *vc = [[KVOInterviewQuestionViewController alloc] init];
//            vc.navigationItem.title = self.kvoTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)associateTitleArray {
    if (_associateTitleArray == nil) {
        _associateTitleArray = @[
                           @"01-为Category增加成员变量"
                           ];
    }
    return _associateTitleArray;
}

@end
