//
//  CinemaCell.h
//  TimeMovie
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Cinema.h"
@interface CinemaCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *name;
@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *lowPrice;
@property (strong, nonatomic) IBOutlet UILabel *distance;
@property (strong, nonatomic) IBOutlet UILabel *grade;
@property (strong, nonatomic) IBOutlet UIImageView *isSeatSupportImageView;
@property (strong, nonatomic) IBOutlet UIImageView *isCouponSupportImageView;
@property (strong, nonatomic) IBOutlet UIImageView *isImaxSupportImageView;
@property (strong, nonatomic) IBOutlet UIImageView *isGroupBuySupportImageView;


@property(nonatomic,strong)Cinema *cinema;
@end
