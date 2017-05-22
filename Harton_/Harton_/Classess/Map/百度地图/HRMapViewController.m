//
//  HRMapViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/9.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRMapViewController.h"
#import "NCUserLocationManager.h"
#import "HRMapManager.h"
@interface HRMapViewController ()<BMKMapViewDelegate>
@property (nonatomic,weak)IBOutlet BMKMapView *mapView;
@property (nonatomic, strong) HRMapManager *mapManager;
@property (nonatomic, weak) IBOutlet UILabel *attitude;
@property (nonatomic, weak) IBOutlet UILabel *speed;
@property (nonatomic, assign) NSInteger count;

@end

@implementation HRMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.mapView.zoomLevel = 16;
    __weak typeof(self) weakSelf = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = BMKUserTrackingModeFollow;
    [self.mapManager startLocationServiceWithCompleteBlock:^(BMKUserLocation *userLocation) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf setPointanimationWith:userLocation];
        });
        
    }];
}

- (void)setPointanimationWith:(BMKUserLocation *)userLocation
{
    CLLocation *location = userLocation.location;
//    BMKLocationViewDisplayParam *param = [[BMKLocationViewDisplayParam alloc] init];
//    param.isAccuracyCircleShow = NO;
//    param.accuracyCircleFillColor = [UIColor redColor];
//    param.accuracyCircleStrokeColor = [UIColor blueColor];
//    [self.mapView updateLocationViewWithParam:param];
    [self.mapView updateLocationData:userLocation];
    
    self.attitude.text = [NSString stringWithFormat:@"%.2f",location.altitude];
    self.speed.text = [NSString stringWithFormat:@"%.2f",location.speed];

    
//    if (self.count % 30 == 0) {
//        NSLog(@"_count_count%ld",_count);
//        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
//        
//        annotation.coordinate = location.coordinate;
//        annotation.title = @"place";
//        [self.mapView addAnnotation:annotation];
//        
//
//        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
//
//    }
//    self.count++;
    
    
}
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id<BMKAnnotation>)annotation
{
    BMKAnnotationView *annoView = [[BMKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"annotation"];
    return annoView;
}
- (HRMapManager *)mapManager
{
    if (!_mapManager) {
        _mapManager = [[HRMapManager alloc] init];
    }
    return _mapManager;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.mapView.delegate = self;
    [self.mapView viewWillAppear];
    
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.mapView.delegate = nil;
    [self.mapView viewWillDisappear];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc
{
    NSLog(@"dealloc");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
