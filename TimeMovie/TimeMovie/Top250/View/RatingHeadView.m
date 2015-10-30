//
//  RatingHeadView.m
//  TimeMovie
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "RatingHeadView.h"
#import "UIButton+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIImageView+WebCache.h"


/*
 @property (nonatomic, copy) NSString *image;
 @property (nonatomic, strong) NSArray *actors;
 @property (nonatomic, strong) NSArray *directors;
 @property (nonatomic, strong) NSArray *images;
 @property (nonatomic, copy) NSString *date;
 @property (nonatomic, copy) NSString *location;
 @property (nonatomic, copy) NSString *titleCn;
 @property (nonatomic, strong) NSArray *type;
 */
/*
 @property (strong, nonatomic) IBOutlet UILabel *titleCLabel;
 @property (strong, nonatomic) IBOutlet UIImageView *movieImageView;
 @property (strong, nonatomic) IBOutlet UILabel *directorsLabel;
 @property (strong, nonatomic) IBOutlet UILabel *actorsLabel;
 @property (strong, nonatomic) IBOutlet UILabel *typeLabel;
 @property (strong, nonatomic) IBOutlet UILabel *dateLabel;
 @property (strong, nonatomic) IBOutlet UIImageView *imagesView;
 */

@implementation RatingHeadView

-(void)setDetail:(MovieDetail *)detail
{
    _detail = detail;
    _titleCLabel.text = _detail.titleCn;
    
    //上映时间
    _dateLabel.font = [UIFont systemFontOfSize:14];
    _dateLabel.text =[NSString stringWithFormat:@"上映时间:%@",_detail.date] ;
    
    // 电影图片
    NSURL *url1 = [NSURL URLWithString:_detail.image];
    [_movieImageView sd_setImageWithURL:url1];

    //导演
    _directorsLabel.font = [UIFont systemFontOfSize:14];
    
    for (int i = 0; i<_detail.directors.count; i++) {
        _directorsLabel.text =[NSString stringWithFormat:@"导演:%@",_detail.directors[i]];
    }
    
    
 
    
    //演员
    NSMutableString *actors = [[NSMutableString alloc]initWithString:@"演员:"];
    for (int i = 0; i<detail.actors.count; i++) {
        [actors appendString:[NSString stringWithFormat:@"%@ ",_detail.actors[i]]];
    }
    _actorsLabel.text = actors;
    _actorsLabel.font = [UIFont systemFontOfSize:14];
    
    
    //类型
    NSMutableString *type = [[NSMutableString alloc]initWithString:@"类型:"];
    for (int i = 0; i<detail.type.count; i++) {
        [type appendString:[NSString stringWithFormat:@"%@ ",_detail.type[i]]];
    }
    _typeLabel.text = type;
    _typeLabel.font = [UIFont systemFontOfSize:14];
    
    
    
    
    
    // 创建一个布局对象
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置布局规则
    // 水平最小间隙
    flowLayout.minimumInteritemSpacing = 5;
    // 竖直最小间隙
    //flowLayout.minimumLineSpacing = 2;
    
    // 单元格大小
    flowLayout.itemSize = CGSizeMake(_imagesView.size.width/4, _imagesView.size.height);
    // 滑动方向
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    
    // 使用布局对象 来创建UICollectionView
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, _imagesView.size.width, _imagesView.size.height) collectionViewLayout:flowLayout];
   
    collection.backgroundColor = [UIColor grayColor];
    _imagesView.userInteractionEnabled = YES;
   
    [_imagesView addSubview:collection];
    
    // 数据源对象设置
    collection.dataSource = self;
    collection.delegate = self;
    
    // 注册单元格
    // 使用一个类 来注册单元格
    [collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    // 多部电影图片

    _imageList = [[NSMutableArray alloc]init];
    for (int i = 0; i<_detail.images.count; i++) {
        [_imageList addObject:[NSURL URLWithString:_detail.images[i]]];
    }
 
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
    [imageV sd_setImageWithURL:_imageList[indexPath.item]];
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

- (IBAction)movieImageView:(id)sender {
    
//    "http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"
    
    MPMoviePlayerViewController *moviePlayer = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"http://vf1.mtime.cn/Video/2012/04/23/mp4/120423212602431929.mp4"]];

    //moviePlayer.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:moviePlayer animated:YES];
}
@end
