//
//  HRTagModel.h
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface HRTagModel : MTLModel<MTLJSONSerializing>
@property (nonatomic, strong) NSArray *tags;
@end


@interface HRTagDetail : MTLModel<MTLJSONSerializing>
@property(nonatomic, copy) NSString * name;
@property(nonatomic, copy) NSString * title;
@property(nonatomic, copy) NSNumber * count;
@end
