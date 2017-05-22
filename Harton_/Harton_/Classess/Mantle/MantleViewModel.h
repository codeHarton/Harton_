//
//  HRMantleViewModel.h
//  Harton
//
//  Created by 国诚信 on 2017/5/5.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <Mantle/Mantle.h>
#import "HRTagModel.h"
@interface MantleViewModel : HRBaseViewModel
@property (strong , nonatomic) RACCommand *command;

@property(nonatomic, copy) NSString * testKVOController;

@end
