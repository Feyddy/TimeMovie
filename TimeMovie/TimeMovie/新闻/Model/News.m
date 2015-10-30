//
//  News.m
//  TimeMovie
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "News.h"

@implementation News
/*
 属性名与json字典中key的映射关系
 key:  json字典的key名
 value: model对象的属性名
 
 
 @property(nonatomic,strong) NSNumber *newsID;
 @property(nonatomic,copy) NSString *title;
 @property(nonatomic,strong) NSNumber *type;
 @property(nonatomic,copy) NSString *image;
 @property(nonatomic,copy) NSString *summary;
 */
- (NSDictionary *)attributeMapDictionary:(NSDictionary *)jsonDic {
    
    NSMutableDictionary *mapDic = [NSMutableDictionary dictionary];
    
    for (id key in jsonDic) {
        [mapDic setObject:key forKey:key];
    }
    [mapDic setObject:@"newsID" forKey:@"id" ];
    
    _newsID = mapDic[@"id"];
    _title = mapDic[@"title"];
    _type = mapDic[@"type"];
    _summary = mapDic[@"sumary"];
    _image = mapDic[@"image"];
    
    return mapDic;
}



@end
