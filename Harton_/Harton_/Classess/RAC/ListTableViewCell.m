//
//  ListTableViewCell.m
//  HuanXinTest
//
//  Created by 国诚信 on 2017/5/4.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import <BlocksKit+UIKit.h>
//#import <UIView+BlocksKit.h>
#import "ListTableViewCell.h"
#import <UIImageView+WebCache.h>
#import <ReactiveCocoa.h>
@interface ListTableViewCell()



@end
@implementation ListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
   [self.publisher bk_whenTapped:^{
       [self routerWithEventName:@"publisher" userInfo:@{@"cell":self}];
    

   }];
    
    [self.author bk_whenTapped:^{
        [self routerWithEventName:@"author" userInfo:@{@"cell":self}];
    }];
    
    
    [self.image bk_whenTapped:^{
        [self routerWithEventName:@"image" userInfo:@{@"cell":self}];
    }];
//     Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(Model *)model
{
    _model = model;
    self.author.text = [model.author objectAtIndex:0];
    self.pubdate.text = model.pubdate;
    self.publisher.text = model.publisher;
    [self.image sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.summary.text = model.summary;
}
@end
