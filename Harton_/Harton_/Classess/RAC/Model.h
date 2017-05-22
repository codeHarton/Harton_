//
//  Model.h
//  HuanXinTest
//
//  Created by 国诚信 on 2017/5/4.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Mantle.h>
@interface Model : MTLModel<MTLJSONSerializing>
@property(nonatomic, copy) NSString * alt;
@property(nonatomic, copy) NSString * alt_title;
@property(nonatomic, strong) NSArray * author;
@property(nonatomic, copy) NSString * author_intro;
@property(nonatomic, copy) NSString * binding;
@property(nonatomic, copy) NSString * catalog;
@property(nonatomic, copy) NSString * dbid;
@property(nonatomic, copy) NSString * image;
@property(nonatomic, strong) NSDictionary *images;
@property(nonatomic, copy) NSString * summary;
@property(nonatomic, copy) NSString * publisher;
@property(nonatomic, copy) NSString * pubdate;
@property (strong , nonatomic) NSNumber *jokerId;


@property (strong , nonatomic) NSArray *tags;

@end


@interface tagModel : MTLModel<MTLJSONSerializing>
@property(nonatomic, copy) NSString * name;
@property(nonatomic, copy) NSString * title;
@property (strong , nonatomic) NSNumber *count;
@end
