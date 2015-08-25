//
//  UIViewController+CustomNavigationBarItem.h
//  haid
//
//  Created by 刘 剑华 on 13-6-9.
//  Copyright (c) 2013年 figo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CustomNavigationBarItem)

// 左返回键
- (void)setNavBackItemWithTitle:(NSString*)title;
- (void)setNavBackItemByPreControllerTitle;
- (void)setNavBackItemByPreControllerBackTitle;
- (void)setNavBackItemAsDefaultStyle;
- (void)setNavLeftItemAsCatalogStyle;
- (void)setNavLeftItemWithImage:(UIImage *)img highlightImg:(UIImage*)himg;

// 右返回键   
- (void)setNavRightArrowItemWithTitle:(NSString*)title;
- (void)setNavRightItemWithImage:(UIImage*)img;
- (void)setNavRightItemWithImage:(UIImage *)img highlightImg:(UIImage*)himg;
- (void)setNavRightItemWithTitle:(NSString*)title;
- (void)setNavRightItemAsSettingStyle;

- (void)RightBarItemClick:(UIButton*)sender;
- (void)LeftBarItemClick;
- (void)BackBarItemClick;

@end
