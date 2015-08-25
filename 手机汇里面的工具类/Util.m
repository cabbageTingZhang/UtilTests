//
//  Util.m
//  haid
//
//  Created by 刘 剑华 on 13-6-8.
//  Copyright (c) 2013年 figo. All rights reserved.
//

#import "Util.h"
#import <QuartzCore/QuartzCore.h>
#import "JGProgressHUD.h"
#import "JGProgressHUDPieIndicatorView.h"
#import "JGProgressHUDRingIndicatorView.h"
#import "JGProgressHUDFadeZoomAnimation.h"


@interface Util () <JGProgressHUDDelegate>

@end


@implementation Util

@synthesize cachedImgDict;

+ (Util *)sharedUtil
{
    static Util *_shareUtil = nil;
    static dispatch_once_t utilOnceToken;
    
    dispatch_once(&utilOnceToken, ^{
        _shareUtil = [[self alloc] init];
    });
    return _shareUtil;
}

- (id)init
{
    self = [super init];
    if (self) {
        cachedImgDict = [NSMutableDictionary dictionary];
    }
    return self;
}

//计算两个经纬度坐标的距离
+ (double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2
{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    return   distance;
    
}


#pragma mark 文件处理工具方法

// 取得路径的父目录
+(NSString*)parentDirectoryFromPath:(NSString*)path
{
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"/"];
    NSRange lastCharRange = [path rangeOfCharacterFromSet:charSet options:NSBackwardsSearch];
    NSString *parentDirectory = [path substringToIndex:lastCharRange.location+1];
    
    return parentDirectory;
}

// 文件是否存在
+(BOOL)fileExistsAtAbsolutePath:(NSString*)filename
{
    BOOL isDirectory;
    BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:filename isDirectory:&isDirectory];
    
    return fileExistsAtPath && !isDirectory;
}

// 目录是否存在
+(BOOL)directoryExistsAtAbsolutePath:(NSString*)filename
{
    BOOL isDirectory;
    BOOL fileExistsAtPath = [[NSFileManager defaultManager] fileExistsAtPath:filename isDirectory:&isDirectory];
    
    return fileExistsAtPath && isDirectory;
}

// 创建目录
+(BOOL)createDirectoryIfNotExist:(NSString*)directoryPath
{
    // 如果目录不存在则创建
    if (![Util directoryExistsAtAbsolutePath:directoryPath]) {
        NSError * error = nil;
        BOOL isSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:directoryPath
                                                   withIntermediateDirectories:YES
                                                                    attributes:nil
                                                                         error:&error];
        if (error) {
            NSLog(@"创建文件目录‘%@’失败：%@",directoryPath, error);
        }
        return isSuccess;
    }
    
    return NO;
}

// 取得document目录路径
+ (NSString*)pathInDocumentDirectory:(NSString*)fileName{
    //获取沙盒中的文档目录
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    //从返回数组中得到第一个，也是唯一的一个文档目录
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    //将传入的文件名加在目录路径后面并返回
    return [documentDirectory stringByAppendingPathComponent:fileName];
}

// 取得文件名
+ (NSString*)getFileNameFromPath:(NSString*)path
{
    NSString *fileName = [NSString string];
    NSCharacterSet *charSet = [NSCharacterSet characterSetWithCharactersInString:@"/"];
    NSRange lastCharRange = [path rangeOfCharacterFromSet:charSet options:NSBackwardsSearch];
    
    if (lastCharRange.location == NSNotFound) {
        NSLog(@"not found");
    }else{
        fileName = [path substringFromIndex:lastCharRange.location + 1];
    }
    
    return fileName;
}


#pragma mark - 获取用户信息

+(id)getUserDefaultForKey:(NSString*)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:key];
}

+(void)setUserDefaultObject:(id)value ForKey:(NSString*)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
}

// 返回用户uid
+(NSString*)getUserUid
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault stringForKey:@"userid"];
}

+(void)setUserUid:(NSString*)uid
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:uid forKey:@"userid"];
    [userDefault synchronize];
}

// 返回用户key
+(NSString*)getUserkey
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault stringForKey:@"key"];
}

+(void)setUserkey:(NSString*)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:key forKey:@"key"];
    [userDefault synchronize];
}

// 返回用户名
+(NSString*)getUserAccount
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault stringForKey:@"account"];
}

+(void)setUserAccount:(NSString*)account
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:account forKey:@"account"];
    [userDefault synchronize];
}

// 返回用户密码
+(NSString*)getUserPassword
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault stringForKey:@"password"];
}

+(void)setUserPassword:(NSString*)password
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:password forKey:@"password"];
    [userDefault synchronize];
}

