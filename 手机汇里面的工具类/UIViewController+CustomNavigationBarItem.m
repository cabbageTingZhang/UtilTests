//
//  UIViewController+CustomNavigationBarItem.m
//  haid
//
//  Created by 刘 剑华 on 13-6-9.
//  Copyright (c) 2013年 figo. All rights reserved.
//

#import "UIViewController+CustomNavigationBarItem.h"

@implementation UIViewController (CustomNavigationBarItem)


// 返回按钮
- (void)setNavBackItemByPreControllerBackTitle
{
    // 取得返回按钮的文字
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    if ([viewControllerArray count]>1) {
        int parentViewControllerIndex = (int)[viewControllerArray count] - 2;
        NSString *title = ((UIViewController*)[viewControllerArray objectAtIndex:parentViewControllerIndex]).navigationItem.backBarButtonItem.title;
        [self setNavBackItemWithTitle:title];
    }
}

// 返回按钮2
- (void)setNavBackItemByPreControllerTitle
{
    // 取得返回按钮的文字
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    if ([viewControllerArray count]>1) {
        int parentViewControllerIndex = (int)[viewControllerArray count] - 2;
        NSString *title = ((UIViewController*)[viewControllerArray objectAtIndex:parentViewControllerIndex]).navigationItem.title;
        [self setNavBackItemWithTitle:title];
    }
}

#pragma mark - 右按钮
- (void)setNavRightArrowItemWithTitle:(NSString*)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 按钮背景图片自适应
    UIImage *buttonImage = [[UIImage imageNamed:@"nav_top_right_arrow_btn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 15)];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"nav_top_right_arrow_btn_sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 15)];
    
    // 按钮文字样式
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [[button titleLabel] setShadowOffset:CGSizeMake(0.0, 1.0)];
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = [title sizeWithFont:[UIFont boldSystemFontOfSize:12.0]].width + 24.0;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    // 设置按钮背景
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setTitle:[NSString stringWithFormat:@"%@  ",title] forState:UIControlStateNormal];
    
    // 按钮事件
    [button addTarget:self action:@selector(RightBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setNavRightItemWithTitle:(NSString*)title
{
    UIBarButtonItem *button = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(RightBarItemClick:)];
    
    // 按钮事件
    //[button addTarget:self action:@selector(RightBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.rightBarButtonItem = button;
}

- (void)setNavRightItemWithImage:(UIImage*)img
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 按钮背景图片自适应
    UIImage *buttonImage = [[UIImage imageNamed:@"nav_top_detail_btn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 15)];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"nav_top_detail_btn_sel.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 15)];
    
    // 按钮文字样式
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:12.0]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [[button titleLabel] setShadowOffset:CGSizeMake(0.0, 1.0)];
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = img.size.width + 24.0;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    // 设置按钮背景
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setImage:img forState:UIControlStateNormal];
    
    // 按钮事件
    [button addTarget:self action:@selector(RightBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setNavRightItemAsSettingStyle
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 按钮背景图片自适应
    UIImage *buttonImage = [UIImage imageNamed:@"nav_top_setting_icon.png"];
    UIImage *buttonPressedImage = [UIImage imageNamed:@"nav_top_setting.png"];
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = buttonImage.size.width;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    // 设置按钮背景
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    // 按钮事件
    [button addTarget:self action:@selector(RightBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setNavRightItemWithImage:(UIImage *)img highlightImg:(UIImage*)himg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 按钮背景图片自适应
    UIImage *buttonImage = img;
    UIImage *buttonPressedImage = himg;
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = buttonImage.size.width;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    // 设置按钮背景
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    // 按钮事件
    [button addTarget:self action:@selector(RightBarItemClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)RightBarItemClick:(UIButton*)sender
{
    // 右按钮点击触发的事件，实际事件请在在子类重写
}

#pragma mark - 左按钮
- (void)setNavBackItemWithTitle:(NSString*)title
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    /*
    // 按钮背景图片自适应
    UIImage *buttonImage = [[UIImage imageNamed:@"but_nav_返回_@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
    UIImage *buttonPressedImage = [[UIImage imageNamed:@"but_nav_返回_pressed_@2x.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 15, 0, 5)];
     */
    
    // 按钮文字样式
    [[button titleLabel] setFont:[UIFont boldSystemFontOfSize:14.0]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateNormal];
    [button setTitleShadowColor:[UIColor clearColor] forState:UIControlStateHighlighted];
    [[button titleLabel] setShadowOffset:CGSizeMake(0.0, 1.0)];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = [title sizeWithFont:[UIFont boldSystemFontOfSize:14.0]].width + 10.0;
    buttonFrame.size.height = 40;
    [button setFrame:buttonFrame];
    
    // 设置按钮背景
    /*
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
     */
    [button setTitle:[NSString stringWithFormat:@"  %@",title] forState:UIControlStateNormal];
    
    // 按钮事件
    [button addTarget:self action:@selector(BackBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)BackBarItemClick
{
    NSArray *viewControllerArray = [self.navigationController viewControllers];
    if ([viewControllerArray count]>1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}

- (void)setNavBackItemAsDefaultStyle
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 按钮背景图片自适应
    UIImage *buttonImage = [UIImage imageNamed:@"btn_back.png"];
    UIImage *buttonPressedImage = [UIImage imageNamed:@"btn_back_sel.png"];
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = buttonImage.size.width;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    // 设置按钮背景
    [button setImage:buttonImage forState:UIControlStateNormal];
    [button setImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    // 按钮事件
    [button addTarget:self action:@selector(BackBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setNavLeftItemAsCatalogStyle
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // 按钮背景图片自适应
    UIImage *buttonImage = [UIImage imageNamed:@"ic_nave"];
//    UIImage *buttonPressedImage = [UIImage imageNamed:@"nav_top_catalog.png"];
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = buttonImage.size.width;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    // 设置按钮背景
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
//    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    // 按钮事件
    [button addTarget:self action:@selector(LeftBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

- (void)setNavLeftItemWithImage:(UIImage *)img highlightImg:(UIImage*)himg
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 按钮背景图片自适应
    UIImage *buttonImage = img;
    UIImage *buttonPressedImage = himg;
    
    // 设置按钮大小
    CGRect buttonFrame = [button frame];
    buttonFrame.size.width = buttonImage.size.width;
    buttonFrame.size.height = buttonImage.size.height;
    [button setFrame:buttonFrame];
    
    
    // 设置按钮背景
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    
    // 按钮事件
    [button addTarget:self action:@selector(LeftBarItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    // 添加到导航条
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];

}

- (void)LeftBarItemClick
{
    // 左按钮点击触发的事件，实际事件请在在子类重写,可能不是回到上一级视图
    
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (viewControllers.count==1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:NULL];
    }
}

@end
