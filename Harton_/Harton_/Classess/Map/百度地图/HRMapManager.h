//
//  HRMapManager.h
//  Harton
//
//  Created by 国诚信 on 2017/5/9.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^cllocationCompleteBlock)(BMKUserLocation *userLocation);
@interface HRMapManager : NSObject
- (void)startLocationServiceWithCompleteBlock:(cllocationCompleteBlock)block;

- (void)startGDLocationServiceWithComplete:(void(^)(CLLocation *location))complete;

@end