+(BOOL)isLogin
{
    NSString *token = [Util getUserkey];
    if (token && token.length>0) {
        return YES;
    }else{
        return NO;
    }
}

// 返回用户角色id
+(NSString*)getUserRoleId
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault stringForKey:@"roleID"];
}

+(void)setUserRoleId:(NSString*)roldID
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:roldID forKey:@"roleID"];
    [userDefault synchronize];
}

#pragma mark - toast提示

/*
// 加载指示器型提示
- (void)toastIndeterminateForView:(UIView*)view withText:(NSString*)text withDetailText:(NSString*)detailText dimBackgroud:(BOOL)YesOrNo
{
    if (!view) return;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.dimBackground = YesOrNo;
    HUD.delegate = self;
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = text;
    HUD.detailsLabelText = detailText;
}

// 定时消失提示
- (void)toastForView:(UIView*)view withText:(NSString*)text hideAfterDelay:(NSTimeInterval)delay
{
    if (!view) return;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.delegate = self;
    HUD.mode = MBProgressHUDModeText;
    [HUD setLabelText:text];
    [HUD hide:YES afterDelay:delay];
}

// 钩子图表的提示
- (void)toastCompleteForView:(UIView*)view withText:(NSString*)text hideAfterDelay:(NSTimeInterval)delay
{
    if (!view) return;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    HUD.delegate = self;
	
	// The sample image is based on the work by http://www.pixelpressicons.com, http://creativecommons.org/licenses/by/2.5/ca/
	// Make the customViews 37 by 37 pixels for best results (those are the bounds of the build-in progress indicators)
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	
	// Set custom view mode
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = text;
	
	[HUD hide:YES afterDelay:delay];
}

// 关闭指定view的所有提示
- (void)hideToastForView:(UIView*)view
{
    if (!view) return;
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
	// Remove HUD from screen when the HUD was hidded
	[hud removeFromSuperview];
}
*/

#pragma mark - Toast

static JGProgressHUDStyle hudStyle = JGProgressHUDStyleExtraLight;

+ (void)setJGProgressHUDStyle:(JGProgressHUDStyle)style
{
    hudStyle = style;
}

+ (JGProgressHUDStyle)getJGProgressHUDStyle
{
    return hudStyle;
}

+ (void)toastSuccessForView:(UIView*)view withText:(NSString*)successTips
{
    [self toastSuccessForView:view withText:successTips position:JGProgressHUDPositionCenter];
}

+ (void)toastSuccessForView:(UIView*)view withText:(NSString*)successTips position:(JGProgressHUDPosition)position
{
    [self hideToastForView:view animated:NO];
    
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:hudStyle];
    HUD.position = position;
    HUD.userInteractionEnabled = YES;
    HUD.delegate = nil;
    
    UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_hud_success.png"]];
    HUD.textLabel.text = successTips;
    JGProgressHUDIndicatorView *ind = [[JGProgressHUDIndicatorView alloc] initWithContentView:errorImageView];
    HUD.progressIndicatorView = ind;
    
    HUD.square = YES;
    
    [HUD showInView:view];
    
    [HUD dismissAfterDelay:2.0];
}

+ (void)toastErrorForView:(UIView*)view withText:(NSString*)errorTips
{
    [self toastErrorForView:view withText:errorTips position:JGProgressHUDPositionCenter];
}

+ (void)toastErrorForView:(UIView*)view withText:(NSString*)errorTips position:(JGProgressHUDPosition)position
{
    [self hideToastForView:view animated:NO];
    
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:hudStyle];
    HUD.position = position;
    HUD.userInteractionEnabled = YES;
    HUD.delegate = nil;
    
    UIImageView *errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jg_hud_error.png"]];
    HUD.textLabel.text = errorTips;
    JGProgressHUDIndicatorView *ind = [[JGProgressHUDIndicatorView alloc] initWithContentView:errorImageView];
    HUD.progressIndicatorView = ind;
    
    HUD.square = YES;
    
    [HUD showInView:view];
    
    [HUD dismissAfterDelay:2.0];
}

+ (void)toastIndeterminateForView:(UIView*)view withText:(NSString*)text
{
    [self toastIndeterminateForView:view withText:text position:JGProgressHUDPositionCenter dimBackgroud:NO];
}

+ (void)toastIndeterminateForView:(UIView*)view withText:(NSString*)text position:(JGProgressHUDPosition)position dimBackgroud:(BOOL)isDim
{
    [self hideToastForView:view animated:NO];
    
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:hudStyle];
    HUD.position = position;
    HUD.textLabel.text = text;
    HUD.delegate = nil;
    HUD.userInteractionEnabled = YES;
    if (isDim) {
        HUD.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.4f];
    }
    [HUD showInView:view];
}

