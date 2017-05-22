//
//  HRAFNViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/8.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRAFNViewController.h"
#import "HRAFNViewModel.h"
@interface HRAFNViewController ()
@property (nonatomic, strong) HRAFNViewModel *viewModel;

@property (nonatomic, weak) IBOutlet UIProgressView *progressView;

@property  (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, assign) NSInteger status;

@end

@implementation HRAFNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.status = 0;
    self.viewModel = [[HRAFNViewModel alloc] init];

    [[self.button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *button) {
        if (self.status == 0) {
            self.status = 1;
        }else if (self.status == 1){
            self.status =2;
        }else if (self.status == 2){
            self.status =3;
        }else if (self.status == 3){
            self.status =2;
        }else return;
        [self.progressView setProgressWithDownloadProgressOfTask:[self.viewModel lodaDataWith:self.status] animated:YES];
    }];
    
    [self.viewModel.subject subscribeNext:^(id x) {
        [[RACScheduler mainThreadScheduler] schedule:^{
//            self.progressView.progress = [x floatValue];
            [SVProgressHUD showProgress:[x floatValue] status:@"下载进度"];
            if ([x floatValue] == 1) {
                self.status = 5;
            }
        }];
    } error:^(NSError *error) {
        [Util show:@"error" view:nil];
    } completed:^{
        [SVProgressHUD showSuccessWithStatus:@"请求成功"];
    }];
    
    
    [RACObserve(self, status) subscribeNext:^(id x) {
        switch ([x integerValue]) {
            case 0:
                [self.button setTitle:@"开始" forState:UIControlStateNormal];
                break;
            case 1:
                 [self.button setTitle:@"暂停" forState:UIControlStateNormal];
                break;
            case 2:
                [self.button setTitle:@"恢复" forState:UIControlStateNormal];
                break;
            case 3:
                [self.button setTitle:@"暂停" forState:UIControlStateNormal];
                break;
            case 5:
                [self.button setTitle:@"完成" forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }];

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    
    [self.viewModel.subject sendCompleted];
    [self.viewModel cancleTask];
    [SVProgressHUD dismiss];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
