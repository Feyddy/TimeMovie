//
//  NewsCell.m
//  TimeMovie
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "NewsCell.h"
#import "News.h"
#import "SecondNewsViewController.h"

@implementation NewsCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setNews:(News *)news{
    
    _news = news;
    _titleLabel.text = _news.title;
    _summaryLabel.text = _news.summary;

    if ([_news.type intValue] == 1)
    {
        _typeImage.image = [UIImage imageNamed:@"sctpxw"];

    }
    else if ([_news.type intValue] == 2)
    {
        _typeImage.image = [UIImage imageNamed:@"scspxw"];
        
    }
    else
    {
        _typeImage.image = nil;
        
        //获取属性
        CGAffineTransform transform =  _summaryLabel.transform;
        
        //平移视图:在视图原有的位置的基础上进行平移
        transform = CGAffineTransformTranslate(transform, -25, 0);
        
        _summaryLabel.transform = transform;
    }
    
//    //从网络中读取图片
//    NSString *urlString = _news.image;
//    NSURL *url = [NSURL URLWithString:urlString];
//    [_newsImage sd_setImageWithURL:url];
    
}


//复写布局子视图方法
- (void)layoutSubviews{
    
    //从网络中读取图片
    NSString *urlString = _news.image;
    NSURL *url = [NSURL URLWithString:urlString];
    [_newsImage sd_setImageWithURL:url];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
