//
//  SMDatabaseManager.m
//  BigHealth
//
//  Created by tianya on 15/2/7.
//  Copyright (c) 2015年 tianya. All rights reserved.
//

#import "SMDatabaseManager.h"
#import <FMDatabase.h>
#import <FMDatabaseQueue.h>
#import <Mantle/Mantle.h>
#import "MTLFMDBAdapter+Replace.h"


@implementation SMDatabaseManager

#pragma mark - private C founctions

void handleDbexecuteUpdateSql(FMDatabase *db ,NSString *sql ,void(^completion)(BOOL success))
{
    BOOL success = [db executeUpdate:sql];
    handleOperationResultAndSql(success, sql ,completion);
}

void handleDbexecuteUpdateSqlwithArgumentsInArray(FMDatabase *db ,NSString *sql ,NSArray *arguments ,void(^completion)(BOOL success))
{
    BOOL success = [db executeUpdate:sql withArgumentsInArray:arguments];
    handleOperationResultAndSql(success, sql, completion);
}

void handleOperationResultAndSql(BOOL success ,NSString *sql ,void(^completion)(BOOL success))
{
//    if (success) {
//        NSLog(@"sql:%@\n操作成功",sql);
//    }else{
//        NSLog(@"sql:%@\n操作失败",sql);
//    }
    
    if (completion) {
        completion(success);
    }
}

#pragma mark - private founctions

+ (FMResultSet*)executeQuesryInDB:(FMDatabase*)db stmt:(NSString *)stmt
                       parameters:(NSArray *)parameters error:(NSError**)outErr
{
    FMResultSet *res = [db executeQuery:stmt withArgumentsInArray:parameters];
    if(res == nil && outErr)
        *outErr = [db lastError] ;
    return res;
}

- (NSArray *)databaseObjectsWithResultSet:(FMResultSet *)resultSet
                                    class:(Class)class
{
    NSMutableArray *s = [NSMutableArray array];
    while ([resultSet next]) {
        NSError *error = nil;
        id obj = [MTLFMDBAdapter modelOfClass:class fromFMResultSet:resultSet error:&error];
        [s addObject:obj];
    }
    return s;
}


#pragma mark -
#pragma mark - public founctions


#pragma mrak - create
-(void)createTable
{
    [self.dbQueue inDatabase:^(FMDatabase *adb) {
        //创建数据库版本表
        [adb executeUpdate:@"create table if not exists 'db_version' (\
         version INTEGER PRIMARY KEY NOT NULL);"];
    }];
}

#pragma mark - insert
- (void)insertModel:(MTLModel<MTLFMDBSerializing> *)model
{
    [self insertModel:model completion:nil];
}

- (void)insertModel:(MTLModel<MTLFMDBSerializing> *)model
         completion:(void(^)(BOOL success))completion
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            NSString * sql = [MTLFMDBAdapter insertStatementForModel:model];
            NSArray * parameters = [MTLFMDBAdapter columnValues:model];
            handleDbexecuteUpdateSqlwithArgumentsInArray(db, sql, parameters, completion);
        }
    }];
}

- (void)insertModels:(NSArray *)models
{
    [self insertModels:models completion:nil];
}

- (void)insertModels:(NSArray *)models
          completion:(void(^)(BOOL success))completion
{
    [self.dbQueue inTransaction:^(FMDatabase *adb, BOOL *rollback) {
        
        BOOL success = YES;
        for (MTLModel<MTLFMDBSerializing> *model in models) {
            NSString * stmt = [MTLFMDBAdapter insertStatementForModel:model];
            NSArray * parameters = [MTLFMDBAdapter columnValues:model];
            success = [adb executeUpdate:stmt withArgumentsInArray:parameters];
            if (success == NO) {
                break;
            }
        }
        
        *rollback = !success;
        
        if (completion) {
            completion(success);
        }
        
    }];
}

#pragma mark - update

