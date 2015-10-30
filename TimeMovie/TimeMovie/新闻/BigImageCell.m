//
//  BigImageCell.m
//  TimeMovie
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BigImageCell.h"
#import "NewsViewController.h"
#import "SecondNewsViewController.h"

@implementation BigImageCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createViews];
    }
    return self;
}

-(void)createViews
{
    //创建视图
    _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
    _scrollView.contentSize = self.frame.size;
    
    //创建最大放大倍数
    _scrollView.maximumZoomScale = 3;
    _scrollView.minimumZoomScale = 0.3;
    
    _scrollView.delegate = self;
    
    [self.contentView addSubview:_scrollView];
    
    //创建图片视图
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];

    //图片拉伸
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [_scrollView addSubview:_imageView];
    
    
    //设置单击手势
    UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(oneTapAction)];
    
    //设置点击需要的次数
    oneTap.numberOfTapsRequired = 1;
    
    //设置点击需要的手指数
    oneTap.numberOfTouchesRequired = 1;
    
    [_imageView addGestureRecognizer:oneTap];
    
    _imageView.userInteractionEnabled = YES;
    
    //设置双击手势
    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoTapAction)];
    
    //设置点击需要的次数
    twoTap.numberOfTapsRequired = 2;
    
    //设置点击需要的手指数
    twoTap.numberOfTouchesRequired = 1;
    
    [_imageView addGestureRecognizer:twoTap];
    
    _imageView.userInteractionEnabled = YES;
    
}

//点击一次触发的事件
-(void)oneTapAction
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(oneTap) userInfo:nil repeats:NO];
}

//延迟调用，隐藏状态栏
-(void)oneTap
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"hidden" object:self userInfo:nil];

}

//点击两次触发事件
-(void)twoTapAction
{
    [_timer invalidate];
    
    if (_scrollView.zoomScale >=2) {
        [_scrollView setZoomScale:1 animated:YES];
    }
    else
    {
        [_scrollView setZoomScale:3 animated:YES];
    }
}

//视图的捏合
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return _imageView;
}

//创建图片路径读取与设置图片的方法
-(void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    [_imageView sd_setImageWithURL:_imageURL];
}

//创建图片还原的方法
-(void)backImageZoomingScale
{
    [_scrollView setZoomScale:1];
//    _scrollView setZoomScale:<#(CGFloat)#> animated:<#(BOOL)#>
}

@end
