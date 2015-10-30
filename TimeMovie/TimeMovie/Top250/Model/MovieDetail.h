//
//  MovieDetail.h
//  项目一 dzk
//
//  Created by mac on 15/8/7.
//  Copyright (c) 2015年 想知道我是谁吗？. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MovieDetail : NSObject

@property (nonatomic, copy) NSString *image;
@property (nonatomic, strong) NSArray *actors;
@property (nonatomic, strong) NSArray *directors;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *titleCn;
@property (nonatomic, strong) NSArray *type;

//@property (nonatomic,strong) NSArray *data;

- (id)initWithDictionary:(NSDictionary *)dic;
@end
