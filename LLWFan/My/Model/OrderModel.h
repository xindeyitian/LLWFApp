//
//  OrderModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class OrderItemModel;

@interface OrderModel : NSObject
//余额的减免金额
@property (copy, nonatomic) NSString *balanceSub;
@property (copy, nonatomic) NSString *contributionValue;
@property (copy, nonatomic) NSString *djlsh;
@property (strong, nonatomic) NSArray *itemList;
@property (copy, nonatomic) NSString *moneyCouponSub;
@property (copy, nonatomic) NSString *moneyPrepay;
@property (copy, nonatomic) NSString *orderNo;
@property (copy, nonatomic) NSString *orderNoUnion;
//订单状态（0上门定制、1待支付默认，2待发货、3待收货，9完成，-1客户取消、-2管理员取消、-3待退货、-4已部分退货、-5已全部退货）
@property (assign, nonatomic) NSInteger orderState;
@property (copy, nonatomic) NSString *orderTime;
@property (copy, nonatomic) NSString *payTime;
@property (copy, nonatomic) NSString *expressFee;
//订单类型 1标准订单、2合同订单、3预支付订单、4三年五年订单、5零元分红计划订单、6社区活动订单、7全球购、9团体定制订单 10秒杀订单
@property (assign, nonatomic) NSInteger orderType;
@property (copy, nonatomic) NSString *shopId;
@property (copy, nonatomic) NSString *shopName;
@property (copy, nonatomic) NSString *totalMoneyAgent;
@property (copy, nonatomic) NSString *totalMoneyFavourSub;
@property (copy, nonatomic) NSString *totalMoneyMark;
@property (copy, nonatomic) NSString *totalMoneyOrder;
@property (copy, nonatomic) NSString *totalMoneyPayed;
@property (assign, nonatomic) float totalMoneysub;
@property (copy, nonatomic) NSString *totalMoneySale;
@property (copy, nonatomic) NSString *totalQuantity;
@property (copy, nonatomic) NSString *updateTime;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *voucherSub;

@property (copy, nonatomic) NSString *deliveryAddress;
//发货时间
@property (copy, nonatomic) NSString *deliveryDate;
@property (copy, nonatomic) NSString *deliveryPhoneNum;
@property (copy, nonatomic) NSString *deliveryRealName;

@end

@interface OrderItemModel : NSObject

@property (copy, nonatomic) NSString *activityId;
@property (copy, nonatomic) NSString *contributionValue;
@property (copy, nonatomic) NSString *discountId;
@property (copy, nonatomic) NSString *djlsh;
@property (copy, nonatomic) NSString *goodsId;
@property (copy, nonatomic) NSString *goodsName;
//实际付款->退款金额
@property (assign, nonatomic) float moneyPayed;
@property (copy, nonatomic) NSString *orderId;
@property (assign, nonatomic) float priceMark;
@property (assign, nonatomic) float priceSale;
@property (copy, nonatomic) NSString *quantityTotal;
@property (copy, nonatomic) NSString *skuId;
@property (copy, nonatomic) NSString *skuImgUrl;
@property (copy, nonatomic) NSString *skuName;

@end

NS_ASSUME_NONNULL_END
