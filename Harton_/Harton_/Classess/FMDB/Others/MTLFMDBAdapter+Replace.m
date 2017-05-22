//
//  MTLFMDBAdapter+Replace.m
//  BigHealth
//
//  Created by tianya on 15/2/9.
//  Copyright (c) 2015年 tianya. All rights reserved.
//

#import "MTLFMDBAdapter+Replace.h"
#import <Mantle/Mantle.h>


@implementation MTLFMDBAdapter (Replace)

+ (NSString *)replaceStatementForModel:(MTLModel<MTLFMDBSerializing> *)model
{
    NSDictionary *columns = [model.class FMDBColumnsByPropertyKey];
    NSSet *propertyKeys = [model.class propertyKeys];
    NSArray *Keys = [[propertyKeys allObjects] sortedArrayUsingSelector:@selector(compare:)];
    NSMutableArray *stats = [NSMutableArray array];
    NSMutableArray *qmarks = [NSMutableArray array];
    for (NSString *propertyKey in Keys)
    {
        NSString *keyPath = columns[propertyKey];
        keyPath = keyPath ? : propertyKey;
        
        if (keyPath != nil && ![keyPath isEqual:[NSNull null]])
        {
            [stats addObject:keyPath];
            [qmarks addObject:@"?"];
        }
    }
    
    NSString *statement = [NSString stringWithFormat:@"replace into %@ (%@) values (%@)", [model.class FMDBTableName], [stats componentsJoinedByString:@", "], [qmarks componentsJoinedByString:@", "]];
    
    return statement;
}



@end
