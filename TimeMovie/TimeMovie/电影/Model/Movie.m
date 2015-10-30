//
//  Movie.m
//  TimeMovie
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//
#import "Movie.h"

@implementation Movie


-(id)initWithContentsOfNSdictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        
        //中文命
        _movieC = dictionary[@"title"];
        
        //英文名
        _movieE = dictionary[@"original_title"];
        
        //上映时间
        _year = dictionary[@"year"];
        
        //图片
        _imageName = dictionary[@"images"];
        
        //评分
        NSDictionary *dic1 = dictionary[@"rating"];
        NSNumber *number = dic1[@"average"];
        _rating = [number floatValue];
    }
    return self;
    
}

+(id)initWithContentsOfNsdictionary:(NSDictionary *)dictionary
{
    return [[Movie alloc]initWithContentsOfNSdictionary:dictionary];
}

@end
