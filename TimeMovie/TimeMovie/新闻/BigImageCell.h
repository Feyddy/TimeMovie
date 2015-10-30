//
//  BigImageCell.h
//  TimeMovie
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BigImageCell : UICollectionViewCell<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIImageView *_imageView;
    NSTimer *_timer;
}

@property(nonatomic,strong)NSURL *imageURL;//单元格中的imageView

-(void)backImageZoomingScale;//设置单元格恢复的方法

@end
