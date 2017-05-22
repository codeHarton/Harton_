//
//  SCUserLocationManager.m
//  SameCity
//
//  Created by harton on 16/7/20.
//  Copyright © 2016年 Johnson. All rights reserved.
//

#import "NCUserLocationManager.h"

@interface NCUserLocationManager()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>

@property (nonatomic, strong) BMKLocationService *locationService;
@property (nonatomic, strong) BMKGeoCodeSearch *geoCodeSearch;
@property (nonatomic, copy) cllocationCompleteBlock complete;
@property (copy, nonatomic) void(^completeCity)(NSString *city);

@property (copy, nonatomic) void(^completeAddress)(NSString *address);
@property (nonatomic, copy) geocodeBlock geocodeBlock;
@property (nonatomic, assign) NSString *currentCity;
@end

@implementation NCUserLocationManager

{
    NSString *city;
}
static NCUserLocationManager *locationManager = nil;
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[NCUserLocationManager alloc] init];
       
    });
    return locationManager;
}
- (instancetype)init
{
    if (self = [super init]) {
        
    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
+ (void)setComplete:(cllocationCompleteBlock)complete
{
    [[NCUserLocationManager shareManager] _setComplete:complete];
}

- (void)_setComplete:(cllocationCompleteBlock)complete
{
    self.complete = complete;
}


+ (void)startLocationService
{
    [self startLocationServiceWithCompleteCoor:nil];
}

+ (void)startLocationServiceWithCompleteCity:(void (^)(NSString *))completeCity
{
    [[NCUserLocationManager shareManager] _startLocationServiceWithCompleteCity:completeCity];
}

+ (void)startLocationServiceWithCompleteCoor:(cllocationCompleteBlock)completeCoor finishAddress:(void(^)(NSString *addresss))finishAddress
{
    [[NCUserLocationManager shareManager] _startLocationServiceWithCompleteCoor:completeCoor finishAddress:finishAddress];
}

- (void)_startLocationServiceWithCompleteCoor:(cllocationCompleteBlock)completeCoor finishAddress:(void(^)(NSString *addresss))finishAddress
{
    if (finishAddress) {
        self.completeAddress = [finishAddress copy];
    }
    if (completeCoor) {
        self.complete = [completeCoor copy];
    }
    [self.locationService startUserLocationService];
}

- (void)_startLocationServiceWithCompleteCity:(void (^)(NSString *))completeCity
{
    if (completeCity) {
        _completeCity = [completeCity copy];
    }
    [self.locationService startUserLocationService];
}

+ (void)startLocationServiceWithCompleteCoor:(cllocationCompleteBlock)completeCoor
{
    [[NCUserLocationManager shareManager] _startLocationServiceWithCompleteCoor:completeCoor];
}

- (void)_startLocationServiceWithCompleteCoor:(cllocationCompleteBlock)completeCoor
{
    if (completeCoor) {
        self.complete = [completeCoor copy];
    }
    [self.locationService startUserLocationService];
}

+ (NSString *)getCurrentCity
{
    return [[self shareManager] _getCurrentCity];
}

- (NSString *)_getCurrentCity
{
    if (city && ![city isEqualToString:@""]) {
        return city;
    }
    return @"";
}
- (BMKLocationService *)locationService
{
    if (!_locationService) {
        //初始化BMKLocationService
        _locationService = [[BMKLocationService alloc]init];
        _locationService.delegate = self;
        _locationService.pausesLocationUpdatesAutomatically = NO;
        _locationService.allowsBackgroundLocationUpdates = YES;
        _geoCodeSearch = [[BMKGeoCodeSearch alloc] init];
        _geoCodeSearch.delegate = self;//设置代理为self
    }
    return _locationService;
}

+ (void)geoCodeSearchWith:(NSString *)address finish:(geocodeBlock)finish
{
    [[self shareManager] _geoCodeSearchWith:address finish:finish];
}
- (void)_geoCodeSearchWith:(NSString *)address finish:(geocodeBlock)finish
{
    self.geocodeBlock = [finish copy];
    BMKGeoCodeSearchOption *geocodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geocodeSearchOption.city= city;
    NSLog(@"cit = =============== %@",self.currentCity);
    geocodeSearchOption.address = address;
    BOOL flag = [_geoCodeSearch geoCode:geocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"发送成功");
    }
    else
    {
        NSLog(@"失败");
    }
}
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    反编码 地理位置
    
    [self reverseGeocode:userLocation.location.coordinate];
    
    if (self.complete) {
        self.complete(userLocation);
    }
//    设置电子围栏定位一次即可
    [_locationService stopUserLocationService];
}


- (void)reverseGeocode:(CLLocationCoordinate2D)coord  //发送反编码请求的.
{
    BMKReverseGeoCodeOption __autoreleasing  *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = coord;
    BOOL flag = [_geoCodeSearch reverseGeoCode:reverseGeocodeSearchOption];
    
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        if (result) {
            if (result.addressDetail.city != nil) {
                NSString *final = @"";
                NSArray *arr = result.poiList;
                if (arr.count == 0) {
                    final = [NSString stringWithFormat:@"%@",result.addressDetail.streetName];
                }else{
                    BMKPoiInfo *info = arr[0];
                    final = info.name;
                }
                city = result.addressDetail.city;
                if (_completeCity) {
                    _completeCity(city);
                }
                if (self.completeAddress) {
                    self.completeAddress(final);
                }
            }else{
                city = @"";
            }
        }
    }
}

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    if (error == 0) {
        if (self.geocodeBlock) {
            NSLog(@"result.location.latitude%f === result.location.latitude%f",result.location.latitude,result.location.longitude);
            self.geocodeBlock(result.location);
        }
    }
}
@end
