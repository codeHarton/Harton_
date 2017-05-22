//
//  HRPOPViewController.m
//  Harton
//
//  Created by 国诚信 on 2017/5/8.
//  Copyright © 2017年 GCX365. All rights reserved.
//

#import "HRPOPViewController.h"
#import <RACEXTScope.h>
@interface HRPOPViewController ()
@property (nonatomic, weak)  IBOutlet UILabel *label;
@property (nonatomic, strong) RACSubject *subject;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HRPOPViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    RAC(self.label,textAlignment) = self.subject;
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(100);
       (void)make.center;
    }];

    __weak typeof(self) weakSelf = self;
    [self.view bk_whenTapped:^{
        [weakSelf popTest];
        [weakSelf.subject sendNext:@(0)];
        
    }];


    
}

- (RACSubject *)subject
{
    if (!_subject) {
        _subject = [RACSubject subject];
    }
    return _subject;
}


- (void)popTest
{
    
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {

        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            NSLog(@"valuesvaluesvaluesvaluesvalues = %f",values[0]);
            UILabel *lable = (UILabel*)obj;
            lable.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
//    anBasic.beginTime = CACurrentMediaTime() + 1.0f;    //延迟1秒开始
    [self.label pop_addAnimation:anBasic forKey:@"countdown"];

}


- (void)dealloc
{
    NSLog(@"dealloc");
}
@end
