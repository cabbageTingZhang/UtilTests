//
//  Util.h
//  haid
//
//  Created by 刘 剑华 on 13-6-8.
//  Copyright (c) 2013年 figo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JGProgressHUD.h"

@interface Util : NSObject

@property (nonatomic, strong) NSMutableDictionary *cachedImgDict;

+ (Util *)sharedUtil;

// 文件目录操作
+(NSString*)parentDirectoryFromPath:(NSString*)path;
+(BOOL)fileExistsAtAbsolutePath:(NSString*)filename;
+(BOOL)directoryExistsAtAbsolutePath:(NSString*)filename;
+(BOOL)createDirectoryIfNotExist:(NSString*)directoryPath;
+ (NSString*)pathInDocumentDirectory:(NSString*)fileName;
+ (NSString*)getFileNameFromPath:(NSString*)path;


// 用户信息
+(id)getUserDefaultForKey:(NSString*)key;
+(void)setUserDefaultObject:(id)value ForKey:(NSString*)key;
+(NSString*)getUserUid;
+(void)setUserUid:(NSString*)uid;
+(NSString*)getUserkey;
+(void)setUserkey:(NSString*)key;
+(NSString*)getUserAccount;
+(void)setUserAccount:(NSString*)account;
+(NSString*)getUserPassword;
+(void)setUserPassword:(NSString*)password;
+(BOOL)isLogin;

// toast
+ (void)setJGProgressHUDStyle:(JGProgressHUDStyle)style;
+ (JGProgressHUDStyle)getJGProgressHUDStyle;
+ (void)toastSuccessForView:(UIView*)view withText:(NSString*)successTips;
+ (void)toastSuccessForView:(UIView*)view withText:(NSString*)successTips position:(JGProgressHUDPosition)position;
+ (void)toastErrorForView:(UIView*)view withText:(NSString*)errorTips;
+ (void)toastErrorForView:(UIView*)view withText:(NSString*)errorTips position:(JGProgressHUDPosition)position;
+ (void)toastIndeterminateForView:(UIView*)view withText:(NSString*)text;
+ (void)toastIndeterminateForView:(UIView*)view withText:(NSString*)text position:(JGProgressHUDPosition)position dimBackgroud:(BOOL)isDim;
+ (void)toastForView:(UIView*)view withText:(NSString*)text;
+ (void)toastForView:(UIView*)view withText:(NSString*)text position:(JGProgressHUDPosition)position;
+ (void)hideToastForView:(UIView *)view animated:(BOOL)animated;
+ (void)hideToastForView:(UIView *)view;

// 图片处理工具
- (UIImage*)ClippedImageToBounds:(UIImage*)image imgRect:(CGRect)inRect cornerRadius:(CGFloat)cornerRadius cacheKey:(NSString*)cacheKey cacheDirKey:(NSString*)cacheDirKey;
- (UIImage*)ClippedImageToCircle:(UIImage*)image imgRect:(CGRect)inRect borderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor cacheKey:(NSString*)cacheKey cacheDirKey:(NSString*)cacheDirKey;
- (UIImage*)ClippedImageToCircle:(UIImage*)image imgRect:(CGRect)inRect borderWidth:(CGFloat)borderWidth cacheKey:(NSString*)cacheKey cacheDirKey:(NSString*)cacheDirKey;
+ (UIImage *)shrinkImage:(UIImage *)original :(CGSize) size;
+ (UIImage *)imageWithColor:(UIColor *)color andSize:(CGSize)size;
+ (UIImage*)makeImage:(UIImage*)image imgRect:(CGRect)inRect withborderWidth:(CGFloat)borderWidth borderColor:(UIColor*)borderColor;


+(void)cellSelectedBackView:(UITableViewCell*)cell;

// 正则
+ (BOOL) validateEmail:(NSString *)email;
+ (BOOL) validateMobile:(NSString *)mobile;
+ (BOOL) validateTel:(NSString *)tel;

// 版本相关
+(BOOL)isVersionFirstLaunchInKey:(NSString*)inkey;

// 其他工具函数
+(void)delayCallback: (void(^)(void))callback forTotalSeconds: (double)delayInSeconds;
+(CGSize)resizeText:(NSString*)text font:(UIFont*)font withConstrained:(CGSize)constrainedSize;

@end