+ (void)toastForView:(UIView*)view withText:(NSString*)text
{
    [self toastForView:view withText:text position:JGProgressHUDPositionCenter];
}

+ (void)toastForView:(UIView*)view withText:(NSString*)text position:(JGProgressHUDPosition)position
{
    [self hideToastForView:view animated:NO];
    
    JGProgressHUD *HUD = [[JGProgressHUD alloc] initWithStyle:hudStyle];
    HUD.useProgressIndicatorView = NO;
    HUD.userInteractionEnabled = YES;
    HUD.textLabel.text = text;
    HUD.delegate = nil;
    HUD.position = position;
    HUD.marginInsets = (UIEdgeInsets) {
        .top = 0.0f,
        .bottom = 20.0f,
        .left = 0.0f,
        .right = 0.0f,
    };
    
    [HUD showInView:view];
    
    [HUD dismissAfterDelay:2.0f];
}

+ (void)hideToastForView:(UIView *)view
{
    [self hideToastForView:view animated:YES];
}

+ (void)hideToastForView:(UIView *)view animated:(BOOL)animated
{
    NSArray *HUDViews = [JGProgressHUD allProgressHUDsInView:view];
    for (JGProgressHUD *HUD in HUDViews) {
        HUD.userInteractionEnabled = NO;
        [HUD dismissAnimated:animated];
    }
}

#pragma mark - color tools
+ (UIColor *) colorWithHex:(int)hex alpha:(CGFloat)alpha {
    return [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0
                           green:((float)((hex & 0xFF00) >> 8))/255.0
                            blue:((float)(hex & 0xFF))/255.0 alpha:alpha];
}

#pragma mark - 图片处理工具
// 加圆角的图片
- (UIImage*)ClippedImageToBounds:(UIImage*)image imgRect:(CGRect)inRect cornerRadius:(CGFloat)cornerRadius cacheKey:(NSString*)cacheKey cacheDirKey:(NSString*)cacheDirKey
{
    // 从缓存中返回
    if (cacheKey) {
        if (!cacheDirKey||[cacheDirKey length]==0) {
            cacheDirKey = @"ClippedImageToBounds";
        }
        NSMutableDictionary *cachedDict = [cachedImgDict objectForKey:cacheDirKey];
        UIImage *imgData = [cachedDict objectForKey:cacheKey];
        if (imgData) {
            return imgData;
        }
    }
    
    // 生成图片
    // Begin a new image that will be the new image with the rounded corners
    UIGraphicsBeginImageContextWithOptions(inRect.size, NO, [[UIScreen mainScreen] scale]);
    
    CGRect imgBounds = CGRectZero;
    imgBounds.size = inRect.size;
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:imgBounds cornerRadius:cornerRadius] addClip];
    // Draw your image
    [image drawInRect:imgBounds];
    
    // Get the image, here setting the UIImageView image
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    
    // 缓存图片
    if (cacheKey) {
        NSMutableDictionary *cachedDict = [cachedImgDict objectForKey:cacheDirKey];
        if (!cachedDict) {
            cachedDict=[NSMutableDictionary dictionary];
            [cachedImgDict setObject:cachedDict forKey:cacheDirKey];
        }
        [cachedDict setObject:resizedImage forKey:cacheKey];
    }
    
    return resizedImage;
}

