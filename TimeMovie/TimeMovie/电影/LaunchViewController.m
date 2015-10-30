//
//  LaunchViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/31.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "LaunchViewController.h"

@interface LaunchViewController ()
{
    NSTimer *_timer;
    //int i;
}

@end

@implementation LaunchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"LOVE"]];
    
    [NSTimer scheduledTimerWithTimeInterval:0.3
                                     target:self
                                   selector:@selector(showImageView:)
                                   userInfo:nil
                                    repeats:YES];
    
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    //隐藏状态栏
//    UIApplication *app = [UIApplication sharedApplication];
//    [app setStatusBarHidden:YES];
//    
//}
//
//-(void)viewDidDisappear:(BOOL)animated
//{
//    //显示状态栏
//    UIApplication *app = [UIApplication sharedApplication];
//    [app setStatusBarHidden:NO];
//}

-(void)showImageView:(NSTimer *)timer
{

    static int i = 0;
    UIImageView *imageView = (UIImageView *)[self.view viewWithTag:i];
    //NSLog(@"tag = %li", imageView.tag);
    //显示这个ImageView
    imageView.hidden = NO;
//    NSLog(@"%d",i);
    i++;
   
    if (i == 25)
    {
        [timer invalidate];
        [self performSelector:@selector(jumpToMainViewController) withObject:nil afterDelay:2];
    }
}

#pragma mark - 跳转到主页面

-(void)jumpToMainViewController
{
    //读取故事版 获取ViewController
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    
    UIViewController *VC = [story instantiateInitialViewController];
    
    self.view.window.rootViewController = VC;
    
    //显示界面动画
    VC.view.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    [UIView animateWithDuration:0.5 animations:^{
        VC.view.transform = CGAffineTransformIdentity;
    }];
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
