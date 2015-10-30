//
//  BigImageViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/25.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "BigImageViewController.h"
#import "BaseTabBarController.h"
#import "BigImageCell.h"
@interface BigImageViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *_imageCollectionView;
    BOOL _hidden;
}

@end


@implementation BigImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"图片新闻";
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createView];
    
    //根据记录的单元格索引 来显示那个单元格
    [_imageCollectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionLeft  animated:YES];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playAction:) name:@"hidden" object:nil];
    
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)playAction:(NSNotification *)notification
{
    //隐藏导航栏
    _hidden = !_hidden;
    [self.navigationController setNavigationBarHidden:_hidden animated:YES];
    
    //隐藏状态栏
    UIApplication *app = [UIApplication sharedApplication];
    [app setStatusBarHidden:_hidden withAnimation:UIStatusBarAnimationSlide];
}

-(void)createView
{
    //创建布局对象--相当于单元格
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight-64);
    layout.minimumInteritemSpacing = 10;
    //设置滚动方向
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //设置四周空隙
    layout.sectionInset = UIEdgeInsetsMake(-15, 0, 0, 0);
    
    //初始化视图对象并且设置单元格显示对象为layout
    _imageCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth+10, kScreenHeight-64) collectionViewLayout:layout];
    _imageCollectionView.dataSource = self;
    _imageCollectionView.delegate = self;
    [self.view addSubview:_imageCollectionView];
    
    //滑动视图的分页效果
    _imageCollectionView.pagingEnabled = YES;
    //隐藏滑块
    _imageCollectionView.showsHorizontalScrollIndicator = NO;
    
    //单元格注册
    [_imageCollectionView registerClass:[BigImageCell class] forCellWithReuseIdentifier:@"BigImageCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _newsData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigImageCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor blackColor];
    
    //设置单元格的图片路径
    cell.imageURL = _newsData[indexPath.item];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//单元格结束显示后执行的方法
- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageCell *big = (BigImageCell *)cell;
    //图片的缩放比例为1
    [big backImageZoomingScale];
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
