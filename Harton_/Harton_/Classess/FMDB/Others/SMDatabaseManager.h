//
//  SMDatabaseManager.h
//  BigHealth
//
//  Created by tianya on 15/2/7.
//  Copyright (c) 2015年 tianya. All rights reserved.
//

#import <Foundation/Foundation.h>


@class FMDatabaseQueue;

@interface SMDatabaseManager : NSObject

@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@property (nonatomic, strong) NSString *dbPath;


#pragma mrak - create
-(void)createTable;


#pragma mark - insert

- (void)insertModel:(MTLModel<MTLFMDBSerializing> *)model;
- (void)insertModel:(MTLModel<MTLFMDBSerializing> *)model
         completion:(void(^)(BOOL success))completion;

- (void)insertModels:(NSArray *)models;
- (void)insertModels:(NSArray *)models
          completion:(void(^)(BOOL success))completion;

#pragma mark - update
- (void)updateModel:(MTLModel<MTLFMDBSerializing> *)model;
- (void)updateModel:(MTLModel<MTLFMDBSerializing> *)model
         completion:(void(^)(BOOL success))completion;

- (void)updateModels:(NSArray *)models;
- (void)updateModels:(NSArray *)models
          completion:(void(^)(BOOL success))completion;

#pragma mark - replace
- (void)replaceModel:(MTLModel<MTLFMDBSerializing> *)model;
- (void)replaceModel:(MTLModel<MTLFMDBSerializing> *)model
          completion:(void(^)(BOOL success))completion;

- (void)replaceModels:(NSArray *)models;
- (void)replaceModels:(NSArray *)models
           completion:(void(^)(BOOL success))completion;


#pragma mark - delete
- (void)deleteModel:(MTLModel<MTLFMDBSerializing> *)model;
- (void)deleteModel:(MTLModel<MTLFMDBSerializing> *)model
         completion:(void(^)(BOOL success))completion;

- (void)deleteModels:(NSArray *)models;
- (void)deleteModels:(NSArray *)models
          completion:(void(^)(BOOL success))completion;


#pragma mark - fetch

- (void)fetchStatementWithSql:(NSString *)sql
                 modelOfClass:(Class)modelClass
                   completion:(void(^)(NSArray * result, NSError * error))completion;



#pragma mark - DBUpdate
/**
 *  检查数据库是否更新
 *
 *  @param newVersion 数据库新版本号
 */
-(void)checkNeedUpdateDb:(NSInteger)newVersion;

/**
 *  当数据库需要更新时，请在子类实现该方法
 */
-(void)onUpdateDb;


@end
