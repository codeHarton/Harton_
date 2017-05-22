//
//  ViewModel.m
//  HuanXinTest
//
//  Created by 国诚信 on 2017/4/26.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRMantleViewModel.h"

@implementation HRMantleViewModel
- (instancetype)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self initDatas];

    return self;
}

- (void)initDatas
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"q"] = @"基础";
    self.command = [[RACCommand alloc] initWithEnabled:nil signalBlock:^RACSignal *(id input) {
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            NSString *urlStr = @"https://api.douban.com/v2/book/search";
            AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
            [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [subscriber sendNext:responseObject];
                [subscriber sendCompleted];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [subscriber sendError:error];
            }];
            
        
            
            return [RACDisposable disposableWithBlock:^{
                NSLog(@"disposableWithBlock");
            }];
        }] map:^id(id value) {
            if ([value isKindOfClass:[NSError class]]) {
                return value;
            }else if ([value isKindOfClass:[NSDictionary class]]){
//                NSArray *arr = [Model mj_objectArrayWithKeyValuesArray:[value objectForKey:@"books"]];

                NSError *error = nil;
                NSArray *arr = [MTLJSONAdapter modelsOfClass:[Model class] fromJSONArray:[value objectForKey:@"books"] error:&error];
                return arr;
            }
            return nil;
        }];
    }];

    
}

- (NSURLSessionTask *)loadData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"q"] = @"基础";
    NSString *urlStr = @"https://api.douban.com/v2/book/search";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   NSURLSessionDataTask *task = [manager GET:urlStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       NSLog(@"");
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         NSLog(@"");
    }];
    [task resume];
    return task;
    
}


@end
