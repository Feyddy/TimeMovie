//
//  PostCollectionView.h
//  TimeMovie
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostCollectionView : UICollectionView
@property(nonatomic,strong) NSArray *movieData;

@property (nonatomic , assign) NSInteger index;

@end
