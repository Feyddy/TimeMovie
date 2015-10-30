//
//  Movie.h
//  TimeMovie
//
//  Created by Mac on 15/8/21.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//
#define MovieImageKeySmall @"small"
#define MovieImageKeyLarge @"large"
#define MovieImageKeyMedium @"medium"


#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

@interface Movie : NSObject
@property(nonatomic,copy) NSString *movieC; //电影名
@property(nonatomic,copy) NSString *movieE;//英文
@property(nonatomic,assign) CGFloat rating;//评分
@property(nonatomic,copy) NSString *year;//上映时间
@property(nonatomic,copy) NSDictionary *imageName;//图片

-(id)initWithContentsOfNSdictionary:(NSDictionary *)dictionary;

+(id)initWithContentsOfNsdictionary:(NSDictionary *)dictionary;

@end
