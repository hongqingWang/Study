//
//  RuntimeTableViewController.m
//  Study
//
//  Created by 王红庆 on 2018/7/4.
//  Copyright © 2018年 王红庆. All rights reserved.
//

#import "RuntimeTableViewController.h"

@interface RuntimeTableViewController ()

@property (nonatomic, strong) NSArray *runtimeTitleArray;

@end

@implementation RuntimeTableViewController

static NSString * const ID = @"RuntimeCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.runtimeTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.runtimeTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
//            BlockAutoVariableViewController *vc = [[BlockAutoVariableViewController alloc] init];
//            vc.navigationItem.title = self.blockTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
//            BlockStaticVariableViewController *vc = [[BlockStaticVariableViewController alloc] init];
//            vc.navigationItem.title = self.blockTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
//            BlockGlobalVariabalViewController *vc = [[BlockGlobalVariabalViewController alloc] init];
//            vc.navigationItem.title = self.blockTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
//            BlockEssenceViewController *vc = [[BlockEssenceViewController alloc] init];
//            vc.navigationItem.title = self.blockTitleArray[indexPath.row];
//            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)runtimeTitleArray {
    if (_runtimeTitleArray == nil) {
        _runtimeTitleArray = @[
                             @"01-动态添加方法"
                             ];
    }
    return _runtimeTitleArray;
}

@end
