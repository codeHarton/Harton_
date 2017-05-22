//
//  HRRACDatabase.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRRACDatabase.h"

@implementation HRRACDatabase
- (instancetype)init
{
    if (self = [super init]) {
        self.dbPath = [self newsDataBaseFilePath];
        self.dbQueue = [FMDatabaseQueue databaseQueueWithPath:self.dbPath];
        
        [self createTables];
    }
    return self;
}
- (void)createTables
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXIST books (bookId INTEGER PRIMARY KEY NOT NULL,)"];
    }];
}

- (NSString *)newsDataBaseFilePath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [path stringByAppendingPathComponent:@"joker.db"];
}

@end
