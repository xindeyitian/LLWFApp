//
//  KongKimModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/12.
//

#import "KongKimModel.h"
//@property (strong, nonatomic) NSArray *bannerInfos;
//@property (strong, nonatomic) NSArray *bannerAdv;
//@property (strong, nonatomic) NSArray *blockDefine;
//@property (strong, nonatomic) NSArray *blockDefineGoods;
//@property (strong, nonatomic) NSArray *blockDefineCentre;
@implementation KongKimModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"bannerInfos":[BannerModel class],
             @"bannerAdv":[BannerModel class],
             @"blockDefine":[KongKinItemModel class],
             @"blockDefineGoods":[KongKinItemModel class],
             @"blockDefineCentre":[KongKinItemModel class],
             @"blockDefineCentreRight":[KongKinItemModel class],
    };
}

@end
@implementation KongKinItemModel

@end
@implementation BannerModel

@end
