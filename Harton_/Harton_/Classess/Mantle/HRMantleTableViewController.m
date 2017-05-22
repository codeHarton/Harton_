//
//  HRMantleTableViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRMantleTableViewController.h"
#import "MantleViewModel.h"
#import "ListTableViewCell.h"
@interface HRMantleTableViewController ()
@property (nonatomic, strong) MantleViewModel *viewModel;
@property (nonatomic, strong) NSArray *lists;

@end

@implementation HRMantleTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewModel = [[MantleViewModel alloc] init];
    
    [self.KVOController observe:self.viewModel keyPath:@"testKVOController" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"++++++++++++++++++++++%@",change);
    }];
    
    self.tableView.estimatedRowHeight = 200;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListTableViewCell"];
    
    [[self.viewModel.command.executionSignals switchToLatest] subscribeNext:^(HRTagModel *model) {
        
        [Util hideForKeyWindow];
        
        [Util show:@"success" view:nil];
        
        self.lists = model.tags;
        
        [self.tableView reloadData];
    }];
    
    [[self.viewModel.command.executing distinctUntilChanged]subscribeNext :^(id x) {
        if ([x boolValue]) {
            [Util showAtKeyWindowWithTitle:@"正在加载"];
        }else{
//            [Util hideForKeyWindow];
        }
    }];
    [self.viewModel.command.errors subscribeNext:^(id x) {
        [Util hideForKeyWindow];
    }];
    [self.viewModel.command execute:@{@"q":@"基础"}];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.lists.count;
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [tableView fd_heightForCellWithIdentifier:@"ListTableViewCell" configuration:^(ListTableViewCell *cell) {
        HRTagDetail *detail = [self.lists objectAtIndex:indexPath.row];
        
        cell.publisher.text = detail.name;
        cell.summary.text = detail.title;
        cell.author.text = [NSString stringWithFormat:@"数量%@",detail.count];
    }];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];

    HRTagDetail *detail = [self.lists objectAtIndex:indexPath.row];
    
    cell.publisher.text = detail.name;
    cell.summary.text = detail.title;
    cell.author.text = [NSString stringWithFormat:@"数量%@",detail.count];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
