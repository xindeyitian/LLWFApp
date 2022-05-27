//
//  UnionOrderModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class ShopOrdersModel;

@interface UnionOrderModel : NSObject
//活动类型 1标准订单、2合同订单、3预支付订单、4三年五年订单、5零元分红计划订单、6社区活动订单、7全球购、8魔盒领取订单、9团体定制订单、10秒杀订单
@property (copy, nonatomic) NSString *activityType;
//余额剩余金额
@property (copy, nonatomic) NSString *balanceLeft;
//是否选中余额抵扣
@property (copy, nonatomic) NSString *balanceSelected;
//余额抵扣金额
@property (copy, nonatomic) NSString *balanceSub;
//总运费
@property (copy, nonatomic) NSString *expressFee;
//每个店铺的订单信息
@property (copy, nonatomic) NSString *moneyCouponSub;
//每个店铺的订单信息
@property (strong, nonatomic) NSArray<ShopOrdersModel *> *shopOrders;
//购物车 skuId 列表，从购物车中结算时携带
@property (strong, nonatomic) NSArray *skuIds;
//总标价
@property (assign, nonatomic) float totalMoneyMark;
//实际订单金额
@property (assign, nonatomic) float totalMoneyOrder;
//实际支付金额
@property (assign, nonatomic) float totalMoneyPayed;
//总成交价
@property (assign, nonatomic) float totalMoneySale;
//订单id
@property (copy, nonatomic) NSString *unionOrderId;
//地址ID
@property (copy, nonatomic) NSString *userAddrId;
//抵用金剩余金额
@property (copy, nonatomic) NSString *voucherLeft;
//是否选中抵用金抵扣
@property (copy, nonatomic) NSString *voucherSelected;
//抵用金抵扣金额
@property (copy, nonatomic) NSString *voucherSub;

///自己赋值字段 支付方式 1支付宝 2微信
@property (assign, nonatomic) NSInteger payType;

@end

@interface ShopOrdersModel : NSObject
//推广的店铺ID
@property (copy, nonatomic) NSString *agentShopId;
//推广的用户ID
@property (copy, nonatomic) NSString *agentUserId;
//优惠券编号
@property (copy, nonatomic) NSString *couponCode;
//优惠券ID
@property (copy, nonatomic) NSString *couponId;
//总运费
@property (copy, nonatomic) NSString *expressFee;
//供应商id
@property (copy, nonatomic) NSString *factoryId;
//分组类型, 默认标准订单llwf
@property (copy, nonatomic) NSString *groupType;
//优惠券减免金额
@property (copy, nonatomic) NSString *moneyCouponSub;
//订单类型 1标准订单、2合同订单、3预支付订单、4三年五年订单、5零元分红计划订单、6社区活动订单、7全球购、9团体定制订单
@property (copy, nonatomic) NSString *orderType;
//订单备注信息
@property (copy, nonatomic) NSString *remarks;
//店铺下购买的商品
@property (strong, nonatomic) NSArray<ShopCarItemModel *> *shopCartItems;
//店铺id
@property (copy, nonatomic) NSString *shopId;
//店铺名称
@property (copy, nonatomic) NSString *shopName;
//渠道来源 1.1688, 2.鲸灵, 3行云货仓
@property (copy, nonatomic) NSString *sourceType;
//凑整减免
@property (copy, nonatomic) NSString *totalMoneyFavourSub;
//总标价
@property (copy, nonatomic) NSString *totalMoneyMark;
//实际订单金额
@property (assign, nonatomic) float totalMoneyOrder;
//实际支付金额
@property (assign, nonatomic) float totalMoneyPayed;
//总成交价
@property (assign, nonatomic) float totalMoneySale;
//商品总数
@property (copy, nonatomic) NSString *totalQuantity;

@end

NS_ASSUME_NONNULL_END
