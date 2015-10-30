//
//  DetailCollectionView.m
//  TimeMovie
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "DetailCollectionView.h"
#import "PostCell.h"
#import "Movie.h"

@interface DetailCollectionView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGSize _itemSize;
}

@end

@implementation DetailCollectionView


- (instancetype)initWithFrame:(CGRect)frame
{
    
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.itemSize = CGSizeMake(frame.size.height * 0.6, frame.size.height * 0.9);
    _itemSize = flowLayout.itemSize;
    
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 10;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat leftWidth = (frame.size.width - _itemSize.width)/2;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(10, leftWidth, 10, leftWidth);
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        
        
        //注册单元格
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        self.index = 0;
    }
    return self;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _movieData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    if (cell.backgroundView == nil) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:cell.bounds];
        cell.backgroundView = image;
    }
    
    
    Movie *movie = _movieData[indexPath.item];
    UIImageView *image = (UIImageView *)cell.backgroundView;
    [image sd_setImageWithURL:[NSURL URLWithString:movie.imageName[MovieImageKeySmall]]];
    
//    cell.backgroundColor = [UIColor purpleColor];
//    cell.movie = _movieData[indexPath.item];
    return cell;
}

#pragma nark - uiscro
/**
 *  滑动视图 即将结束拖拽 调用的代理方法
 *
 *  @param scrollView          滑动视图
 *  @param velocity            手指离开屏幕时，视图滑动的速度
 *  @param targetContentOffset 偏移量
 */
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    /**
     *  实现自定义分页效果
     *  1. 获取视图停止之后的偏移量 x
     *  2. 根据偏移量 计算停止之后 所在的页码
     *  3. 计算此页 显示在正中间时 滑动视图的偏移量
     *  4. 将计算所得的偏移量 设置给滑动视图
     */
    //1.
    //因为
    CGFloat xOffSet = targetContentOffset->x;
    xOffSet += _itemSize.width / 2;
    //2.
    NSInteger index = xOffSet / (_itemSize.width+ 10);
    
    self.index = index;
    //3
    xOffSet = index * (_itemSize.width+ 10);
    //4.
    targetContentOffset->x = xOffSet;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
 
}




@end
