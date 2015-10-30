//
//  AppDelegate.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchViewController.h"
#import "GuideViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    
//    //获取当前的应用软件
//    UIApplication *app = [UIApplication sharedApplication];
//    
//    //设置状态栏的颜色
//    [app setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
//
//    //设置状态栏的隐藏和显示
//    [app setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    
    //设置至窗口的属性以及主窗口的根视图
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window .backgroundColor = [UIColor blackColor];
    [self.window makeKeyAndVisible];
    self.window.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"girl"]];
    
    
    //问题所在：
    //  这边创建[[LaunchViewController alloc]init]的时候，已经启动了一个定时器，所以和下面的if里面的 self.window.rootViewController = [[LaunchViewController alloc] init]; 重复启动了两个定时器，所以出现了一些问题
    
    
    
//    self.window.rootViewController = [[LaunchViewController alloc]init];
    
    
    //判断是否第一次运行
    //储存一些用户的配置
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    //设置BOOL型数据进行判断是否为第一次启动
    // 通过一个key 来获取一个值 如果没有找到此值 则返回NO
    BOOL first = [userDefaults boolForKey:@"guide"];
    if (!first)
    {
        // 第一次运行程序
        self.window.rootViewController = [[GuideViewController alloc] init];
    }
    else
    {
        self.window.rootViewController = [[LaunchViewController alloc] init];
    }

    

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