- (void)updateModel:(MTLModel<MTLFMDBSerializing> *)model
{
    [self updateModel:model completion:nil];
}
- (void)updateModel:(MTLModel<MTLFMDBSerializing> *)model
         completion:(void(^)(BOOL success))completion
{
    [self.dbQueue inDatabase:^(FMDatabase *adb) {
        if ([adb open]) {
            NSString * sql = [MTLFMDBAdapter updateStatementForModel:model];
            NSArray *columnValues = [MTLFMDBAdapter columnValues:model];
            NSArray *primaryKeysValues = [MTLFMDBAdapter primaryKeysValues:model];
            NSMutableArray *parameters = [NSMutableArray array];
            [parameters addObjectsFromArray:columnValues];
            [parameters addObjectsFromArray:primaryKeysValues];
            
            handleDbexecuteUpdateSqlwithArgumentsInArray(adb, sql, parameters, completion);
        }
    }];
}


- (void)updateModels:(NSArray *)models
{
    [self updateModels:models completion:nil];
}

- (void)updateModels:(NSArray *)models
          completion:(void(^)(BOOL success))completion
{
    [self.dbQueue inTransaction:^(FMDatabase *adb, BOOL *rollback)
     {
         
         BOOL success = YES;
         for (MTLModel<MTLFMDBSerializing> *model in models) {
             NSString * stmt = [MTLFMDBAdapter updateStatementForModel:model];
             NSArray *columnValues = [MTLFMDBAdapter columnValues:model];
             NSArray *primaryKeysValues = [MTLFMDBAdapter primaryKeysValues:model];
             NSMutableArray *parameters = [NSMutableArray array];
             [parameters addObjectsFromArray:columnValues];
             [parameters addObjectsFromArray:primaryKeysValues];
             
             success = [adb executeUpdate:stmt withArgumentsInArray:parameters];
             if (success == NO) {
                 break;
             }
         }
         
         *rollback = !success;
         
         if (completion) {
             completion(success);
         }
         
     }];
}

#pragma mark - replace

- (void)replaceModel:(MTLModel<MTLFMDBSerializing> *)model
{
    [self replaceModel:model completion:nil];
}

- (void)replaceModel:(MTLModel<MTLFMDBSerializing> *)model
          completion:(void(^)(BOOL success))completion
{
    NSParameterAssert(model);
    
    [self.dbQueue inDatabase:^(FMDatabase *adb) {
        if ([adb open]) {
            NSString * sql = [MTLFMDBAdapter replaceStatementForModel:model];
            NSArray * parameters = [MTLFMDBAdapter columnValues:model];
            handleDbexecuteUpdateSqlwithArgumentsInArray(adb, sql, parameters, completion);
        }
    }];
}

- (void)replaceModels:(NSArray *)models
{
    [self replaceModels:models completion:nil];
}

- (void)replaceModels:(NSArray *)models
           completion:(void(^)(BOOL success))completion
{
    NSParameterAssert(models);
    
    [self.dbQueue inTransaction:^(FMDatabase *adb, BOOL *rollback)
     {
         
         BOOL success = YES;
         for (MTLModel<MTLFMDBSerializing> *model in models) {
             NSString * stmt = [MTLFMDBAdapter replaceStatementForModel:model];
             NSArray * parameters = [MTLFMDBAdapter columnValues:model];
//             success = [adb executeUpdate:stmt withArgumentsInArray:parameters];
             if ([adb executeUpdate:stmt withArgumentsInArray:parameters] == NO) {
                 success = NO;
                 break;
             }
         }
         
         *rollback = !success;
         
         if (completion) {
             completion(success);
         }
         
     }];
}

#pragma mark - delete

- (void)deleteModel:(MTLModel<MTLFMDBSerializing> *)model
{
    [self deleteModel:model completion:nil];
}

