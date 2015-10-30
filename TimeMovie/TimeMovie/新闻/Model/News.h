//
//  News.h
//  TimeMovie
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

/*
 {
 "id" : 1491520,
 "title" : "科幻大作《全面回忆》全新预告片发布",
 "type" : 0,
 "image" : "http:\/\/img31.mtime.cn\/mg\/2012\/06\/28\/100820.21812355.jpg",
 "summary" : ""
 },
 
 */
@interface News : BaseModel

@property(nonatomic,strong) NSNumber *newsID;
@property(nonatomic,copy) NSString *title;
@property(nonatomic,strong) NSNumber *type;
@property(nonatomic,copy) NSString *image;
@property(nonatomic,copy) NSString *summary;

@end
