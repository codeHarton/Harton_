//
//  ListTableViewCell.h
//  HuanXinTest
//
//  Created by 国诚信 on 2017/5/4.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "UIResponder+HRRoteMessage.h"
@interface ListTableViewCell : UITableViewCell
@property (nonatomic, strong) Model *model;
@property (nonatomic, weak) IBOutlet UILabel *publisher;

@property (nonatomic, weak) IBOutlet UIButton *button;
@property (nonatomic, weak) IBOutlet UILabel *author;

@property (nonatomic, weak) IBOutlet UILabel *pubdate;
@property (nonatomic, weak) IBOutlet UILabel *summary;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@end
