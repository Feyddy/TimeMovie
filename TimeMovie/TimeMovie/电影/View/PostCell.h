//
//  PostCell.h
//  TimeMovie
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"
@class StarView;

@interface PostCell : UICollectionViewCell


@property (strong, nonatomic) IBOutlet UIImageView *bigImageView;
@property (strong, nonatomic) IBOutlet UIImageView *smallImageView;
@property (strong, nonatomic) IBOutlet UILabel *titleCLabel;
@property (strong, nonatomic) IBOutlet UILabel *titleELabel;
@property (strong, nonatomic) IBOutlet UILabel *yearLabel;
@property (strong, nonatomic) IBOutlet StarView *starView;




@property(nonatomic,strong) Movie *movie;


/**
 *  翻转单元格
 */
-(void)filpCell;

-(void)cancelFilp;
@end
