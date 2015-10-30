//
//  CinemaViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "CinemaViewController.h"
#import "Cinema.h"
#import "CinemaCell.h"
@interface CinemaViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *_cityData;//地区数组
    NSMutableArray *_cinemaData;//电影数组
    NSMutableArray *_idData;    //id数组
    NSMutableArray *_nameData;  //二维数组，用来存储相同ID的城市。

    UITableView *_tableView;
    NSMutableArray *_isSected;  //点击组头视图之后是否隐藏其下的单元格，即储存行数打开关闭的状态
}
@end

@implementation CinemaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"电影院";
    
    //读取城市--组头视图名字数据
    [self _loadCity];
    
    //读取电影院数据
    [self _loadCinema];
    
    //创建TableView
    [self _createTableView];

}

#pragma mark -读取组头视图名字数据
//
- (void)_loadCity{
    
    //读取JSON文件
    NSDictionary *dic = [MovieJSON readJSONFile:@"district_list"];
    _cityData = [[NSMutableArray alloc] init];
    _idData = [[NSMutableArray alloc] init];
    
    //循环获取城市的ID和城市名
    for (NSDictionary *d in dic[@"districtList"]) {
        [_cityData addObject:d[@"name"]];
        [_idData addObject:d[@"id"]];
    }
    
    //为每个分组创建一个判断
    _isSected = [[NSMutableArray alloc] init];
    for (int i = 0; i<_cityData.count; i++) {
        _isSected[i] = @"NO";//初始状态是不开启
    }
}


//读取电影数据
- (void)_loadCinema{
    
    //读取电影院数据
    NSDictionary *dic = [MovieJSON readJSONFile:@"cinema_list"];

    //初始化电影院的数组
    _cinemaData = [[NSMutableArray alloc] init];
    
    //循环读取电影院数据
    for (NSDictionary *d in dic[@"cinemaList"]) {
        Cinema *cinema = [[Cinema alloc] initWithDictionary:d];
 
        //将数据存储到电影院数组中
        [_cinemaData addObject:cinema];
    }
    
    
    
    //因为ID是判断那个影院是属于那个城市的，所以将id相同的保存在一起
    _nameData = [[NSMutableArray alloc] init];
    
    //首先根据ID 与在cinema中的id数组中的id相比较 选择id相同的城市存储到array中
    for (int i = 0; i < _idData.count; i++)
    {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        for (int j = 0; j < _cinemaData.count; j++)
        {
            //遍历取出_cinemaData中的数据
            Cinema *cinema = _cinemaData[j];
            //如果cinema的districtId等于_idData的id，则将cinema保存到数组array中
            if ([cinema.districtId isEqualToString:_idData[i]])
            {
                [array addObject:cinema];
            }
        }
        //将保存了分别具有相同id的数组保存到数组_nameData中
        [_nameData addObject:array];
    }
}


//创建表视图
- (void)_createTableView{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_main@2x"]];
    [self.view addSubview:_tableView];
}

//表视图组的行数--根据城市的数量进行判断
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _cityData.count;
}


#pragma mark - 组头视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, kScreenWidth, 35);
    
    UIImage *image = [UIImage imageNamed:@"hotMovieBottomImage@2x"];
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setTitle:[NSString stringWithFormat:@"%@",_cityData[section]] forState:UIControlStateNormal];
    
    //设置button四周的间距
    [button setTitleEdgeInsets:UIEdgeInsetsMake(5, 5, 5, kScreenWidth-300)];
    //通过设置的tag值判断点击的是哪个button
    button.tag = section;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
//组头视图高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

#pragma mark - 表视图数据源方法
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CinemaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CinemaCell"];
    
    if (cell == nil) {
        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"CinemaCell" owner:nil options:nil];
        cell = [array lastObject];
    }
    
    cell.cinema = _nameData[indexPath.section][indexPath.row];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}
//单元格行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //如果是打开状态，显示他的内部单元格
    if ([_isSected[section] isEqualToString:@"YES"])
    {
        NSArray *array = _nameData[section];
        return array.count;
    }
    //否则隐藏
    return 0;
}


//单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

#pragma mark - button点击事件
//根据button的状态来控制单元格的打开与收起
- (void)buttonAction:(UIButton *)button{
    
    if ([_isSected[button.tag] isEqualToString:@"NO"]) {
        
        //点击时候的button的单元格显示状态
        _isSected[button.tag] = @"YES";
        
        //
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag]
                  withRowAnimation:UITableViewRowAnimationFade];
    }
    else if ([_isSected[button.tag] isEqualToString:@"YES"])
    {
        _isSected[button.tag] = @"NO";
        [_tableView reloadSections:[NSIndexSet indexSetWithIndex:button.tag] withRowAnimation:UITableViewRowAnimationFade];
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
