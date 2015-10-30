//
//  MovieCell.h
//  TimeMovie
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@class StarView;
@class Movie;
@interface MovieCell : UITableViewCell


@property(nonatomic,copy) Movie *movie;
@property (strong, nonatomic) IBOutlet UIImageView *movieImageView;
@property (strong, nonatomic) IBOutlet UILabel *movieNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
@property (strong, nonatomic) IBOutlet StarView *startView;



@end
