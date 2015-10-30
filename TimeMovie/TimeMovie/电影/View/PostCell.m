//
//  PostCell.m
//  TimeMovie
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "PostCell.h"
#import "StarView.h"

@interface PostCell()
    



@end


@implementation PostCell

-(void)setMovie:(Movie *)movie
{
    _movie = movie;
    NSURL *url = [NSURL URLWithString:_movie.imageName[MovieImageKeyLarge]];
    [_bigImageView sd_setImageWithURL:url];
    [_smallImageView sd_setImageWithURL:url];
    _titleCLabel.text = _movie.movieC;
    _titleELabel.text = _movie.movieE;
    _yearLabel.text = _movie.year;
    _starView.rating = _movie.rating;
    
}

//翻转单元格
-(void)filpCell
{
    
    [UIView transitionWithView:self
                      duration:0.3
                        options:UIViewAnimationOptionTransitionFlipFromLeft
                     animations:^{
                         _bigImageView.hidden = !_bigImageView.hidden;
    
                    } completion:nil];
}

-(void)cancelFilp
{
    _bigImageView.hidden = NO;
}

- (void)awakeFromNib {
    // Initialization code
}

@end