- (void)deleteModel:(MTLModel<MTLFMDBSerializing> *)model
         completion:(void(^)(BOOL success))completion
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            NSString * sql = [MTLFMDBAdapter deleteStatementForModel:model];
            NSArray * parameters = [MTLFMDBAdapter primaryKeysValues:model];
            handleDbexecuteUpdateSqlwithArgumentsInArray(db, sql, parameters, completion);
        }
    }];
}

- (void)deleteModels:(NSArray *)models
{
    [self deleteModels:models completion:nil];
}

- (void)deleteModels:(NSArray *)models
          completion:(void(^)(BOOL success))completion
{
    NSParameterAssert(models);
    
    [self.dbQueue inTransaction:^(FMDatabase *adb, BOOL *rollback)
     {
         
         BOOL success = YES;
         for (MTLModel<MTLFMDBSerializing> *model in models) {
             NSString * stmt = [MTLFMDBAdapter deleteStatementForModel:model];
             NSArray * parameters = [MTLFMDBAdapter columnValues:model];
             success = [adb executeUpdate:stmt withArgumentsInArray:parameters];
             if (success == NO) {
                 break;
             }
         }
         
         *rollback = !success;
         
         if (completion) {
             completion(success);
         }
         
     }];
}

#pragma mark - fetch
- (void)fetchStatementWithSql:(NSString *)sql
                 modelOfClass:(Class)modelClass
                   completion:(void(^)(NSArray * result, NSError * error))completion
{
    [self.dbQueue inDatabase:^(FMDatabase *adb)
     {
         if ([adb open] == NO) {
             if (completion) {
                 completion(nil, nil);
             }
             return ;
         }
         
         NSMutableArray * resultArray = [NSMutableArray array];
         NSError *error = nil;
         FMResultSet *resultSet = [adb executeQuery:sql];
         
         while ([resultSet next]) {
             id resultUser = [MTLFMDBAdapter modelOfClass:modelClass
                                          fromFMResultSet:resultSet
                                                    error:&error];
             if (error == nil && resultUser) {
                 [resultArray addObject:resultUser];
             } else{
                 NSLog(@"操作失败 %@",error);
             }
         }
         
         if (completion) {
             completion(resultArray, error);
         }
         
     }];
}


- (void)fetch:(NSString *)tableName returnClass:(Class)returnClass
{
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSError *error = nil;
        FMResultSet *res = [[self class]executeQuesryInDB:db stmt:[NSString stringWithFormat:@"select * from %@", tableName] parameters:nil error:&error];
        if(error != nil)
        {
            
        }
        else
        {
            NSArray *s = [self databaseObjectsWithResultSet:res class:returnClass];
            NSParameterAssert(s);
        }
    }];
}


#pragma mark -private
- (NSInteger)dbVersion
{
    __block int version = 0;
    
    [self.dbQueue inDatabase:^(FMDatabase *adb)
     {
         FMResultSet *rs = [adb executeQuery:@"SELECT * FROM db_version"];
         
         while ([rs next]) {
             
             version  = [rs intForColumn:@"version"];
         }
         [rs close];
         
     }];
    return version;
    
}


-(void)checkNeedUpdateDb:(NSInteger)newVersion
{
    NSInteger currentVersion = [self dbVersion];
    
    if (currentVersion == 0) {
        [self.dbQueue inDatabase:^(FMDatabase *adb) {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO db_version (version) VALUES (%d);",1];
            [adb executeUpdate:sql];
            return ;
        }];
    }
    else if (newVersion>currentVersion)
    {
        //执行更行命令
        [self onUpdateDb];
        [self.dbQueue inDatabase:^(FMDatabase *adb) {
            //更新数据库版本数据
            NSString *sql = [NSString stringWithFormat:@"UPDATE db_version SET version = %ld;",(long)newVersion];
            [adb executeUpdate:sql];
        }];
    }
}

-(void)onUpdateDb
{
    
}
@end
