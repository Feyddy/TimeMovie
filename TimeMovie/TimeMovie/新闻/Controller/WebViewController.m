//
//  WebViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/31.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"网络新闻";
    
    //创建网络视图
    UIWebView *web = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:web];
    
    //读取文件
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"news" ofType:@"html"];
    
    //读取文件数据
    NSString *htmlString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    //读取新闻数据JSON文件
    NSDictionary *dic = [MovieJSON readJSONFile:@"news_detail"];
    
    NSString *title = dic[@"title"];
    NSString *content = dic[@"content"];
    NSString *time = dic[@"time"];
    NSString *source = dic[@"source"];
    
    
     //2 .拼接HTML字符串
    htmlString = [NSString stringWithFormat:htmlString,title,content,time,source];

    
    //3 .加载页面
    [web loadHTMLString:htmlString baseURL:nil];
    
    //页面自适应
    web.scalesPageToFit = YES;
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
