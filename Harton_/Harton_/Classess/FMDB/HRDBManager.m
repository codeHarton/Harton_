//
//  HRDBManager.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRDBManager.h"

@implementation HRDBManager
+ (instancetype)shareManager
{
    static HRDBManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HRDBManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (!self)  return nil;
    
    [self createTable];
    
    return self;
}

- (void)createTable
{
    
}
@end
