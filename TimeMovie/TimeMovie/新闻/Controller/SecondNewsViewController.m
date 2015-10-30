//
//  SecondNewsViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "SecondNewsViewController.h"
#import "BaseTabBarController.h"
#import "BigImageViewController.h"

@interface SecondNewsViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>{
    NSMutableArray *_imageList;
    
}

@end

@implementation SecondNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //---------------------UICollectionView---------------------
    // 1. 创建
    // 创建 UICollectionView 之前 需要先创建一个 布局对象
    // UICollectionViewLayout 是一个非常抽象的布局类  里面没有具体的布局条件
    // 一般情况下 我们使用它的子类 UICollectionViewFlowLayout
    self.title = @"图片";
    
    NSArray *newsImage = [MovieJSON readJSONFile:@"image_list"];
    _imageList = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in newsImage) {
        NSString *string = dic[@"image"];
        [_imageList addObject:[NSURL URLWithString:string]];
    }
    
    //NSLog(@"%ld",_imageList.count);
    
    // 创建一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置布局规则
    // 水平最小间隙
    flowLayout.minimumInteritemSpacing = 5;
    // 竖直最小间隙
    flowLayout.minimumLineSpacing = 5;
    // 单元格大小
    flowLayout.itemSize = CGSizeMake(50, 50);
    // 滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    // 设置四周间隙
    flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    
    flowLayout.itemSize = CGSizeMake((kScreenWidth-10*5)/4, (kScreenWidth-10*5)/4);
    
    
    // 使用布局对象 来创建UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    [self.view addSubview:collection];
    
    // 数据源对象设置
    collection.dataSource = self;
    collection.delegate = self;
    
    // 注册单元格
    // 使用一个类 来注册单元格
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    // 使用xib来注册单元格
    
//     UINib *nib = [UINib nibWithNibName:@"MovieCell" bundle:[NSBundle mainBundle]];
//     [collection registerNib:nib forCellWithReuseIdentifier:@"cell"];
//    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    // 创建一个图片视图
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:cell.bounds];
    // 加载网络图片
    [imageV sd_setImageWithURL:_imageList[indexPath.row]];
    // 设置图片的拉伸模式
    imageV.contentMode = UIViewContentModeScaleAspectFill;

    cell.backgroundView = imageV;
    
    // 设置视图圆角的半径
    cell.layer.cornerRadius = 22.5;
    // 设置边框颜色
    cell.layer.borderColor = [[UIColor purpleColor] CGColor];
    // 设置边框的宽度
    cell.layer.borderWidth = 3;
    cell.clipsToBounds = YES;
    
    return cell;
}

#pragma mark - cell选中事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    BigImageViewController *big = [[BigImageViewController alloc]init];
    
    big.newsData = _imageList;
    
    big.hidesBottomBarWhenPushed = YES;
    
    //记录本次点击选中的单元格的索引
    big.indexPath = indexPath;
    [self.navigationController pushViewController:big animated:YES];
}


//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.item % 2 == 0)
//    {
//        return CGSizeMake(50, 50);
//    }
//    return CGSizeMake(100, 100);
//}


//- (void)viewWillDisappear:(BOOL)animated
//{
//    BaseTabBarController *main = (BaseTabBarController *)self.tabBarController;
//    [main setTabBarHidden:NO animation:YES];
//}
//

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
