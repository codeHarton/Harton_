//
//  HRRACTableViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRRACTableViewController.h"
#import "HRMantleViewModel.h"
#import "ListTableViewCell.h"
#import "HRRACTestViewController.h"
@interface HRRACTableViewController ()
@property (nonatomic,strong) HRMantleViewModel *viewModel;

@property (nonatomic, strong) NSArray *lists;
@end
typedef int(^commBLock)(int idnex);
@implementation HRRACTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[HRMantleViewModel alloc] init];
    
    [self initViews];
    
    [self bingViewModel];
    
    [self.viewModel.command execute:nil];
 
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectZero];
    
//    [self.refreshControl setRefreshingWithStateOfTask:[self.viewModel loadData]];
    
//    [self.refreshControl addTarget:self
//                            action:@selector(refreshDataSource:)
//                  forControlEvents:UIControlEventValueChanged];
    

    

}


- (void)refreshDataSource:(__unused id)sender
{
}

- (void)initViews
{
    self.tableView.estimatedRowHeight = 200;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ListTableViewCell" bundle:nil] forCellReuseIdentifier:@"ListTableViewCell"];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"ladData" style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)bingViewModel
{
    self.navigationItem.rightBarButtonItem.rac_command = self.viewModel.command;
    [SVProgressHUD setMinimumDismissTimeInterval:0.7];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultAnimationType:SVProgressHUDAnimationTypeNative];
//    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    [[self.viewModel.command.executionSignals flatten] subscribeNext:^(NSArray *lists) {
//        [Util hideForKeyWindow];
        [SVProgressHUD showSuccessWithStatus:@"请求成功"];
        self.lists = lists;
        [self.tableView reloadData];
    }];

    [[self.viewModel.command.executing distinctUntilChanged]subscribeNext :^(id x) {
        if ([x boolValue]) {
//            [Util showAtKeyWindowWithTitle:@"正在加载"];
            [SVProgressHUD showWithStatus:@"正在加载"];
        }else{

        }
    }];
    
    
    [self.navigationItem.rightBarButtonItem.rac_command.errors subscribeNext:^(id x) {
        NSLog(@"x = %@",x);
//        [Util hideForKeyWindow];
//        [Util show:@"请求失败" view:nil];
        [SVProgressHUD showErrorWithStatus:@"请求失败"];
    }];
    
    

    
}

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:@"author"]) {
        [Util show:@"作者" view:nil];
        
    }else if([eventName isEqualToString:@"image"]){
        [Util show:@"头像" view:nil];
    }else if([eventName isEqualToString:@"publisher"]){
        [Util show:@"发布人" view:nil];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.lists.count;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 0;
    return [tableView fd_heightForCellWithIdentifier:@"ListTableViewCell" configuration:^(ListTableViewCell * cell) {
        cell.model = [self.lists objectAtIndex:indexPath.row];
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListTableViewCell" forIndexPath:indexPath];
    cell.model = [self.lists objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.navigationController pushViewController:[HRRACTestViewController new] animated:YES];
}


@end
