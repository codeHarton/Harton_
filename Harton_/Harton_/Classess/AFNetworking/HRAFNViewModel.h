//
//  HRAFNViewModel.h
//  Harton
//
//  Created by 国诚信 on 2017/5/8.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRBaseViewModel.h"

@interface HRAFNViewModel : HRBaseViewModel
@property (strong , nonatomic) RACCommand *command;

@property (nonatomic, strong) RACSubject *subject;
- (NSURLSessionDownloadTask *)lodaDataWith:(NSInteger)states;
- (void)cancleTask;
@end
