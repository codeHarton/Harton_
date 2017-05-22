//
//  NSArray+HRSwizee.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "NSArray+HRSwizee.h"

@implementation NSArray (HRSwizee)
+ (void)load
{
    //objectAtIndex
    Class ArrarI = NSClassFromString(@"__NSArrayI");
    [ArrarI jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(hr_objectAtIndex:) error:nil];
    
    Class singleArrarI = NSClassFromString(@"__NSSingleObjectArrayI");
    [singleArrarI jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(hr_objectAtIndex:) error:nil];
    
    Class ArrarM = NSClassFromString(@"__NSArrayM");
    [ArrarM jr_swizzleMethod:@selector(objectAtIndex:) withMethod:@selector(hr_objectAtIndex:) error:nil];
    
    
    
    
    
    
}

- (id)hr_objectAtIndex:(NSInteger)index
{
    if (index >= self.count) {
        NSLog(@"越界");
        return nil;
    }
    return [self hr_objectAtIndex:index];
}
@end
