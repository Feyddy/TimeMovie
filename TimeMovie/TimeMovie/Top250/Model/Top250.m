//
//  Top250.m
//  TimeMovie
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "Top250.h"

@implementation Top250

/*
 @property (nonatomic,copy) NSString *userImage;//用户图片
 @property (nonatomic,copy) NSString *nickname;//用户名
 @property (nonatomic,copy) NSString *rating;//评分
 @property (nonatomic,copy) NSString *content;//评论
 */

- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _nickname = dic[@"nickname"];
        _content = dic[@"content"];
        NSNumber *num = dic[@"rating"];
        _rating = [num floatValue];
        _userImage = dic[@"userImage"];
    }
    
    return self;
}


@end
