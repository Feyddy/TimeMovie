//
//  MovieCell.m
//  TimeMovie
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieCell.h"
#import "Movie.h"
#import "StarView.h"

@implementation MovieCell

- (void)awakeFromNib {
    
//    _yellowView = [[UIImageView alloc]initWithFrame:_starView.bounds];
//    _grayView = [[UIImageView alloc]initWithFrame:_starView.bounds];
//    
//    CGFloat imageViewWidth = _starView.bounds.size.width;
//    CGFloat imageViewHeight = _starView.bounds.size.height-10;
//    
//    for (int i =0 ; i<5; i++)
//    {
//        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(i*imageViewWidth/5, 5, imageViewWidth/5, imageViewHeight)];
//        [view setImage:[UIImage imageNamed:@"yellow@2x"]];
//        [_yellowView addSubview:view];
//    }
//    
//    for (int i =0 ; i<5; i++)
//    {
//        UIImageView *view = [[UIImageView alloc]initWithFrame:CGRectMake(i*imageViewWidth/5, 5, imageViewWidth/5, imageViewHeight)];
//        [view setImage:[UIImage imageNamed:@"gray@2x"]];
//        [_grayView addSubview:view];
//    }
//    
//    [_starView addSubview:_grayView];
//    [_starView addSubview:_yellowView];
//    
}



//复写setMovie方法
-(void)setMovie:(Movie *)movie{
    _movie = movie;
    _movieNameLabel.text = _movie.movieC;
    _yearLabel.text = [NSString stringWithFormat:@"上映年份:%@",_movie.year];
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movie.rating];
    
    //从网络中读取图片
    NSString *urlString = _movie.imageName[MovieImageKeySmall];
    NSURL *url = [NSURL URLWithString:urlString];
    [_movieImageView sd_setImageWithURL:url];
    
    
    [_startView setRating:_movie.rating];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
