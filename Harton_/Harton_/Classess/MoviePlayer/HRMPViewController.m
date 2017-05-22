//
//  HRMPViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/8.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRMPViewController.h"
#import <KRVideoPlayerController.h>
@interface HRMPViewController ()
@property (nonatomic, strong) KRVideoPlayerController *videoController;

@end

@implementation HRMPViewController
{
    BOOL roteOrLocation;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view bk_whenTapped:^{
        
        roteOrLocation ? [self playRemoteVideo:nil] : [self playLocalVideo:nil];
        roteOrLocation = !roteOrLocation;
    }];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playLocalVideo:(id)sender
{
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:@"150511_JiveBike" withExtension:@"mov"];
    [self playVideoWithURL:videoURL];
}

- (IBAction)playRemoteVideo:(id)sender
{
    NSURL *videoURL = [NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
    [self playVideoWithURL:videoURL];
}

- (void)playVideoWithURL:(NSURL *)url
{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0, 0, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController showInWindow];
    }
    self.videoController.contentURL = url;
}

@end
