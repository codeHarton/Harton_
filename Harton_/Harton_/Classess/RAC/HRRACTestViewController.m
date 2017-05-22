//
//  HRRACTestViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/9.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRRACTestViewController.h"
#import "HRTagModel.h"
@interface HRRACTestViewController ()
@property (nonatomic, strong) RACSignal *signal;
@end

@implementation HRRACTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RACSubject *subject = [RACSubject subject];
    

    RACSubject *newSubject = [RACSubject subject];
    
    [subject subscribe:newSubject];
    
    
    
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return nil;
    }];
    
    [signal subscribe:subject];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
}

- (RACSignal *)signal
{
    if (!_signal) {
        _signal = [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *urlStr = @"https://api.douban.com/v2/book/search";
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            
            [manager GET:urlStr parameters:@{@"q":@"基础"} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendError:error];
            }];
            
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"disposableWithBlock");
            }];
        }] replayLazily] map:^id(id value) {
            if ([value isKindOfClass:[NSDictionary class]]){
                //                NSArray *arr = [Model mj_objectArrayWithKeyValuesArray:[value objectForKey:@"books"]];
                
                NSError *error = nil;
                NSDictionary *dict = [[value objectForKey:@"books"] objectAtIndex:0];
                HRTagModel *model = [MTLJSONAdapter modelOfClass:[HRTagModel class] fromJSONDictionary:dict error:&error];
                
                return model;
            }
            
            
            return nil;
        }];
    }
    return _signal;
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
