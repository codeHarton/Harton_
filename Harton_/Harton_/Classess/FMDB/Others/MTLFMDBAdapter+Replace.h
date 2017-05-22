//
//  MTLFMDBAdapter+Replace.h
//  BigHealth
//
//  Created by tianya on 15/2/9.
//  Copyright (c) 2015年 tianya. All rights reserved.
//

#import "MTLFMDBAdapter.h"

@interface MTLFMDBAdapter (Replace)

+ (NSString *)replaceStatementForModel:(MTLModel<MTLFMDBSerializing> *)model;

@end
