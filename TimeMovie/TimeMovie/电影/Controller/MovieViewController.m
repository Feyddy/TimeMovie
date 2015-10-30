//
//  MovieViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MovieViewController.h"
#import "Movie.h"
#import "MovieCell.h"
#import "PostCollectionView.h"
#import "DetailCollectionView.h"

@interface MovieViewController (){
    UIButton *_rightButton;//创建导航栏上面的右边的按钮
    //创建单元格界面
    UITableView *_listView;
    //创建翻转后的海报界面
    UIView *_posterView;
    
    PostCollectionView *_postCollectionView;
    
    DetailCollectionView *_detailCollectionView;
    
    //电影的信息数组
    NSMutableArray *_movieArray;
    
    //透视图
    UIView *_headerView;
    
    //创建按钮
    UIButton *_upDownButton;
    
    //创建遮罩视图
    UIView *_maskView;
    
    //创建灯图片视图
    UIImageView *_lightLeft;
    UIImageView *_lightRight;
    
    //创建
}

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影";
    
    //读取数据
    [self _dataLoad];
    
    //创建右边按钮的方法
    [self _createRightButton];
    
    //创建转换视图，一个tabView,一个view
    [self _createViews];
    
    //透视图
    [self _createHeaderView];
    
    //添加观察者
    [self addKVO];
    
}

#pragma mark - 数据的读取
-(void)_dataLoad
{

   
    
    NSDictionary *dic = [MovieJSON readJSONFile:@"us_box"];
    //4.处理和储存数据
    
    //获取subjectsz字典里面的subjects对应的值
    NSArray *subjects = dic[@"subjects"];
    
    //重要的部分
    _movieArray = [[NSMutableArray alloc]init];
    
    //循环存储电影数据
    for (NSDictionary *dictionary in subjects) {
        
        Movie *movie = [[Movie alloc]initWithContentsOfNSdictionary:dictionary[@"subject"]];
        
        [_movieArray addObject:movie];
    }
    
    
}



#pragma mark - create
//创建两个表示图进行旋转切换
-(void)_createViews
{
    
    //创建表视图
    _listView = [[UITableView alloc]initWithFrame:self.view.bounds];
    [_listView setBackgroundColor:[UIColor grayColor]];
    _listView.dataSource = self;
    _listView.delegate = self;
    [self.view addSubview:_listView];
    
    //创建海报视图
    _posterView = [[UIView alloc]initWithFrame:self.view.bounds];
    _posterView.backgroundColor = [UIColor purpleColor];
    _posterView.hidden = YES;
    [self.view addSubview:_posterView];
    
    //创建COLLECTIONvIEW
    _postCollectionView = [[PostCollectionView alloc]initWithFrame:_posterView.bounds];
    _postCollectionView.backgroundColor = [UIColor blackColor];
    
    //将电影的数据传给_postCollectionView
    _postCollectionView.movieData = _movieArray;
    [_posterView addSubview:_postCollectionView];
    

}

