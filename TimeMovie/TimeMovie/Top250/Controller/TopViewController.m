//
//  TopViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "TopViewController.h"
#import "Movie.h"
#import "TopCell.h"
#import "RatingViewController.h"

@interface TopViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_topData;
    
}

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Top250";
    [self loadData];
    
}

-(void)loadData
{
    _topData = [[NSMutableArray alloc]init];
    
   NSDictionary *dic = [MovieJSON readJSONFile:@"top250"];
    
    for (NSDictionary *d in dic[@"subjects"]) {
        Movie *movie = [[Movie alloc]initWithContentsOfNSdictionary:d];
        [_topData addObject:movie];
    }
}


#pragma mark -UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _topData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
    
    cell.movie = _topData[indexPath.item];

    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //计算单元格的宽度
    CGFloat cellWidth = (kScreenWidth - 10 * 4)/3 ;
    
    //计算单元格的高度
    CGFloat cellHeight = cellWidth * 1.3;
    return CGSizeMake(cellWidth, cellHeight);
}


#pragma mark - cell选中事件

//单元格选中事件

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //从故事版中获取试图控制器
    
    //1.从故事板中获取对象
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    //2.从故事板中读取视图控制器
    RatingViewController *rate = [storyBoard instantiateViewControllerWithIdentifier:@"rating"];
    
    [self.navigationController pushViewController:rate animated:YES];
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
