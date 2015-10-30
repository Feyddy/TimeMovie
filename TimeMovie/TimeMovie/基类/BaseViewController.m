//
//  BaseViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseTabBarController.h"

@interface BaseViewController (){
    UILabel *_titleLabel;
    BOOL _isHiddenTabBar;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //    自定义label设置属性
   _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 160, 40)];
    _titleLabel.textColor = [UIColor whiteColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont boldSystemFontOfSize:25];//粗体
    
    //    将自定义的label显示到导航栏上面去
    self.navigationItem.titleView = _titleLabel;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    
}

//set方法的重写
-(void)setTitle:(NSString *)title{
    //调用父类uiviewcontroller没有腹泻之前的方法
    [super setTitle:title];
    
    _titleLabel.text = title;
}


#pragma mark - hidden
//当视图将要出现的时候
- (void)viewWillAppear:(BOOL)animated
{
    if (_isHiddenTabBar) {
        //隐藏标签栏
        BaseTabBarController *tab =(BaseTabBarController *) self.tabBarController;
        [tab setTabBarHidden:YES];
    }
    else
    {
        //显示标签栏
        BaseTabBarController *tab =(BaseTabBarController *) self.tabBarController;
        [tab setTabBarHidden:NO];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    //显示标签栏
    //隐藏标签栏
    BaseTabBarController *tab =(BaseTabBarController *) self.tabBarController;
    [tab setTabBarHidden:NO];
}

//复写系统内部的隐藏方法
- (void)setHidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    _isHiddenTabBar = hidesBottomBarWhenPushed;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
