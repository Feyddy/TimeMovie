//
//  CinemaCell.m
//  TimeMovie
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "CinemaCell.h"

@implementation CinemaCell

-(void)setCinema:(Cinema *)cinema
{
    _cinema = cinema;
    
    _name.text = _cinema.name;
    _address.text = _cinema.address;
    _grade.text = _cinema.grade;
    
    
    // 最低价格：nil的判断方法

    if ([_cinema.lowPrice isKindOfClass:[NSNull class]] || _cinema.lowPrice.length == 0) {
        _lowPrice.text = nil;
    }
    else
    {
        _lowPrice.text = [NSString stringWithFormat:@"￥%@",_cinema.lowPrice];
    }
    
    //距离：nil的判断方法
//    if ([_cinema.distance isKindOfClass:[NSNull class]] || _cinema.distance.length == 0) {
//        _distance.text = nil;
//    }else{
        _distance.text = [NSString stringWithFormat:@"%ikm",10];
    _distance.textColor = [UIColor whiteColor];
        
//    }
    
    //座位图片
    if ((int)_cinema.isSeatSupport == 1)
    {
        _isSeatSupportImageView.image = [UIImage imageNamed:@"cinemaSeatMark@2x"];
    }
    else if (_cinema.isSeatSupport == 0)
    {
        _isSeatSupportImageView.image = nil;
    }
    
    
    //券图片
    if ((int)_cinema.isCouponSupport == 1)
    {
        _isCouponSupportImageView.image = [UIImage imageNamed:@"cinemaCouponMark@2x"];
    }
    else if (_cinema.isCouponSupport == 0)
    {
        _isCouponSupportImageView.image = nil;
    }
    
    //团图片
    if ((int)_cinema.isGroupBuySupport == 1) {
        _isGroupBuySupportImageView.image = [UIImage imageNamed:@"cinemaGrouponMark@2x"];
    }
    else if (_cinema.isGroupBuySupport == 0)
    {
        _isGroupBuySupportImageView.image = nil;
    }
    
    //Max图片
    if ((int)_cinema.isImaxSupport == 1) {
        _isImaxSupportImageView.image = [UIImage imageNamed:@"imaxMark@2x"];
    }
    else if (_cinema.isImaxSupport == 0)
    {
        _isImaxSupportImageView.image = nil;
    }

}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
