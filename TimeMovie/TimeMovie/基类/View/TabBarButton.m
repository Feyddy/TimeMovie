//
//  TabBarButton.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "TabBarButton.h"

@implementation TabBarButton

//方法的重写
-(id)initWithTitle:(NSString *)title image:(NSString *)imageName frame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
//        创建按钮上面的图片
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake((frame.size.width-20) / 2, 0, 20,30)];
        image.image = [UIImage imageNamed:imageName];
        
//        拉伸图片的
        image.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:image];
        
//        设置按钮上的文本
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 32, frame.size.width, 15)];
        label.text = title;
        label.textColor = [UIColor whiteColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:12];
        [self addSubview:label];
        
    }
    return self;
    
}


@end
