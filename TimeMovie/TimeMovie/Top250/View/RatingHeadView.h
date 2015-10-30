//
//  RatingHeadView.h
//  TimeMovie
//
//  Created by Mac on 15/8/28.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieDetail.h"
//@property (nonatomic, copy) NSString *image;
//@property (nonatomic, strong) NSArray *actors;
//@property (nonatomic, strong) NSArray *directors;
//@property (nonatomic, strong) NSArray *images;
//@property (nonatomic, copy) NSString *date;
//@property (nonatomic, copy) NSString *location;
//@property (nonatomic, copy) NSString *titleCn;
//@property (nonatomic, strong) NSArray *type;

@interface RatingHeadView : UIView<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


@property (strong, nonatomic) IBOutlet UILabel *titleCLabel;

@property (strong, nonatomic) IBOutlet UIImageView *movieImageView;

@property (strong, nonatomic) IBOutlet UILabel *directorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *actorsLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imagesView;

//@property (nonatomic,assign) NSMutableArray *data;

@property (nonatomic,strong) MovieDetail *detail;

@property (nonatomic,strong) NSMutableArray *imageList;

@property (nonatomic ,weak) UINavigationController *navigationController;


@end
