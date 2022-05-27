//
//  SettleModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/19.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class SettleOrderItemModel;

@interface SettleModel : NSObject

@property (copy, nonatomic) NSString *addrId;
@property (copy, nonatomic) NSString *from;
@property (strong, nonatomic) SettleOrderItemModel *orderItem;
@property (strong, nonatomic) NSArray  *skuIds;

@end

@interface SettleOrderItemModel : NSObject
//活动类型 1标准订单、2合同订单、3预支付订单、4三年五年订单、5零元分红计划订单、6社区活动订单、7全球购、8魔盒领取订单、9团体定制订单、10秒杀订单
@property (assign, nonatomic) NSInteger activityType;
//推广的店铺ID,默认-1
@property (copy, nonatomic) NSString *agentShopId;
//推广的用户ID,默认-1
@property (copy, nonatomic) NSString *agentUserId;
//*供应商id *
@property (copy, nonatomic) NSString *factoryId;
//商品ID
@property (copy, nonatomic) NSString *goodsId;
//零元购是否为线上
@property (copy, nonatomic) NSString *isOnline;
//0元购 分期id
@property (copy, nonatomic) NSString *periodShopId;
//*商品数量*
@property (copy, nonatomic) NSString *quantity;
//秒杀商品的注册id，即 seckill_goods 主键
@property (copy, nonatomic) NSString *seckillGoodsId;
//秒杀活动id
@property (copy, nonatomic) NSString *seckillId;
//店铺id
@property (copy, nonatomic) NSString *shopId;
//*skuId*
@property (copy, nonatomic) NSString *skuId;
//*渠道来源 1.1688, 2.鲸灵, 3行云货仓*
@property (assign, nonatomic) NSInteger sourceType;

@end
NS_ASSUME_NONNULL_END
