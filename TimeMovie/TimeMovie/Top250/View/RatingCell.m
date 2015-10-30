//
//  RatingCell.m
//  TimeMovie
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "RatingCell.h"

/*
 @property (strong, nonatomic) IBOutlet UIView *bgView;
 @property (strong, nonatomic) IBOutlet UIImageView *userImage;
 @property (strong, nonatomic) IBOutlet UILabel *userName;
 @property (strong, nonatomic) IBOutlet UILabel *ratingLabel;
 @property (strong, nonatomic) IBOutlet UILabel *commentLabel;
 */

@implementation RatingCell

- (void)awakeFromNib {
    // Initialization code
    _bgView.layer.cornerRadius = 3;
    _bgView.layer.borderColor = [[UIColor purpleColor]CGColor];
    _bgView.layer.borderWidth = 2;
    _bgView.layer.masksToBounds = YES;
}

- (void)setComment:(Top250 *)comment
{
    _comment = comment;
    _commentLabel.text = _comment.content;
    _userName.text = _comment.nickname;
    _ratingLabel.text = [NSString stringWithFormat:@"%.1f",_comment.rating];
    
    NSURL *url = [NSURL URLWithString:_comment.userImage];
    [_userImage sd_setImageWithURL:url];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
