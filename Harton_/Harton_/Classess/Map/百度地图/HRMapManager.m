//
//  HRMapManager.m
//  Harton
//
//  Created by 国诚信 on 2017/5/9.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRMapManager.h"
@interface HRMapManager()<BMKLocationServiceDelegate,AMapLocationManagerDelegate>

@property (nonatomic, strong) BMKLocationService *locationService;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) cllocationCompleteBlock complete;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, copy) void(^GDComplete)(CLLocation *location);
@end
@implementation HRMapManager

- (instancetype)init
{
    if (self = [super init]) {
        self.count = 0;
    }
    return self;
}
- (void)startLocationServiceWithCompleteBlock:(cllocationCompleteBlock)block
{
    self.complete = [block copy];
    [self.locationService startUserLocationService];
}


- (BMKLocationService *)locationService
{
    if (!_locationService) {
        //初始化BMKLocationService
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
        _locationService.pausesLocationUpdatesAutomatically = NO;
        _locationService.allowsBackgroundLocationUpdates = YES;
//        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
//        _geoCodeSearch.delegate = self;//设置代理为self
    }
    return _locationService;
}

- (AMapLocationManager *)locationManager
{
    if (!_locationManager) {
        _locationManager = [[AMapLocationManager alloc] init];
        _locationManager.allowsBackgroundLocationUpdates = YES;
        _locationManager.delegate = self;
        
    }
    return _locationManager;
}

- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    反编码 地理位置
    if (self.count % 6 != 0) return;
    
    if (self.complete) {
        self.complete(userLocation);
    }
//    [self.locationService stopUserLocationService];
}

- (void)startGDLocationServiceWithComplete:(void (^)(CLLocation *))complete
{
    self.GDComplete = complete;
    [self.locationManager startUpdatingLocation];
}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    if (self.GDComplete) {
        self.GDComplete(location);
    }
    [self.locationManager stopUpdatingLocation];
}

@end
