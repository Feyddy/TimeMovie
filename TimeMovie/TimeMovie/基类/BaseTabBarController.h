//
//  BaseTabBarController.h
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController


/**
 *  隐藏当前的标签栏
 *
 *  @param isHidden YES 隐藏/ NO 显示
 */
- (void)setTabBarHidden:(BOOL) isHidden;


@end
