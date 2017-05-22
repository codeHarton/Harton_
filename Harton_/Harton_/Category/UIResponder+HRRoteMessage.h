//
//  UIResponder+HRRoteMessage.h
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (HRRoteMessage)

- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
