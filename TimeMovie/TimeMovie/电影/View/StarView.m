//
//  StarView.m
//  TimeMovie
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "StarView.h"
#import "UIViewExt.h"

@interface StarView ()
{
    UIView *_yellowView;
    UIView *_grayView;
    
}
//-(void)setRating:(CGFloat)rating;


@end

@implementation StarView


// initWithFrame 方法 在从xib文件中读取时 是不会调用的
//- (instancetype)initWithFrame:(CGRect)frame
//{
//    //  强制让视图的宽高成比例，能够完整显示五颗星
//    CGFloat width = frame.size.height / 17 * 17.5 * 5;
//    frame.size.width = width;
//    self = [super initWithFrame:frame];
//    if (self)
//    {
//        [self _createStarViews];
//    }
//    
//    return self;
//}

// 从xib 或者 故事版中创建视图时 调用的方法
- (void)awakeFromNib
{
    [self _createStarViews];
}

-(void)_createStarViews
{
    //获取两个图片
    UIImage *yellowImage = [UIImage imageNamed:@"yellow"];
    UIImage *grayImage = [UIImage imageNamed:@"gray"];
    
    //放大灰色的星星视图
    CGAffineTransform transform = CGAffineTransformMakeScale(self.bounds.size.width/17.5/5, self.bounds.size.height/17);
    
    //灰色视图的创建
    _grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    _grayView.backgroundColor = [UIColor colorWithPatternImage:grayImage];
    
    //放大图片
    _grayView.transform =transform;
    [self addSubview:_grayView];
    
    //黄色视图的创建
    _yellowView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 17.5 * 5, 17)];
    _yellowView.backgroundColor = [UIColor colorWithPatternImage:yellowImage];
    
    //放大图片
    _yellowView.transform =transform;
    [self addSubview:_yellowView];

    
    // 让位置和大小变换过后的视图，重新移动到原来的位置上面去
    _grayView.frame = self.bounds;
    _yellowView.frame = self.bounds;
    self.backgroundColor = [UIColor clearColor];
    
    
}

-(void)setRating:(CGFloat)rating
{
    if (rating >= 0 && rating <= 10) {
        _rating = rating;
        _yellowView.width = _grayView.width *rating /10;
        
    }
    
}


@end
