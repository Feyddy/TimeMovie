//
//  TopCell.m
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

-(void)setMovie:(Movie *)movie
{
    _movie = movie;
    [_movieImageView sd_setImageWithURL:[NSURL URLWithString:_movie.imageName[MovieImageKeyMedium]]];
    
    _titleLabel.text = _movie.movieC;
    _titleLabel.textColor = [UIColor whiteColor];
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_movie.rating];
    _ratingLabel.textColor = [UIColor whiteColor];
    _starView.rating = _movie.rating;
    
}

@end
