//
//  NewsCell.h
//  TimeMovie
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class News;

@interface NewsCell : UITableViewCell

@property (nonatomic,copy)News *news;

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UIImageView *newsImage;

@property (strong, nonatomic) IBOutlet UIImageView *typeImage;

@end