//创建头视图及其相应的视图控件
-(void)_createHeaderView
{
    
    //左右灯的视图
    _lightLeft = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2-110, 74, 61, 101)];
    _lightLeft.image = [UIImage imageNamed:@"light"];
    [_posterView addSubview:_lightLeft];
    _lightLeft.hidden = NO;
    
    _lightRight = [[UIImageView alloc]initWithFrame:CGRectMake(kScreenWidth/2+50, 74, 61, 101)];
    _lightRight.image = [UIImage imageNamed:@"light"];
    [_posterView addSubview:_lightRight];
    _lightRight.hidden = NO;
    


    //创建遮罩视图
    _maskView = [[UIView alloc]initWithFrame:_posterView.bounds];
    _maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];

    _maskView.hidden = YES;
    [_posterView addSubview:_maskView];

    //添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(headerMoveUp)];
    [_maskView addGestureRecognizer:tap];
    
    //添加滑动手势
    UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(headerMoveDown)];
    swip.direction = UISwipeGestureRecognizerDirectionDown;
    [_posterView addGestureRecognizer:swip];
    
    UISwipeGestureRecognizer *swip1 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(headerMoveUp)];
    swip1.direction = UISwipeGestureRecognizerDirectionUp;
    [_posterView addGestureRecognizer:swip1];
    
    //创建头视图
    _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64-100, kScreenWidth, 130)];
    _headerView.backgroundColor = [UIColor clearColor];
    [_posterView addSubview:_headerView];
    
    //创建头视图图片
    UIImage *headerImage = [UIImage imageNamed:@"indexBG_home"];
    //拉伸图片
    headerImage = [headerImage stretchableImageWithLeftCapWidth:0 topCapHeight:5];
    UIImageView *hearderViewImage = [[UIImageView alloc]initWithFrame:_headerView.bounds];
    hearderViewImage.image = headerImage;
    [_headerView addSubview:hearderViewImage];
    
    
    //创建按钮
    _upDownButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _upDownButton.frame = CGRectMake(0, 0, 26, 20);
    _upDownButton.center = CGPointMake(kScreenWidth/2, 120);
    [_upDownButton setImage:[UIImage imageNamed:@"down_home"] forState:UIControlStateNormal];
    [_upDownButton setImage:[UIImage imageNamed:@"up_home"] forState:UIControlStateSelected];
    [_headerView addSubview:_upDownButton];
    [_upDownButton addTarget:self action:@selector(upDownAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //创建_detailCollectionView
    _detailCollectionView = [[DetailCollectionView alloc]initWithFrame:CGRectMake(0, 10, _headerView.bounds.size.width, _headerView.bounds.size.height-30)];
    _detailCollectionView.backgroundColor = [UIColor clearColor];

    //将电影的数据传给_detailCollectionView
    _detailCollectionView.movieData = _movieArray;
    [_headerView addSubview:_detailCollectionView];
    

    
}

#pragma mark - 协议方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _movieArray.count;//0代表只创建页面内的单元格视图
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MovieCell" owner:nil options:nil]lastObject];        //使得创建的单元格背景为透明的，可以显示背景颜色
            cell.backgroundColor = [UIColor clearColor];
    }
    
    cell.movie = _movieArray[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark - Button

//创建导航栏右边的按钮
- (void)_createRightButton{
    //初始化按钮根据图片的大小
    _rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 49, 25)];
    
    //设置导航栏右边按钮的背景图片
    [_rightButton setBackgroundImage:[UIImage imageNamed: @"exchange_bg_home@2x"] forState:UIControlStateNormal];
    
    //设置按钮的图片
    [_rightButton setImage:[UIImage imageNamed:@"list_home"] forState:UIControlStateNormal];
    
    [_rightButton setImage:[UIImage imageNamed:@"poster_home"] forState:UIControlStateSelected];
    
    //打包按钮，变成导航栏按钮类型
    UIBarButtonItem *right = [[UIBarButtonItem alloc]initWithCustomView:_rightButton];
    
    //添加点击事件
    [_rightButton addTarget:self action:@selector(rightBarButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    //    把按钮设置成导航栏的右边按钮
    self.navigationItem.rightBarButtonItem = right;
}


//导航栏右边按钮的点击事件
-(void)rightBarButtonAction:(UIButton *)button{

    //设置旋转的方向，更具按钮的点击的情况设置不同的旋转效果
    UIViewAnimationOptions option = button.selected ? UIViewAnimationOptionTransitionFlipFromLeft:UIViewAnimationOptionTransitionFlipFromRight;
    
    //添加动画效果
    [self flipViews:_rightButton options:option];
    [self flipViews:self.view options:option];
//
    _rightButton.selected = !_rightButton.selected;
    _listView.hidden = !_listView.hidden;
    _posterView.hidden = !_posterView.hidden;
}

//创建伸缩效果按钮
-(void)upDownAction:(UIButton *)button
{
//    button.selected = !button.selected;
    if (button.selected) {
        [self headerMoveUp];
    }
    else
    {
        [self headerMoveDown];
    }
}

//滑动手势响应事件
-(void)headerMoveUp
{
   _upDownButton.selected = !_upDownButton.selected;
    //一上拉灯就开始消失

    [UIView animateWithDuration:0.2 animations:^{
        _headerView.top = -36;
        _upDownButton.hidden = NO;
        _maskView.hidden = YES;
    } completion:^(BOOL finished) {
        _lightLeft.hidden = NO;
        _lightRight.hidden = NO;
    }];
    

}
//滑动手势响应事件
-(void)headerMoveDown
{
    _upDownButton.selected = !_upDownButton.selected;
    
    //下拉动作完成之后才显示灯
    [UIView animateWithDuration:0.3 animations:^{
        _headerView.top = 64;
        _upDownButton.hidden = NO;
        _maskView.hidden = NO;
//        _lightLeft.hidden = YES;
//        _lightRight.hidden = YES;
        
    }];

}


#pragma mark - 自定义的按钮以及背景的旋转动画
-(void)flipViews:(UIView *)view options:(UIViewAnimationOptions)option{
    [UIView transitionWithView:view
                      duration:.2
                       options:option
                    animations:^{}
                    completion:nil];
    
}


#pragma mark - KVO

- (void)addKVO
{
    [_postCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
    
    [_detailCollectionView addObserver:self forKeyPath:@"index" options:NSKeyValueObservingOptionNew context:nil];
}

-(void)dealloc
{
    [_postCollectionView removeObserver:self forKeyPath:@"index"];
    
    [_detailCollectionView removeObserver:self forKeyPath:@"index"];
}

#pragma mark - 观察者方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
    //获取新的index值
    NSNumber *itemNumber = change[@"new"];
    NSInteger itemInt = [itemNumber integerValue];
    
    //
    NSIndexPath *itemIndex = [NSIndexPath indexPathForItem:itemInt inSection:0];
    
    //判断是哪个collection
    if (object == _postCollectionView && itemIndex.item != _detailCollectionView.index) {
        //滑动小的视图
        [_detailCollectionView scrollToItemAtIndexPath:itemIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _detailCollectionView.index = itemIndex.item;
    }
    else if (object == _detailCollectionView && itemIndex.item != _postCollectionView.index)
    {
        [_postCollectionView scrollToItemAtIndexPath:itemIndex atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        _postCollectionView.index = itemIndex.item;
    }
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
