//
//  Notification.m
//  Harton_
//
//  Created by 国诚信 on 2017/5/12.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "Notification.h"
#import <UserNotifications/UserNotifications.h>


#ifndef __Harton
#define __Harton

#endif


@implementation Notification

- (void)dispatch
{
    
    
#ifdef __Harton
    UNUserNotificationCenter *n = [UNUserNotificationCenter currentNotificationCenter];
    //    n requestAuthorizationWithOptions:<#(UNAuthorizationOptions)#> completionHandler:<#^(BOOL granted, NSError * _Nullable error)completionHandler#>
    [[UIApplication sharedApplication] registerForRemoteNotifications];
    [n getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        
    }];
#else
    
    
#endif
    
}
@end
