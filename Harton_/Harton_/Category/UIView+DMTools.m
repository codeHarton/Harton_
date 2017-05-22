//
//  UIView+DMTools.m
//  NationalCreditPlatform
//
//  Created by 国诚信 on 16/6/16.
//  Copyright © 2016年 gcx365. All rights reserved.
//

#import "UIView+DMTools.h"

@implementation UIView (DMTools)

#pragma mark - 修改 view 的圆角，边框

- (void)changeLayerCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    if (cornerRadius > 0)
    {
        self.layer.cornerRadius = cornerRadius;
    }
    if (borderWidth > 0)
    {
        self.layer.borderWidth = borderWidth;
    }
    if (borderColor)
    {
        self.layer.borderColor = borderColor.CGColor;
    }
}

- (void)changeLayerShadowRadius:(CGFloat)radius offset:(CGSize)offset color:(UIColor *)color opacity:(CGFloat)opacity
{
    if (radius >= 0)
    {
        self.layer.shadowRadius = radius;
    }
    if (opacity > -0.001 && opacity < 1.001)
    {
        self.layer.shadowOpacity = opacity;
    }
    self.layer.shadowOffset = offset;
    self.layer.shadowColor = color.CGColor;
}

#pragma mark - 修改 view frame

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setW:(CGFloat)w
{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (CGFloat)w
{
    return self.bounds.size.width;
}


- (void)setH:(CGFloat)h
{
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

- (CGFloat)h
{
    return self.bounds.size.height;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

#pragma mark - 查找当前 view 所在的 viewController
//1）UIResponder类不会自动存储和设置它的下一个响应者（the next responder），默认情况下nextResponder方法放回nil；

//2）UIResponder的子类必须重载nextResponder方法，设置下一个响应者。比如UIView类，当管理它的UIViewController对象存在时，返回该UIViewController，否则返回它的父视图（superview）；UIViewController类返回它所管理的视图的父视图；UIWindow类返回应用对象（the application object）；UIApplication类返回nil。


/**
 *  Finds the view's view controller.
 *
 *  @return the view's view Controller
 */
- (UIViewController *)viewController
{
    // Traverse responder chain. Return first found view controller, which will be the view's view controller.
    UIResponder *responder = self;
    while ((responder = [responder nextResponder]))
    {
        if ([responder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)responder;
        }
    }
    
    return nil;
}


- (UIView *)currentMainView
{
    //获得当前显示的主window
    UIWindow *currentWidnow = [[UIApplication sharedApplication] keyWindow];
    
    //如果主window的不是普通window，找到第一个普通window
    if (currentWidnow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        
        for (currentWidnow in windows)
        {
            if (currentWidnow.windowLevel == UIWindowLevelNormal)
            {
                break;
            }
        }
    }
    
    //获得主window当前显示的view
    return [currentWidnow.subviews firstObject];
}




@end
