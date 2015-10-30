//
//  NewsViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "NewsViewController.h"
#import "News.h"
#import "NewsCell.h"
#import "UIImageView+WebCache.h"
#import "SecondNewsViewController.h"
#import "BaseTabBarController.h"
#import "WebViewController.h"

@interface NewsViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_newsList;
    UITableView *_newsView;
    UIImageView *_topImageView;
    NSMutableArray *_title;
    NSMutableArray *_im;
}

@end

@implementation NewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新闻";
    [self loadData];
    [self _createTableView];
    
    // Do any additional setup after loading the view.
}

-(void)loadData{
   NSArray *array = [MovieJSON readJSONFile:@"news_list"];
    
    _title = [[NSMutableArray alloc]init];
    
    _im = [[NSMutableArray alloc]init];
    
    _newsList = [[NSMutableArray alloc]init];
    
    for (NSDictionary *dic in array) {
        
        NSString *title = dic[@"title"];
        //NSLog(@"%@",title);
        [_title addObject:title];
        
        NSString *imageName = dic[@"image"];
        //NSLog(@"%@",imageName);
        [_im addObject:imageName];
        
        News *news = [[News alloc]initContentWithDic:dic];
        [_newsList addObject:news];
    }
    
}


-(void)_createTableView{
    //创建表视图
   _newsView = [[UITableView alloc]initWithFrame:self.view.bounds];
    //[_newsView setBackgroundColor:[UIColor grayColor]];
    _newsView.dataSource = self;
    _newsView.delegate = self;
    [self.view addSubview:_newsView];
    
    
    //头视图不可以改变大小与位置，只有通过创建一个新的uiview然后将图片视图加入view中，让新建的view变成头视图，将图片视图加入到view中，从而可以改变图片视图的大小
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    [headView addSubview:_topImageView];
    //heardView.backgroundColor = [UIColor blackColor];
    _newsView.tableHeaderView = headView;
//    _topImageView.userInteractionEnabled = YES;

    
    
    
    NSString *urlString = _im[0];
    NSURL *url = [NSURL URLWithString:urlString];
    [_topImageView sd_setImageWithURL:url];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 160, self.view.bounds.size.width, 40)];
    [label setBackgroundColor:[UIColor blackColor]];
    label.alpha = 0.4;
    label.textColor = [UIColor whiteColor];
    label.text = _title[0];
    [_topImageView addSubview:label];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _newsList.count-1;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    static NSString *identifier = @"cell";
    NewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"NewsCell" owner:nil options:nil]lastObject];
        cell.backgroundColor = [UIColor clearColor];
//         cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
        cell.news = _newsList[indexPath.row+1];
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取滑动视图y方向的偏移量
    CGFloat yOffSet = scrollView.contentOffset.y + 64;

    NSLog(@"%lf",yOffSet);
    if (yOffSet < 0)
    {
        CGFloat oldImage = 200;
        CGFloat newImage = 200-yOffSet;
        CGFloat scale = newImage / oldImage;
        
        // 设置图片的 transform
        CGAffineTransform transform = CGAffineTransformMakeScale(scale, scale);
        
        // 对图片视图 进行缩放变换
        _topImageView.transform = transform;
        
        // 调整视图变换后的位置
        _topImageView.top = yOffSet ;
    }
    else
    {
        // 对视图进行还原
        _topImageView.transform = CGAffineTransformIdentity;
    }
}

// 表视图单元格选中事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 获取相对应的 news 对象
    News *news = _newsList[indexPath.row+1];
    int type = [news.type intValue];
    if (type == 1)
    {
      SecondNewsViewController *newsImage = [[SecondNewsViewController alloc]init];
        
        newsImage.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:newsImage animated:YES];
    }
    else if(type == 0)
    {
        //push
        [self.navigationController pushViewController:[[WebViewController alloc]init] animated:YES];
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
