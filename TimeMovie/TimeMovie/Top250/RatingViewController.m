//
//  RatingViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/27.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "RatingViewController.h"
#import "RatingHeadView.h"
#import "Top250.h"
#import "RatingCell.h"
#import "MovieDetail.h"

@interface RatingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    MovieDetail *_movieDetail;
    RatingHeadView *_headerView;
}

@property (nonatomic,strong) NSMutableArray *comments;

//@property (nonatomic,strong) NSMutableArray *movieData;

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation RatingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"影评";
    
//    //读取xib
//    RatingHeadView *head = [[[NSBundle mainBundle]loadNibNamed:@"RatingHeadView" owner:nil options:nil]lastObject];
//    _tableView.tableHeaderView = head;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor blackColor];
    _tableView.showsVerticalScrollIndicator = NO;
    
    [self loadData];
}

-(void)loadData
{
    NSDictionary *dic = [MovieJSON readJSONFile:@"movie_comment"];
    NSArray *array = dic[@"list"];
    _comments = [[NSMutableArray alloc]init];
    for (NSDictionary *d in array) {
        Top250 *c = [[Top250 alloc] initWithDictionary:d];
        [_comments addObject:c];
    }
    

    NSDictionary *dic1 = [MovieJSON readJSONFile:@"movie_detail"];

    _movieDetail = [[MovieDetail alloc]initWithDictionary:dic1];

    _headerView = [[[NSBundle mainBundle] loadNibNamed:@"RatingHeadView" owner:nil options:nil]lastObject];
    
    _headerView.navigationController = self.navigationController;
    //_headerView.backgroundColor = [UIColor clearColor];
    
    _headerView.detail = _movieDetail;
    
    _tableView.tableHeaderView = _headerView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _comments.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RatingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ratingCell"];
    cell.comment = _comments[indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor blackColor];
    return  cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //计算字符Label高度
    //拿到当前行的评论对象
    Top250 *comment = _comments[indexPath.row];
    
    
    if (comment.isShow) {
        //评论的内容
        NSString *string = comment.content;
        
        CGSize maxSize = CGSizeMake(kScreenWidth - 80, CGFLOAT_MAX);
        
        NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17]};
        
        CGRect rect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        return rect.size.height + 50;
    }
    else
    {
        return 70;
    }

}



//单元格选中事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Top250 *comment = _comments[indexPath.row];
    comment.isShow = ! comment.isShow;
    
    //刷新单元格
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
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
