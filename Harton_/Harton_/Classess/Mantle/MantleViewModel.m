//
//  HRMantleViewModel.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "MantleViewModel.h"

@implementation MantleViewModel


- (RACCommand *)command
{
    if (!_command) {
        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                NSString *urlStr = @"https://api.douban.com/v2/book/search";
                AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
              
                [manager GET:urlStr parameters:input progress:^void(NSProgress *progress){
                    NSLog(@"progress  = %@",progress);
                }success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
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
        }];
    }
    return _command;
}

@end
