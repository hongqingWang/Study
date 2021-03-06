//
//  KVCTableViewController.m
//  Study
//
//  Created by 王红庆 on 2019/5/22.
//  Copyright © 2019 王红庆. All rights reserved.
//

#import "KVCTableViewController.h"
#import "KVCBaseUseViewController.h"
#import "KVCSetYuanLiViewController.h"
#import "KVCGetYuanLiViewController.h"

#import "KVOInterviewQuestionViewController.h"

@interface KVCTableViewController ()

@property (nonatomic, strong) NSArray *kvcTitleArray;

@end

@implementation KVCTableViewController

static NSString * const ID = @"KVCCellID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.kvcTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    cell.textLabel.text = self.kvcTitleArray[indexPath.row];
    
    return cell;
}

#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            KVCBaseUseViewController *vc = [[KVCBaseUseViewController alloc] init];
            vc.navigationItem.title = self.kvcTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            KVCSetYuanLiViewController *vc = [[KVCSetYuanLiViewController alloc] init];
            vc.navigationItem.title = self.kvcTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            KVCGetYuanLiViewController *vc = [[KVCGetYuanLiViewController alloc] init];
            vc.navigationItem.title = self.kvcTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            KVOInterviewQuestionViewController *vc = [[KVOInterviewQuestionViewController alloc] init];
            vc.navigationItem.title = self.kvcTitleArray[indexPath.row];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Getters And Setters
- (NSArray *)kvcTitleArray {
    if (_kvcTitleArray == nil) {
        _kvcTitleArray = @[
                           @"01-KVC基本使用",
                           @"02-KVC设值的原理",
                           @"03-KVC取值原理"
                           ];
    }
    return _kvcTitleArray;
}

@end
