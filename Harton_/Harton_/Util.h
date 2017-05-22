//
//  Util.h
//  ProfessionalCredit
//
//  Created by 国诚信 on 2017/2/16.
//  Copyright © 2017年 Harton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#define kFONT(x) [UIFont systemFontOfSize:x]

#define KOriginalPhotoImagePath   \
[[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"OriginalPhotoImages"]

@interface Util : NSObject

+ (UIColor *)rgbColor:(const char*)color;
+ (UIColor *)rgbColor:(const char*)color andAlpha:(CGFloat)alpha;

//颜色转换图片
+ (UIImage*)createImageWithColor:(UIColor*)color;
+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size;

+ (UIColor *)barColor;
+ (CGSize)sizeWith:(NSString *)title font:(NSInteger)font;

+ (CGSize)sizeWith:(NSString *)title font:(NSInteger)font limitSize:(CGSize)limitSzie;
+ (void)showDatePickerFromController:(__weak UIViewController *)vc withHeightFowRowNumber:(NSInteger)rowNumber date:(NSDate *)date selectDateBlock:(void (^)(NSDate *))selectDateBlock;

+ (void)showDatePickerFromController:(__weak UIViewController *)vc withHeightFowRowNumber:(NSInteger)rowNumber datePickerModel:(UIDatePickerMode)datePickerModel alertStyle:(UIAlertControllerStyle)alertSytle  date:(NSDate *)date selectDateBlock:(void (^)(NSDate *date))selectDateBlock;

+ (NSDateFormatter *)riQiDateFormatter;
//给view添加阴影
+ (void)setShadowLayer:(UIView *)view;

+ (void)registNibWith:(UITableView *)tableView xibName:(NSString *)name;

+ (void)registNibWithCollectionView:(UICollectionView *)collectionView xibName:(NSString *)name;

+ (void)registCollectionViewFooter:(UICollectionView *)collectionView xibName:(NSString *)name;

+ (void)registCollectionViewHeader:(UICollectionView *)collectionView xibName:(NSString *)name;

+ (NSString *)getStringWithAr:(NSMutableArray *)array;

+ (BOOL)blankString:(NSString *)string;
/*获取当前时间戳 */
+(NSString*)getTimestamp;
//提示信息  若干秒后自动移除
+ (void)show:(NSString *)text view:(UIViewController *)controller;
//配对出现，易发现问题。
+ (void)showHud:(UIViewController*)controller withTitle:(NSString*)title;
+ (void)hideHud:(UIViewController*)controller;
+(void)showAlertWithTitle:(NSString*)text upToContorller:(UIViewController*)vc;
/** 转换为URLEncode */
+ (NSString*)URLEncode:(NSString *)origString;
+ (void)showAtKeyWindowWithTitle:(NSString *)title;
+ (void)hideForKeyWindow;



@end
