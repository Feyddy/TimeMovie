//
//  TopCell.h
//  TimeMovie
//
//  Created by 朱家聪 on 15/8/24.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarView.h"
#import "Movie.h"
@interface TopCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *ratingLabel;
@property (weak, nonatomic) IBOutlet StarView *starView;
@property (weak, nonatomic) IBOutlet UIImageView *movieImageView;

@property(nonatomic,strong) Movie *movie;

@end
