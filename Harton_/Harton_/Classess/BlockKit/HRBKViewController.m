//
//  HRBKViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRBKViewController.h"

@interface HRBKViewController ()
@property (nonatomic, weak) IBOutlet UITextField *textField;

@property (nonatomic, weak) IBOutlet UIButton *start;


@property (nonatomic, weak) IBOutlet UIWebView *webView;
@property (nonatomic, strong) NSProgress *progress;

@end

@implementation HRBKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RAC(self.start,enabled) = [self.textField.rac_textSignal map:^id(NSString * value) {
        return @(value.length > 6);
    }];
    __weak typeof(self) weself = self;
    
    [self.start bk_addEventHandler:^(id sender) {
        [weself loadREquest];
    } forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.webView bk_setDidStartLoadBlock:^(UIWebView *webView){
        [Util showHud:self withTitle:@"正在加载"];
    }];
    
    
    [self.webView bk_setDidFinishLoadBlock:^(UIWebView *webView){
        [Util hideHud:self];
        
    }];
    
    [self.webView bk_setDidFinishWithErrorBlock:^(UIWebView *webView,NSError *error){
        [Util hideHud:self];
        [Util show:@"failure" view:nil];
    }];
    
    
    [self.textField setBk_shouldReturnBlock:^BOOL(UITextField *textField){
        [weself loadREquest];
        return YES;
    }];
    
    
    

    // Do any additional setup after loading the view.
}

- (void)loadREquest
{
//    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.textField.text]]];
//    return;
    self.progress = [[NSProgress alloc] init];
    
    NSProgress *gress = self.progress;
    [gress.KVOController observe:self keyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        NSLog(@"fractionCompleted%@",[change objectForKey:@"new"]);
    }];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.textField.text]] progress:&gress success:nil failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)test
{
    
}

- (void)dealloc
{
    NSLog(@"xx");
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
