//
//  SCUserLocationManager.h
//  SameCity
//
//  Created by harton on 16/7/20.
//  Copyright © 2016年 Johnson. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^cllocationCompleteBlock)(BMKUserLocation *userLocation);
typedef void (^geocodeBlock)(CLLocationCoordinate2D coord);
@interface NCUserLocationManager : NSObject

//当前经纬度 不更新.
@property (nonatomic, assign) CLLocationCoordinate2D userPosition;

+ (instancetype)shareManager;

/**
 开始定位
 */
+ (void)startLocationService;
/**
 开始定位

 completeCity  定位到的城市
 */
+ (void)startLocationServiceWithCompleteCity:(void(^)(NSString *city))completeCity;

/**
 开始定位

 @param completeCoor 定位到的坐标  用于初始化百度地图
 */
+ (void)startLocationServiceWithCompleteCoor:(cllocationCompleteBlock)completeCoor;


+ (void)startLocationServiceWithCompleteCoor:(cllocationCompleteBlock)completeCoor finishAddress:(void(^)(NSString *addresss))finishAddress;
//+ (void)setComplete:(cllocationCompleteBlock)complete;

+ (NSString *)getCurrentCity;
//根据位置检索
+ (void)geoCodeSearchWith:(NSString *)address finish:(geocodeBlock)finish;



@property (assign, nonatomic) BOOL needGeoCode;//是否需要翻编码地理位置


@end
