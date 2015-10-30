//
//  BaseTabBarController.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BaseTabBarController.h"
#import "TabBarButton.h"


@interface BaseTabBarController (){
    UIView *_newTabBar;
    UIImageView *_selectedImageView;
}

@end

@implementation BaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏系统的tabBar
    self.tabBar.hidden = YES;
    
    //自定义创建tabBar
    [self _createTabBar];
    
}

-(void)_createTabBar
{
//    创建标签栏视图
    _newTabBar = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight-49, kScreenWidth, 49)];
    [_newTabBar setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"tab_bg_all"]]];
    
    [self.view addSubview:_newTabBar];
    
    //    计算按钮的宽度
    CGFloat buttonWidth = kScreenWidth / self.viewControllers.count;
    
    //创建选中图片视图
    _selectedImageView = [[ UIImageView alloc] initWithFrame:CGRectMake(0 , 0, buttonWidth, 49)];
    
    //设置选中图片
    _selectedImageView.image = [UIImage imageNamed:@"selectTabbar_bg_all1"];
    
    //设置图片视图的透明度
    //[_selectedImageView setAlpha:0.4];
    
    [_newTabBar addSubview:_selectedImageView];
    
    NSArray *titleName = @[@"电影",
                           @"新闻",
                           @"Top",
                           @"影院",
                           @"更多"];
    
    NSArray *imageName = @[@"movie_home",
                           @"msg_new",
                           @"start_top250",
                           @"icon_cinema",
                           @"more_setting"];
    
    //循环创建标签栏上的按钮
    for (int i = 0; i<5; i++) {
        
        TabBarButton *button = [[TabBarButton alloc]initWithTitle:titleName[i] image:imageName[i] frame:CGRectMake(i*buttonWidth, 0, buttonWidth, 49)];
        button.tag = 100+i;
        [button addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [_newTabBar addSubview:button];
    }
    
}

-(void)clickAction:(UIButton *)btn
{
    //获取按钮的tag
    NSInteger index = btn.tag - 100;
    
    //使得显示的视图与按钮对应
    self.selectedIndex = index;
    
//    设置选择视图的位置，设置一个动画
    
    [UIView animateWithDuration:.3 animations:^{
        _selectedImageView.center = btn.center;
    }];

}

- (void)setTabBarHidden:(BOOL)isHidden
{
    _newTabBar.hidden = isHidden;
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
