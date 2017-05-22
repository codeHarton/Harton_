//
//  UIResponder+HRRoteMessage.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "UIResponder+HRRoteMessage.h"

@implementation UIResponder (HRRoteMessage)
- (void)routerWithEventName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if (self.nextResponder) {
        [[self nextResponder] routerWithEventName:eventName userInfo:userInfo];
    }
}
@end
