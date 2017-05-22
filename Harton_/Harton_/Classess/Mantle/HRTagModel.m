//
//  HRTagModel.m
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRTagModel.h"

@implementation HRTagModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}

+ (NSValueTransformer *)tagsJSONTransformer
{
    return [MTLJSONAdapter arrayTransformerWithModelClass:[HRTagDetail class]];
}

@end


@implementation HRTagDetail

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return [NSDictionary mtl_identityPropertyMapWithModel:self];
}



@end
