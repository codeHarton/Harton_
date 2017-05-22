//
//  ViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "ViewController.h"
#import "HRRACTableViewController.h"
#import "HRMantleTableViewController.h"
#import "HRBKViewController.h"
#import "HRCodingViewController.h"
#import "HRAFNViewController.h"
#import "HRMPViewController.h"
#import "HRPOPViewController.h"
#import "HRMapViewController.h"
#import "HRGDMapViewController.h"
@interface ViewController ()

@end

static inline NSArray *home_List(){
    return @[@"RAC",@"Mantle",@"BlockKit",@"NSCoding",@"AFNetworking",@"MoviePlayer",@"POP",@"百度地图",@"高德地图"];
}

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}
- (void)setupUI
{
    self.title = @"MyOwnDemo";
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [UIView new];
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return home_List().count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeList" forIndexPath:indexPath];
    cell.textLabel.text = [home_List() objectAtIndex:indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController *vc = nil;
    if (0 == indexPath.row) {
        vc = [HRRACTableViewController new];
    }
    else if (1 == indexPath.row) {
        vc = [HRMantleTableViewController new];
    }
    else if (2 == indexPath.row) {
        vc = [HRBKViewController new];
    }
    else if (3 == indexPath.row) {
        vc = [HRCodingViewController new];
    }
    else if (4 == indexPath.row) {
        vc = [HRAFNViewController new];
    }
    else if (5 == indexPath.row) {
        vc = [HRMPViewController new];
    }
    else if (6 == indexPath.row) {
        vc = [HRPOPViewController new];
    }
    else if (7 == indexPath.row) {
        vc = [HRMapViewController new];
    }
    else if (8 == indexPath.row) {
        vc = [HRGDMapViewController new];
    }
    if (!vc) return;

    vc.title = [home_List() objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


@end
