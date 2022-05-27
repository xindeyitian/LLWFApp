//
//  ShopModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AdvertisingModel;
@interface ShopModel : NSObject
//售后评分
@property (copy, nonatomic) NSString *afterSaleValue;
//评价评分
@property (copy, nonatomic) NSString *appraisalValue;
//区
@property (copy, nonatomic) NSString *areaName;
//店铺背景图
@property (copy, nonatomic) NSString *bgImgUrl;
//市
@property (copy, nonatomic) NSString *cityName;
//收藏数量
@property (copy, nonatomic) NSString *collectCount;
//开店时间
@property (copy, nonatomic) NSString *createTime;
//广告位
@property (strong, nonatomic) NSArray<AdvertisingModel *> *imgUrls;
//物流评分
@property (copy, nonatomic) NSString *logisticsValue;
//店铺logo头像
@property (copy, nonatomic) NSString *logoImgUrl;
//省
@property (copy, nonatomic) NSString *provinceName;
//店铺编号
@property (assign, nonatomic) NSInteger shopId;
//店铺名称
@property (copy, nonatomic) NSString *shopName;
//店铺星级
@property (copy, nonatomic) NSString *shopStars;
 //是否收藏
@property (assign, nonatomic) NSInteger isCollect;

@end

@interface AdvertisingModel : NSObject
//广告编号
@property (copy, nonatomic) NSString *advId;
//图片地址
@property (copy, nonatomic) NSString *imgUrl;
//链接记录ID
@property (copy, nonatomic) NSString *linkId;
//链接类型：goods、coupon
@property (copy, nonatomic) NSString *linkType;

@end

NS_ASSUME_NONNULL_END
