//
//  Cinema.h
//  TimeMovie
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import <Foundation/Foundation.h>




/*
 {
 "lowPrice" : "40.00",
 "grade" : "8.8",
 "distance" : null,
 "address" : "北京市海淀区学清路甲8号，圣熙8号购物中心五层西侧。",
 "name" : "嘉华国际影城",
 "districtId" : "1015",
 "isSeatSupport" : "1",
 "isCouponSupport" : "1",
 "isImaxSupport" : "0",
 "isGroupBuySupport" : "0",
 
 }, {
//"coord" : "116.36047,40.01433",
 //"id" : "1396",
 //"msg" : null,
 //"tel" : "010-82732228",
 //"circleName" : "五道口"
 */

@interface Cinema : NSObject

@property(nonatomic,copy)NSString *lowPrice;//最低价格
@property(nonatomic,copy)NSString *grade;//评分
@property(nonatomic,copy)NSString *distance;//距离
@property(nonatomic,copy)NSString *address;//地址
@property(nonatomic,copy)NSString *name;//名字
@property(nonatomic,copy)NSString *districtId;//id

@property(nonatomic,assign)NSInteger isSeatSupport;//座位
@property(nonatomic,assign)NSInteger isCouponSupport;//券
@property(nonatomic,assign)NSInteger isImaxSupport;//max
@property(nonatomic,assign)NSInteger isGroupBuySupport;//团

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end
