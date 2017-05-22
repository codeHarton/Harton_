//
//  UIView+DMTools.h
//  NationalCreditPlatform
//
//  Created by 国诚信 on 16/6/16.
//  Copyright © 2016年 gcx365. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

@interface UIView (DMTools)

#pragma mark - 修改 view 的 layer 属性
/**修改view的圆角，边框*/
- (void)changeLayerCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**修改view的阴影*/
- (void)changeLayerShadowRadius:(CGFloat)radius offset:(CGSize)offset color:(UIColor *)color opacity:(CGFloat)opacity;

#pragma mark - 修改 view frame
/**横坐标*/
@property (nonatomic, assign) CGFloat x;
/**纵坐标*/
@property (nonatomic, assign) CGFloat y;
/**宽度*/
@property (nonatomic, assign) CGFloat w;
/**高度*/
@property (nonatomic, assign) CGFloat h;

@property (nonatomic, assign) CGSize size;

#pragma mark - 查找当前 view 所在的 viewController
/**查找当前 view 所在的 viewController*/
- (UIViewController *)viewController;


- (UIView *)currentMainView;/**<当前正在window上显示的主view*/


@end
