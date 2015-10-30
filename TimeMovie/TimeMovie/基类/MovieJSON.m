//
//  MovieJSON.m
//  TimeMovie
//
//  Created by Mac on 15/8/22.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieJSON.h"

@implementation MovieJSON

+(id)readJSONFile:(NSString *)fileName
{
    //1.获取文件的路径
    NSString *path = [[NSBundle mainBundle]pathForResource:fileName ofType:@"json"];
    
    //2.读取文件
    //在NSData 类里面数据是以二进制或者十六进制的形式存储的，包括字典，字符串，数组，UIImage
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    //编码格式  encoding:NSUTF8StringEncoding  data---->转换为string
    //NSString *dataString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    //3.文件解析  NSJSON  苹果公司的开发的解析器
    id json = [NSJSONSerialization JSONObjectWithData:data
                                                        options:NSJSONReadingMutableLeaves
                                                          error:nil];
    
    return json;
}


@end
