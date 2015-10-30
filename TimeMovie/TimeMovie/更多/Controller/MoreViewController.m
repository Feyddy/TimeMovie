//
//  MoreViewController.m
//  TimeMovie
//
//  Created by Mac on 15/8/19.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    NSArray *_imageList;
    NSArray *_textList;
    UILabel *_RAM;
    
   // CGFloat maxSize;
}


@property (nonatomic,strong) UITableView *tabelView;
@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self _loadTabelView];

    
    self.title = @"更多";
    
    _imageList = @[@"moreClear@2x",@"moreScore@2x",@"moreVersion@2x",@"moreBusiness@2x",@"moreWelcome@2x",@"moreAbout@2x"];
    _textList = @[@"清理缓存",@"给个评价",@"检查版本",@"商务合作",@"欢迎界面",@"关于我们"];
    
    _RAM = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width- 90,5, 100, 50)];
    
    _RAM.font = [UIFont systemFontOfSize:17];
    _RAM.font = [UIFont boldSystemFontOfSize:20];
    _RAM.textColor = [UIColor whiteColor];
    _RAM.textAlignment = NSTextAlignmentLeft;
    
    _RAM.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];

    
}

#pragma mark - createView

-(void)_loadTabelView
{
    //创建表视图
    

    _tabelView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height) style:UITableViewStyleGrouped];
    _tabelView.backgroundColor = [UIColor clearColor];
    _tabelView.delegate = self;
    _tabelView.dataSource = self;
//    _tabelView.allowsSelection = NO;
    [self.view addSubview:_tabelView];
    //_tabelView.scrollEnabled = NO;


    
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _imageList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.backgroundColor = [UIColor clearColor];

    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(20,15, 30, cell.bounds.size.height-20)];
    image.image = [UIImage imageNamed:_imageList[indexPath.row]];
    [cell addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(60, 15, cell.bounds.size.width-150, cell.bounds.size.height-20)];
    label.text = _textList[indexPath.row];
    label.font = [UIFont systemFontOfSize:17];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textColor = [UIColor whiteColor];
    [cell addSubview:label];
    //NSLog(@"%@",cell.frame);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row ==0) {

        [cell addSubview:_RAM];
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}



#pragma mark - 计算当前缓存文件的大小

/**
 *  计算当前应用程序缓存文件的大小之和
 *
 *  @return 文件大小
 */

-(CGFloat )countCacheFileSize
{
    //1.获取缓存文件夹的路径
    
    //函数，用于获取当前应用程序的沙盒路径
    
    NSString * homePath = NSHomeDirectory();
    
    NSLog(@"%@",homePath);
    
    
    /**
     *  1) 子文件夹 1 视频缓存 /tmp/MediaCache/
     *  2）子文件夹 2 SDWebImage框架的缓存图片 /Library/Caches/com.hackemist.SDWebImageCache.default/
     *  3) 子文件夹 3  /Library/Caches/cn.xuzhonglin.TimeMovie/

     */
    
    //2.使用- (CGFloat )getFileSize:(NSString *)filePath 来计算这些文件夹中文件的大小
    
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/cn.xuzhonglin.TimeMovie/"];
    
//    //文件大小的综合
    CGFloat fileSize = 0;
    for (NSString *string in pathArray) {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        
      fileSize += [self getFileSize:filePath];
        
    }
    
    //3.对上一步计算的结果经行求和 并返回
    
    return fileSize;
    
}

/**
 *  根据传入的路径 计算此路径下的文件的大小
 *
 *  @param filePath 文件路径
 *
 *  @return 此文件夹下所有文件的总和大小 单位MB
 */
- (CGFloat )getFileSize:(NSString *)filePath
{
    //文件管理器对象 单例
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //数组 储存文件夹中所有文件夹及其文件的名字
    NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
    
    long long size = 0;
    
    //便遍历文件夹
    
    for (NSString *fileName in fileNames) {
        
        //拼接文件路径
        NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
        
        //获取文件信息
        NSDictionary *dic = [manager attributesOfItemAtPath:subFilePath error:nil];
        
        //获取单个文件的大小
        NSNumber *sizeNumber = dic[NSFileSize];
        
        //使用一个long long 类型来储存文件大小
        long long subFileSize = [sizeNumber longLongValue];
        
        //文件大小求和
        size += subFileSize;
    }
    
    return size / 1024.0 / 1024;
}



#pragma mark - 清理缓存

//清理缓存文件
-(void)clearCacheFile
{
    
    
    
    
    //获取缓存文件路径
    
    //1.获取缓存文件夹的路径
    
    //函数，用于获取当前应用程序的沙盒路径
    
    NSString * homePath = NSHomeDirectory();
    
    //NSLog(@"%@",homePath);
    
    //2.删除文件
    
    NSArray *pathArray = @[@"/tmp/MediaCache/",
                           @"/Library/Caches/com.hackemist.SDWebImageCache.default/",
                           @"/Library/Caches/cn.xuzhonglin.TimeMovie/"];

    for (NSString *string in pathArray) {
        //拼接路径
        NSString *filePath = [NSString stringWithFormat:@"%@%@",homePath,string];
        //文件管理
        NSFileManager *manager = [NSFileManager defaultManager];
        
        //获取子文件夹中的文件名
        NSArray *fileNames = [manager subpathsOfDirectoryAtPath:filePath error:nil];
        
        //遍历文件夹 删除文件
        for (NSString *fileName in fileNames) {
            
            //拼接文件路径
            NSString *subFilePath = [NSString stringWithFormat:@"%@%@",filePath,fileName];
            
            //删除文件
            [manager removeItemAtPath:subFilePath error:nil];
            
        }
        
    }
    
    //重新计算文件大小
    
    _RAM.text = [NSString stringWithFormat:@"%.2fMB",[self countCacheFileSize]];
}


//单元格的选中时间
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row ==0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"WARNING！" message:@"Whether to clear the cache" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Yes", nil];
        [alert show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //判断点击的
    if (buttonIndex ==1) {
        [self performSelector:@selector(clearCacheFile) withObject:_RAM.text = @"Clearing..." afterDelay:2];
        
//        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Did Clearing!" message:@"Clearing Succese!" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
//        [alert show];
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
