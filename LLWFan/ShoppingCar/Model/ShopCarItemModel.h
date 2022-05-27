//
//  ShopCarItemModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarItemModel : NSObject

@property (copy, nonatomic) NSString *activityId;
@property (copy, nonatomic) NSString *activityType;
@property (copy, nonatomic) NSString *djlsh;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *platCode;
@property (copy, nonatomic) NSString *shopId;
@property (copy, nonatomic) NSString *shopName;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *quantity;
@property (copy, nonatomic) NSString *goodsId;
@property (copy, nonatomic) NSString *skuId;
@property (copy, nonatomic) NSString *srcSkuId;
@property (copy, nonatomic) NSString *srcGoodsId;
@property (copy, nonatomic) NSString *skuName;
@property (copy, nonatomic) NSString *skuImgUrl;
@property (copy, nonatomic) NSString *discountId;
@property (assign, nonatomic) float priceMark;
@property (assign, nonatomic) float priceSale;
@property (copy, nonatomic) NSString *voucherSub;
@property (copy, nonatomic) NSString *balanceSub;
@property (copy, nonatomic) NSString *moneyPayed;
@property (copy, nonatomic) NSString *remark;
@property (copy, nonatomic) NSString *factoryId;
@property (copy, nonatomic) NSString *sourceType;
@property (copy, nonatomic) NSString *agentShopId;
@property (copy, nonatomic) NSString *agentUserId;
@property (assign, nonatomic) BOOL valid;
@property (copy, nonatomic) NSString *updateTime;

@property (assign, nonatomic) CGFloat height;
@property (assign, nonatomic) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
