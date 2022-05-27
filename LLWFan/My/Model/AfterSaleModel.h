//
//  AfterSaleModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AfterSaleModel : NSObject
//补充描述
@property (copy, nonatomic) NSString *additionalDesc;
//申请时间
@property (copy, nonatomic) NSString *applyTime;
//申请类型 1：仅退款 2：退货退款
@property (assign, nonatomic) NSInteger applyType;
//退货退款原因（7天无理由退货、退换货、大小|尺寸与商品描述不符...）
@property (copy, nonatomic) NSString *backReason;
//余额退回数量
@property (copy, nonatomic) NSString *balanceBack;
//帮卖人ID
@property (copy, nonatomic) NSString *dealAgentId;
//帮卖人姓名
@property (copy, nonatomic) NSString *dealAgentRealName;
//受理描述
@property (copy, nonatomic) NSString *dealDesc;
//处理状态（1 等待商家同意、2等待揽件、3等待退款、9退货完成、-1退货失败、-2客户取消、-3商家取消）
@property (assign, nonatomic) NSInteger dealSign;
//受理时间
@property (copy, nonatomic) NSString *dealTime;
//处理人ID
@property (copy, nonatomic) NSString *dealUserId;
//处理人名称
@property (copy, nonatomic) NSString *dealUserRealName;
//促销折扣ID
@property (copy, nonatomic) NSString *discountId;
//退款申请id
@property (copy, nonatomic) NSString *djlsh;
//快递公司
@property (copy, nonatomic) NSString *expressComp;
//快递单号
@property (copy, nonatomic) NSString *expressNo;
//商品ID
@property (copy, nonatomic) NSString *goodsId;
//商品名称
@property (copy, nonatomic) NSString *goodsName;
//货物状态（我要退款(无需退货；我要退款退货)）
@property (copy, nonatomic) NSString *goodsStatus;
//退款状态（0无需退款、1 待退款、9 已退款、 -1无法退款）
@property (copy, nonatomic) NSString *moneyBackSign;
//退款时间
@property (copy, nonatomic) NSString *moneyBackTime;
//退款金额
@property (copy, nonatomic) NSString *moneyBackValue;
//订单ID
@property (copy, nonatomic) NSString *orderId;
//订单条目ID
@property (copy, nonatomic) NSString *orderItemId;
//手机号码
@property (copy, nonatomic) NSString *phoneNum;
//数量
@property (copy, nonatomic) NSString *quantity;
//店铺ID
@property (copy, nonatomic) NSString *shopId;
//店铺名称
@property (copy, nonatomic) NSString *shopName;
//skuId
@property (copy, nonatomic) NSString *skuId;
//sku图片地址
@property (copy, nonatomic) NSString *skuImgUrl;
//sku名称
@property (copy, nonatomic) NSString *skuName;
//用户ID
@property (copy, nonatomic) NSString *userId;
//抵用金退回数量
@property (copy, nonatomic) NSString *voucherBack;

@end

NS_ASSUME_NONNULL_END
