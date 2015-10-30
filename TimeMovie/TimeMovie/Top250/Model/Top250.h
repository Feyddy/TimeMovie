//
//  Top250.h
//  TimeMovie
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 {
 "userImage" : "http://img2.mtime.com/images/default/head.gif",
 "nickname" : "yangna988",
 "rating" : "9.0",
 "content" : "儿子很喜欢 一直期盼上映"
 },

 */
@interface Top250 : NSObject

@property (nonatomic,copy) NSString *userImage;//用户图片
@property (nonatomic,copy) NSString *nickname;//用户名
@property (nonatomic, assign) CGFloat rating;//评分
@property (nonatomic,copy) NSString *content;//评论

@property (nonatomic,assign) BOOL isShow;



- (instancetype)initWithDictionary:(NSDictionary *)dic;
@end
