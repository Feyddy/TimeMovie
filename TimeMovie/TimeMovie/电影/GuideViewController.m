//
//  GuideViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/31.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "GuideViewController.h"
#import "MoreViewController.h"

@interface GuideViewController ()<UIScrollViewDelegate>
{
    UIScrollView *_scroll;
    UIImageView *_pageChangeView;
    UIButton *_btn;
}

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    //隐藏状态栏
//    UIApplication *app = [UIApplication sharedApplication];
//    [app setStatusBarHidden:YES];
    
    
    //创建视图
    [self createView];
    
    

}

-(void)createView
{
    _scroll = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    _scroll.pagingEnabled = YES;
    _scroll.contentSize = CGSizeMake(5 * kScreenWidth, kScreenHeight);
    
    _scroll.showsHorizontalScrollIndicator = NO;
    
    _scroll.bounces = NO;
    _scroll.backgroundColor = [UIColor colorWithRed:0.1 green:0.1 blue:0.1 alpha:1];
    
    _scroll.delegate = self;
    [self.view addSubview:_scroll];
    
    for (int i = 0; i<5; i++)
    {
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, kScreenHeight)];
        //拼接图片名
        NSString *imageName = [NSString stringWithFormat:@"%@%i",@"guide",i+1];
        
        //添加图片
        imageView.image = [UIImage imageNamed:imageName];
        [_scroll addSubview:imageView];
        
    }
    
    //创建页码的滑动显示
    _pageChangeView = [[UIImageView alloc]initWithFrame:CGRectMake((kScreenWidth - 173) / 2, (kScreenHeight - 60), 173,26)];
    _pageChangeView.image = [UIImage imageNamed:@"guideProgress1"];
    
    //把页码滑动显示加载到self.view，不要加载在_scroll
    [self.view addSubview:_pageChangeView];
    
    
    //创建按钮
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake((kScreenWidth - 173) / 2, (kScreenHeight - 120), 173,26)];
    
    
    
    [_btn addTarget:self action:@selector(goToCinema) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_btn];
}

-(void)goToCinema
{
    //设置应用程序为第一次启动
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:@YES forKey:@"guide"];
    
    //显示界面
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:YES];
    
    
    //读取第一个STORYBORD界面
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UIViewController *VC = [storyBoard instantiateInitialViewController];
    
    //将这个视图控制器显示在Window上
    self.view.window.rootViewController = VC;
    
    //显示界面动画
    VC.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.5 animations:^{
        VC.view.transform = CGAffineTransformIdentity;
    }];
    
    
    

}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //根据偏移量来计算页数
    CGFloat x = scrollView.contentOffset.x;
    
    NSInteger index = (x+kScreenWidth/2)/kScreenWidth;
    
    
    NSArray *pageImage = @[@"guideProgress1",
                           @"guideProgress2",
                           @"guideProgress3",
                           @"guideProgress4",
                           @"guideProgress5"];
    
    UIImage *image = [UIImage imageNamed:pageImage[index]];
    _pageChangeView.image = image;
    
    if (index == 4) {
        _btn.hidden = NO;
        [_btn setTitle:@"READY GO!!!!!!!" forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
        [_btn setTitleColor:[UIColor purpleColor] forState:UIControlStateHighlighted];
        
        _btn.layer.cornerRadius = 3;
        
        _btn.backgroundColor = [UIColor purpleColor];
        
    }
    else
    {
        _btn.hidden = YES;
    }
}


- (BOOL)prefersStatusBarHidden
{
    return YES;
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