- (UIImage*)ClippedImageToCircle:(UIImage*)image imgRect:(CGRect)inRect borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor cacheKey:(NSString*)cacheKey cacheDirKey:(NSString*)cacheDirKey
{
    // 从缓存中返回
    if (cacheKey) {
        if (!cacheDirKey||[cacheDirKey length]==0) {
            cacheDirKey = @"ClippedImageToCircle";
        }
        NSMutableDictionary *cachedDict = [cachedImgDict objectForKey:cacheDirKey];
        UIImage *imgData = [cachedDict objectForKey:cacheKey];
        if (imgData) {
            return imgData;
        }
    }
    
    // 生成图片
    CGRect imgBounds = CGRectZero;
    imgBounds.size = inRect.size;
    
    UIGraphicsBeginImageContextWithOptions(inRect.size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIImageView *imageLayView = [[UIImageView alloc] initWithFrame:imgBounds];
    imageLayView.image = image;
    
    CALayer *layer = [imageLayView layer];
    layer.cornerRadius = imgBounds.size.height/2;
    layer.borderWidth = borderWidth;
    borderColor = borderColor ?: [UIColor whiteColor];
    layer.borderColor = borderColor.CGColor;
    [layer setMasksToBounds:YES];
    
    
    CGContextClearRect(ctx, imgBounds);
    [imageLayView.layer renderInContext:ctx];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    // 缓存图片
    if (cacheKey) {
        NSMutableDictionary *cachedDict = [cachedImgDict objectForKey:cacheDirKey];
        if (!cachedDict) {
            cachedDict=[NSMutableDictionary dictionary];
            [cachedImgDict setObject:cachedDict forKey:cacheDirKey];
        }
        [cachedDict setObject:resizedImage forKey:cacheKey];
    }
    
    return resizedImage;
}

- (UIImage*)ClippedImageToCircle:(UIImage*)image imgRect:(CGRect)inRect borderWidth:(CGFloat)borderWidth cacheKey:(NSString*)cacheKey cacheDirKey:(NSString*)cacheDirKey
{
    return [self ClippedImageToCircle:image imgRect:inRect borderWidth:borderWidth borderColor:nil cacheKey:cacheKey cacheDirKey:cacheDirKey];
}

+ (UIImage*)makeImage:(UIImage*)image imgRect:(CGRect)inRect withborderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor
{
    
    // 生成图片
    CGRect imgBounds = CGRectZero;
    imgBounds.size = inRect.size;
    
    UIGraphicsBeginImageContextWithOptions(inRect.size, NO, [[UIScreen mainScreen] scale]);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    UIImageView *imageLayView = [[UIImageView alloc] initWithFrame:imgBounds];
    imageLayView.image = image;
    
    CALayer *layer = [imageLayView layer];
    layer.borderWidth = borderWidth;
    borderColor = borderColor ?: [UIColor whiteColor];
    layer.borderColor = borderColor.CGColor;
    
    CGContextClearRect(ctx, imgBounds);
    [imageLayView.layer renderInContext:ctx];
    UIImage *resizedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resizedImage;
}

// 图片缩放裁减压缩的方法
+(UIImage *)shrinkImage:(UIImage *)original :(CGSize) size{
    CGFloat scale = [UIScreen mainScreen].scale;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    CGContextRef context = CGBitmapContextCreate(NULL, size.width*scale, size.height*scale, 8, 0, colorSpace, kCGBitmapAlphaInfoMask);
    CGContextDrawImage(context, CGRectMake(0, 0, size.width*scale, size.height*scale), original.CGImage);
    CGImageRef shrunken = CGBitmapContextCreateImage(context);
    UIImage *final = [UIImage imageWithCGImage:shrunken];
    
    CGContextRelease(context);
    CGImageRelease(shrunken);
    
    return final;
}

// 根据颜色创建图片
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
{
    UIImage *img = nil;
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

+(void)cellSelectedBackView:(UITableViewCell*)cell
{
    UIView*selectView=[[UIView alloc]initWithFrame:cell.contentView.frame];
    selectView.backgroundColor=[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:0.1];
    cell.selectedBackgroundView=selectView;
}

// 版本相关
+(BOOL)isVersionFirstLaunchInKey:(NSString*)inkey
{
    NSDictionary *infoDictionary = [[NSBundle mainBundle]infoDictionary];
    NSString *version = infoDictionary[(NSString*)kCFBundleVersionKey];
    NSString *key = [NSString stringWithFormat:@"firstLaunch_%@_%@",inkey,version];
    id firstLaunchObject = [self getUserDefaultForKey:key];
    if (!firstLaunchObject) {
        [self setUserDefaultObject:@YES ForKey:key];
        return YES;
    }else{
        return NO;
    }
}

#pragma mark - 正则表达式
//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//手机号码验证
+ (BOOL) validateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1[3|4|5|6|7|8|9][0-9]{1}[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//电话号码验证
+ (BOOL) validateTel:(NSString *)tel
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *telRegex = @"^(([0\\+]\\d{2,3}-)?(0\\d{2,3})-)?(\\d{7,8})(-(\\d{3,}))?$";
    NSPredicate *telTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",telRegex];
    return [telTest evaluateWithObject:tel];
}

#pragma mark - 其他工具函数

+(void)delayCallback: (void(^)(void))callback forTotalSeconds: (double)delayInSeconds{
    
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        if(callback){
            callback();
        }
        
    });
    
}

+(CGSize)resizeText:(NSString*)text font:(UIFont*)font withConstrained:(CGSize)constrainedSize
{
    CGSize resize = CGSizeZero;
    if (isiOS7orLater) {
        //iOS 7
        CGRect frame = [text boundingRectWithSize:constrainedSize
                                                            options:NSStringDrawingUsesLineFragmentOrigin
                                                         attributes:@{NSFontAttributeName:font}
                                                            context:nil];
        resize = CGSizeMake(frame.size.width, frame.size.height);
    }else{
        //iOS 6.0
        resize = [text sizeWithFont:font constrainedToSize:constrainedSize lineBreakMode:NSLineBreakByWordWrapping];
    }

    return resize;
}

@end
