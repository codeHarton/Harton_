//
//  HRAFNViewModel.m
//  Harton
//
//  Created by 国诚信 on 2017/5/8.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRAFNViewModel.h"
#define _3M_FILE  @"http://dlsw.baidu.com/sw-search-sp/soft/90/25706/QQMusicForMacV2.2.1426490079.dmg"
#define _56M_FILE @"http://dlsw.baidu.com/sw-search-sp/soft/3a/12350/QQ_V7.0.14275.0_setup.1426647314.exe"
#define _100M_FILE @"http://dlsw.baidu.com/sw-search-sp/soft/e9/22772/10101988.3554647279.exe"
#define IMG_FILE @"http://img002.21cnimg.com/photos/album/20141031/s660x308/9F6D747EF8CCDD72F82A53C9A249E4F3.jpg"

@interface HRAFNViewModel()

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSURLSessionDownloadTask *task;
@property (nonatomic, strong) NSData *data;
@end

@implementation HRAFNViewModel
- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    self.manager = [AFHTTPSessionManager manager];
    self.subject = [RACSubject subject];
    return self;
}

- (RACCommand *)command
{
    if (!_command) {
        _command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
            return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                
                if ([input integerValue] == 1) {//开始
                    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_3M_FILE]];
                    self.task = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
                        [subscriber sendNext:@(downloadProgress.fractionCompleted)];
                    } destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                        if (error) {
                            [subscriber sendError:error];
                        }else{
                            [subscriber sendCompleted];
                        }
                    }];
                    
                    [self.task resume];
                }else if([input integerValue] == 2){//暂停
                    [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                        self.data = resumeData;
                        self.task  = nil;
                    }];
                    
                }else if([input integerValue] == 3){//恢复
                    self.task = [self.manager downloadTaskWithResumeData:self.data progress:^(NSProgress * _Nonnull downloadProgress) {
                        [subscriber sendNext:@(downloadProgress.fractionCompleted)];
                    } destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
                        if (error) {
                            [subscriber sendError:error];
                        }else{
                            [subscriber sendCompleted];
                        }
                    }];
                    [self.task resume];
                }

                return [RACDisposable disposableWithBlock:^{
                    [self.task cancel];
                }];
            }];
        }];
    }
    return _command;
}

- (NSURLSessionDownloadTask *)lodaDataWith:(NSInteger)states
{

    if (states == 1) {//开始
        [self.subject sendNext:@0];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_3M_FILE]];
        self.task = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
            [self.subject sendNext:@(downloadProgress.fractionCompleted)];
        } destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            if (error) {
//                [self.subject sendError:error];
            }else{
                [self.subject sendCompleted];
            }
        }];
        
        [self.task resume];
    }else if(states == 2){//暂停
        [self.task cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
            self.data = resumeData;
            self.task  = nil;
        }];
        
    }else if(states == 3){//恢复
       
        self.task = [self.manager downloadTaskWithResumeData:self.data progress:^(NSProgress * _Nonnull downloadProgress) {
            [self.subject sendNext:@(downloadProgress.fractionCompleted)];
        } destination:nil completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
            if (error) {
                //                [self.subject sendError:error];
            }else{
                [self.subject sendCompleted];
            }
        }];

        [self.task resume];
    }
    
    
    return self.task;
    
}

- (void)cancleTask
{
    [self.manager invalidateSessionCancelingTasks:YES];
}
@end
