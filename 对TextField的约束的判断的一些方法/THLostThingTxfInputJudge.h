//
//  THLostThingTxfInputJudge.h
//  Friday
//
//  Created by mac-mini-ios on 15/8/17.
//  Copyright (c) 2015年 xtuone. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface THLostThingTxfInputJudge : NSObject

//返回字符串有多少个字节
+ (long)lengthOfString:(NSString *)str;
//判断输入的字符串中是否有中文
+ (BOOL)isChinese:(NSString *)str;
//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobileNum;
//emoji表情的判断
+ (BOOL)stringContainsEmoji:(NSString *)string;

@end
