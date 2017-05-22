//
//  Util.m
//  ProfessionalCredit
//
//  Created by 国诚信 on 2017/2/16.
//  Copyright © 2017年 Harton. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (UIColor *)rgbColor:(const char*)color
{
    int Red = 0, Green = 0, Blue = 0;
    sscanf(color, "%2x%2x%2x", &Red, &Green, &Blue);
    return [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:1.0];
}

+ (UIColor *)rgbColor:(const char*)color andAlpha:(CGFloat)alpha
{
    int Red = 0, Green = 0, Blue = 0;
    sscanf(color, "%2x%2x%2x", &Red, &Green, &Blue);
    return [UIColor colorWithRed:Red/255.0 green:Green/255.0 blue:Blue/255.0 alpha:alpha];
}

+ (UIColor *)barColor
{
    return [UIColor colorWithRed:42 / 255.0 green:153 / 255.0 blue:244 / 255.0 alpha:1];
}

//颜色转换图片
+ (UIImage*)createImageWithColor:(UIColor*)color
{
    return [self createImageWithColor:color size:CGSizeMake(5.0f, 5.0f)];
}

+ (UIImage *)createImageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}



//字体宽度
+ (CGSize)sizeWith:(NSString *)title font:(NSInteger)font
{
    CGSize limitSize = CGSizeMake(kScreenWidth, MAXFLOAT);
    CGSize size = [title boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFONT(font)} context:NULL].size;
    return size;
}

+ (CGSize)sizeWith:(NSString *)title font:(NSInteger)font limitSize:(CGSize)limitSzie
{
    CGSize size = [title boundingRectWithSize:limitSzie options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: kFONT(font)} context:NULL].size;
    return size;
}


+ (void)showDatePickerFromController:(__weak UIViewController *)vc withHeightFowRowNumber:(NSInteger)rowNumber date:(NSDate *)date selectDateBlock:(void (^)(NSDate *date))selectDateBlock
{
    //action sheet
    NSMutableString *rowString = [NSMutableString string];
    for (NSInteger i = 0; i < rowNumber + 2; ++i)
    {
        [rowString appendString:@"\n"];
    }
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:rowString preferredStyle:UIAlertControllerStyleActionSheet];
    
    //date picker
    UIDatePicker *dp = [[UIDatePicker alloc] init];
    dp.datePickerMode = UIDatePickerModeDate;
    dp.date = date ? date : [NSDate date];
    dp.w = CGRectGetWidth([UIScreen mainScreen].bounds) - 16.0;
    [ac.view addSubview:dp];
    
    //action cancel
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //action ok
    //    __weak typeof(selectDateBlock) weakBlock = selectDateBlock;
    __weak typeof(dp) weakDp = dp;
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        if (selectDateBlock)
        {
            NSDate *selectDate = weakDp.date;
            selectDateBlock(selectDate);
        }
    }];
    
    [ac addAction:cancel];
    [ac addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [vc presentViewController:ac animated:YES completion:nil];
    });
}
+ (NSDateFormatter *)riQiDateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"YYYY-MM-dd"];
    return formatter;
}

+ (void)setShadowLayer:(UIView *)view
{
    view.layer.shadowColor = [Util barColor].CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowOpacity = 0.8;//阴影透明度，默认0
    view.layer.shadowRadius = 4;//阴影半径，默认3
}

+ (void)registNibWith:(UITableView *)tableView xibName:(NSString *)name
{
    [tableView registerNib:[UINib nibWithNibName:name bundle:nil] forCellReuseIdentifier:name];
}

+ (void)registNibWithCollectionView:(UICollectionView *)collectionView xibName:(NSString *)name
{
    [collectionView registerNib:[UINib nibWithNibName:name bundle:nil] forCellWithReuseIdentifier:name];
}

+ (void)registCollectionViewFooter:(UICollectionView *)collectionView xibName:(NSString *)name;
{

    [collectionView registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:name];
}

+ (void)registCollectionViewHeader:(UICollectionView *)collectionView xibName:(NSString *)name;
{
    [collectionView registerNib:[UINib nibWithNibName:name bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:name];
}

+ (void)showDatePickerFromController:(__weak UIViewController *)vc withHeightFowRowNumber:(NSInteger)rowNumber datePickerModel:(UIDatePickerMode)datePickerModel alertStyle:(UIAlertControllerStyle)alertSytle  date:(NSDate *)date selectDateBlock:(void (^)(NSDate *date))selectDateBlock
{
    //action sheet
    NSMutableString *rowString = [NSMutableString string];
    for (NSInteger i = 0; i < rowNumber; ++i)
    {
        [rowString appendString:@"\n"];
    }
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:rowString preferredStyle:alertSytle];
    
    //date picker
    UIDatePicker *dp = [[UIDatePicker alloc] init];
    dp.datePickerMode = datePickerModel;
    dp.date = date ? date : [NSDate date];
    
    if (kScreenWidth == 375) {
        dp.w = CGRectGetWidth([UIScreen mainScreen].bounds) - 90.0;
    }else if(kScreenWidth == 414){
        dp.w = CGRectGetWidth([UIScreen mainScreen].bounds) - 127;
    }else{
        dp.w = CGRectGetWidth([UIScreen mainScreen].bounds) - 50;
    }
    [ac.view addSubview:dp];
    
    //action cancel
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    
    //action ok
    //    __weak typeof(selectDateBlock) weakBlock = selectDateBlock;
    __weak typeof(dp) weakDp = dp;
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        if (selectDateBlock)
        {
            NSDate *selectDate = weakDp.date;
            selectDateBlock(selectDate);
        }
    }];
    
    [ac addAction:cancel];
    [ac addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [vc presentViewController:ac animated:YES completion:nil];
    });
}

