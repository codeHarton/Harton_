//
//  HRGDMapViewController.m
//  Harton_
//
//  Created by 国诚信 on 2017/5/10.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRGDMapViewController.h"
#import "HRMapManager.h"
@interface HRGDMapViewController ()<MAMapViewDelegate>
@property (nonatomic, weak) IBOutlet MAMapView *mapView;
@property (nonatomic, strong) HRMapManager *mapManager;
@end

@implementation HRGDMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.zoomLevel = 17;
    self.mapView.showsCompass = YES;
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.showsScale = YES;
    self.mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    
    [self.mapManager startGDLocationServiceWithComplete:^(CLLocation *location) {
        [self.mapView setCenterCoordinate:location.coordinate animated:YES];
    }];
    
    // Do any additional setup after loading the view from its nib.
}

- (HRMapManager *)mapManager
{
    if (!_mapManager) {
        _mapManager = [[HRMapManager alloc] init];
    }
    return _mapManager;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
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
