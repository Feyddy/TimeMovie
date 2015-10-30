//
//  Cinema.m
//  TimeMovie
//
//  Created by Mac on 15/8/26.
//  Copyright (c) 2015年 huiwenjiaoyu. All rights reserved.
//

#import "Cinema.h"


//@property(nonatomic,copy)NSString *lowPrice;//最低价格
//@property(nonatomic,copy)NSString *grade;//评分
//@property(nonatomic,copy)NSString *distance;//距离
//@property(nonatomic,copy)NSString *address;//地址
//@property(nonatomic,copy)NSString *name;//名字
//@property(nonatomic,copy)NSString *districtId;//id
//
//@property(nonatomic,assign)NSInteger *isSeatSupport;//座位
//@property(nonatomic,assign)NSInteger *isCouponSupport;//券
//@property(nonatomic,assign)NSInteger *isImaxSupport;//max
//@property(nonatomic,assign)NSInteger *isGroupBuySupport;//团
@implementation Cinema

- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        _lowPrice = dic[@"lowPrice"];
        _grade = dic[@"grade"];
        _address = dic[@"address"];
        _name = dic[@"name"];
        _districtId = dic[@"districtId"];
        _distance = dic[@"distance"];
        
        _isSeatSupport = [dic[@"isSeatSupport"] integerValue];
        _isCouponSupport = [dic[@"isCouponSupport"] integerValue];
        _isImaxSupport = [dic[@"isImaxSupport"] integerValue];
        _isGroupBuySupport = [dic[@"isGroupBuySupport"] integerValue];
    }
    return self;
}


@end