+ (NSString *)getStringWithAr:(NSMutableArray *)array
{
    if (!array | (array.count == 0)) {
        return nil;
    }
    NSMutableString *string = [NSMutableString string];
    if ([array containsObject:@1]) {
        [string appendFormat:@"%@",@"星期一"];
    }
    if ([array containsObject:@2]) {
        [string appendFormat:@"  %@",@"星期二"];
    }
    if ([array containsObject:@3]) {
        [string appendFormat:@"  %@",@"星期三"];
    }
    if ([array containsObject:@4]) {
        [string appendFormat:@"  %@",@"星期四"];
    }
    if ([array containsObject:@5]) {
        [string appendFormat:@"  %@",@"星期五"];
    }
    if ([array containsObject:@6]) {
        [string appendFormat:@"  %@",@"星期六"];
    }
    if ([array containsObject:@7]) {
        [string appendFormat:@"  %@",@"星期日"];
    }
    return string;
}

+ (BOOL)blankString:(NSString *)string
{
    if (!string) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([string isEqualToString:@""]) {
        return YES;
    }
    return NO;
}


+(NSString*)getTimestamp
{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970]*1000;
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    return timeString;
}

//提示信息  若干秒后自动移除
+ (void)show:(NSString *)text view:(UIViewController *)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = controller.view;
        if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        //    hud.customView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, 0.01)];
        hud.label.text = text;
        //    hud.mode = MBProgressHUDModeIndeterminate;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:0.7];
    });
    
}

+ (void)showAtKeyWindowWithTitle:(NSString*)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:[Util keyWindow] animated:YES];
//        HUD.userInteractionEnabled = NO;
        HUD.label.text = title;
    });
}
+ (void)hideForKeyWindow
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:[Util keyWindow] animated:YES];
    });
}
+ (UIView *)keyWindow
{
    return [[[UIApplication sharedApplication] delegate] window];
}

//配对出现，易发现问题。
+ (void)showHud:(UIViewController*)controller withTitle:(NSString*)title
{
    dispatch_async(dispatch_get_main_queue(), ^{
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:controller.view animated:YES];
        HUD.label.text = title;
    });
    
}
+ (void)hideHud:(UIViewController*)controller
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:controller.view animated:YES];
    });
}

+(void)showAlertWithTitle:(NSString*)text upToContorller:(UIViewController*)vc
{
    UIAlertController * ac=[UIAlertController alertControllerWithTitle:@"" message:text preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction * ok=[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [ac addAction:ok];
    [vc presentViewController:ac animated:YES completion:^{
        
    }];
}
//-----------------------------------------------------------
+ (NSString*)URLEncode:(NSString*)origString
{
    //注意：
    //不要只使用网络的参数：@"`#%^{}\"[]|\\<> "
    //原来是这个：@"!*'();:@&=+$,/?%#[] "，同时合并上面的字符（排除相同的字符），才能正确编码。
    return [Util addingPercentEncoding:origString withChartSet:@"!*'();:@&=+$,/?%#[] `^{}\"|\\<>"];
}

//+ (NSString*)URLDecode:(NSString*)origString
//{
//    return [Util removingPercentEncoding:origString];
//}

//URL字符串转换
+ (NSString*)addingPercentEncoding:(NSString*)string withChartSet:(NSString*)charSet
{
    NSString * result;
    
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
    if ([string respondsToSelector:@selector(stringByAddingPercentEncodingWithAllowedCharacters:)])
    {
        NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:charSet].invertedSet;
        result = [string stringByAddingPercentEncodingWithAllowedCharacters:set];
    }
    else
    {
        CFStringRef ref = CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)string, NULL, (CFStringRef)charSet, kCFStringEncodingUTF8);
        result = (NSString *)CFBridgingRelease(ref);
    }
#else
    {
        NSCharacterSet * set = [NSCharacterSet characterSetWithCharactersInString:charSet].invertedSet;
        result = [string stringByAddingPercentEncodingWithAllowedCharacters:set];
    }
#endif
    
    return result;
}

+ (void)test {
    
}

@end
