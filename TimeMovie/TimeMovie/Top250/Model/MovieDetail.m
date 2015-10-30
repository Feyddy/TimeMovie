//
//  MovieDetail.m
//  项目一 dzk
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 想知道我是谁吗？. All rights reserved.
//

//@property (nonatomic, copy) NSString *image;
//@property (nonatomic, strong) NSArray *actors;
//@property (nonatomic, strong) NSArray *directors;
//@property (nonatomic, strong) NSArray *images;
//@property (nonatomic, copy) NSString *date;
//@property (nonatomic, copy) NSString *location;
//@property (nonatomic, copy) NSString *titleCn;
//@property (nonatomic, strong) NSArray *type;

#import "MovieDetail.h"

@implementation MovieDetail

- (id)initWithDictionary:(NSDictionary *)dic{
    self = [super init];
    if (self) {
        _image = dic[@"image"];
        _actors = dic[@"actors"];
        _directors = dic[@"directors"];
        _images = dic[@"images"];
        _titleCn = dic[@"titleCn"];
        _type = dic[@"type"];
        
        NSDictionary *re = dic[@"release"];
        _date = re[@"date"];
        _location = re[@"location"];
    }
    
    return self;
}

@end
