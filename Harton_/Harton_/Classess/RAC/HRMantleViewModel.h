//
//  ViewModel.h
//  HuanXinTest
//
//  Created by 国诚信 on 2017/4/26.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>
#import "Model.h"
@interface HRMantleViewModel : HRBaseViewModel
@property (strong , nonatomic) RACCommand *command;


@property(nonatomic, copy) NSString * text;


@property(nonatomic, copy) NSString * name;
@property(nonatomic, copy) NSString * passward;

- (NSURLSessionTask *)loadData;

@end
