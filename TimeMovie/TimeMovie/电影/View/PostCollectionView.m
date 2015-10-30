//
//  PostCollectionView.m
//  TimeMovie
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PostCollectionView.h"
#import "PostCell.h"

@interface PostCollectionView()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@end

@implementation PostCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    //创建布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    flowLayout.itemSize = CGSizeMake(frame.size.width * 0.6, frame.size.height * 0.6);
    
    flowLayout.minimumInteritemSpacing = 10;
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    flowLayout.sectionInset = UIEdgeInsetsMake(0, frame.size.width *0.2, 0, frame.size.width *0.2);
    
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        
        
        //注册单元格
        UINib *nib = [UINib nibWithNibName:@"PostCell" bundle:[NSBundle mainBundle]];
        
        [self registerNib:nib forCellWithReuseIdentifier:@"postCell"];
        
        self.index = 0;
    }
    return self;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _movieData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PostCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"postCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor purpleColor];
    cell.movie = _movieData[indexPath.item];
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
    xOffSet += scrollView.width * 0.3;
    //2.
    NSInteger index = xOffSet / (scrollView.width * 0.6 + 10);
    
    self.index = index;
    //3
    xOffSet = index * (scrollView.width * 0.6 + 10);
    //4.
    targetContentOffset->x = xOffSet;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //根据偏移量计算正中间单元格的索引
    
    NSInteger index = collectionView.contentOffset.x / (collectionView.width * 0.6 + 10);
    
 
    
    //判断选中的单元格是否为正中间的单元格
    //1.YES 翻转这个单元格
    //2.NO 将这个单元格移动到正中间
    if (indexPath.item ==index) {
        //获取单元格
        PostCell *cell = (PostCell *)[collectionView cellForItemAtIndexPath:indexPath];
        //翻转单元格
        [cell filpCell];
    }
    else
    {
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        //改变index值
        self.index = indexPath.item;

        //获取单元格
            PostCell *cell =(PostCell *) [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        
        
        if (cell.bigImageView.hidden ==YES) {
            [cell filpCell];
        }

    }
}

-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostCell *postCell = (PostCell *)cell;
    [postCell cancelFilp];
    
}

@end
