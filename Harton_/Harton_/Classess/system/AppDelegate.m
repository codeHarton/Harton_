//
//  AppDelegate.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "AppDelegate.h"
#import <IQKeyboardManager.h>
#import "ViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [self setUpMapKit];
    [self setUpNavigatorState];
    [AFNetworkActivityIndicatorManager sharedManager].activationDelay = 0;
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    return YES;
}
- (void)setUpNavigatorState
{
    [[UINavigationBar appearance] setBackgroundImage:[Util createImageWithColor:[Util barColor] size:CGSizeMake(kScreenWidth, 64)] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor],NSFontAttributeName:[UIFont boldSystemFontOfSize:17]}];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
}


- (void)setUpMapKit
{
    BMKMapManager *manager = [[BMKMapManager alloc] init];
    
    if([manager start:Baidu_Key generalDelegate:nil])
    {
        NSLog(@"地图启动成功");
    }else{
        NSLog(@"地图启动失败");
    }
    [AMapServices sharedServices].apiKey = GaoDe_key;
    [AMapServices sharedServices].enableHTTPS =  YES;

    
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
