//
//  AfterSaleDetailModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/25.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AfterSaleDetailModel : NSObject
//退款申请单号
@property (copy, nonatomic) NSString *applyId;
//申请原因
@property (copy, nonatomic) NSString *applyReason;
//退款类型 1：仅退款 2：退货退款
@property (assign, nonatomic) NSInteger applyType;
//受理描述
@property (copy, nonatomic) NSString *dealDesc;
//处理状态（1 等待商家同意、2等待揽件、3等待退款、4待商家确认收货、9退货完成、-1退货失败、-2客户取消、-3商家取消）
@property (assign, nonatomic) NSInteger dealSign;
//受理时间
@property (copy, nonatomic) NSString *dealTime;
//快递公司
@property (copy, nonatomic) NSString *expressComp;
//快递编号
@property (copy, nonatomic) NSString *expressNo;
//商品id
@property (copy, nonatomic) NSString *goodsId;
//商品名称
@property (copy, nonatomic) NSString *goodsName;
//图片地址列表
@property (strong, nonatomic) NSArray *imgUrlList;
//（单个商品）佣金
@property (copy, nonatomic) NSString *moneyAgent;
///退款状态（0无需退款、1 待退款、9 已退款、 -1无法退款）
@property (copy, nonatomic) NSString *moneyBackSign;
//退款时间
@property (copy, nonatomic) NSString *moneyBackTime;
//退款金额
@property (assign, nonatomic) float moneyBackValue;
//订单id
@property (copy, nonatomic) NSString *orderId;
//订单项id
@property (copy, nonatomic) NSString *orderItemId;
//订单编号
@property (copy, nonatomic) NSString *orderNo;
//下单时间
@property (copy, nonatomic) NSString *orderTime;
//付款时间
@property (copy, nonatomic) NSString *payTime;
//发货时间
@property (copy, nonatomic) NSString *postTime;
//（单个商品）销售价
@property (assign, nonatomic) float priceSale;
//申请退货数量
@property (copy, nonatomic) NSString *quantity;
//购买商品总数量
@property (copy, nonatomic) NSString *quantityTotal;
//sku id
@property (copy, nonatomic) NSString *skuId;
//Sku图片地址
@property (copy, nonatomic) NSString *skuImgUrl;
//sku 名称
@property (copy, nonatomic) NSString *skuName;
@end

NS_ASSUME_NONNULL_END
