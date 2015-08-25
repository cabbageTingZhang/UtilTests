
/**
 *  主要功能:
 *  1,通过代码适配,传入不同的参数进行布局,选择不同的图片,设置字体大小
 *  2,手机号码验证
 *
 */

#import "Adapter.h"

@implementation Adapter

/**
 *  根据当前屏幕高度选择不同的位置布局
 *
 *  @param rect4  4S的位置布局
 *  @param rect5  5/5S的位置布局
 *  @param rect6  6的位置布局
 *  @param rect6_ 6S的位置布局
 *
 *  @return 返回相应的位置布局
 */
+(CGRect) set4Frame:(CGRect)rect4 and5Frame:(CGRect)rect5 and6Frame:(CGRect)rect6 and6_Frame:(CGRect) rect6_
{
    if(currentScreenHeight == 480.0f){
        return rect4;
    }else if (currentScreenHeight == 568.0f){
        return rect5;
    }else if (currentScreenHeight == 667.0f){
        return rect6;
    }else if (currentScreenHeight == 736.0f){
        return rect6_;
    }
    return rect4;
}

/**
 *  根据当前屏幕高度选择不同的图片
 *
 *  @param image 图片名字
 *
 *  @return 返回拼后的相应图片名
 */
+(NSString *) setImage:(NSString *)image
{
    if(currentScreenHeight == 480.0f){
        return image;
    }else if (currentScreenHeight == 568.0f){
        return [NSString stringWithFormat:@"%@5",image];
    }else if (currentScreenHeight == 667.0f){
        return [NSString stringWithFormat:@"%@6",image];
    }else if (currentScreenHeight == 736.0f){
        return [NSString stringWithFormat:@"%@6_",image];
    }
    return [NSString stringWithFormat:@"%@",image];
}

/**
 *  设置字体大小
 *
 *  @param rect4  4S的字体大小
 *  @param rect5  5/5S的字体大小
 *  @param rect6  6的字体大小
 *  @param rect6_ 6S的字体大小
 *
 *  @return 字体大小
 */
+(UIFont *)set4Font:(float)font4 and5Font:(float)font5 and6Font:(float)font6 and6_Font:(float)font6_
{
    if(currentScreenHeight == 480.0f){
        return [UIFont systemFontOfSize:font4];
    }else if (currentScreenHeight == 568.0f){
        return [UIFont systemFontOfSize:font5];
    }else if (currentScreenHeight == 667.0f){
        return [UIFont systemFontOfSize:font6];
    }else if (currentScreenHeight == 736.0f){
        return [UIFont systemFontOfSize:font6_];
    }
    return [UIFont systemFontOfSize:font4];
}

/**
 *  设置加粗字体大小
 *
 *  @param rect4  4S的字体大小
 *  @param rect5  5/5S的字体大小
 *  @param rect6  6的字体大小
 *  @param rect6_ 6S的字体大小
 *
 *  @return 字体大小
 */
+(UIFont *)setBold4Font:(float)font4 and5Font:(float)font5 and6Font:(float)font6 and6_Font:(float)font6_
{
    if(currentScreenHeight == 480.0f){
        return [UIFont boldSystemFontOfSize:font4];
    }else if (currentScreenHeight == 568.0f){
        return [UIFont boldSystemFontOfSize:font5];
    }else if (currentScreenHeight == 667.0f){
        return [UIFont boldSystemFontOfSize:font6];
    }else if (currentScreenHeight == 736.0f){
        return [UIFont boldSystemFontOfSize:font6_];
    }
    return [UIFont boldSystemFontOfSize:font4];
}

//验证手机号码
+ (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|77|70|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
