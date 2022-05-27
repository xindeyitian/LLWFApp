//
//  THUserWithDrawModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THUserWithDrawModel : NSObject<NSCoding,NSSecureCoding>
@property (nonatomic, copy) NSString *avatar;
// 余额 2位小数点
@property (nonatomic, assign) long balanceValue;
//总贡献值 2位小数
@property (nonatomic, assign) long contributeValue;
// 总抵用金 5位小数点
@property (nonatomic, assign) long deducteValue;
//预估收益 2位小数
@property (nonatomic, assign) long estimateBalance;
//档案总留莲值 5位小数
@property (nonatomic, assign) long lotusValue;
//待付款订单数
@property (nonatomic, assign) long orderCountWaitPay;
//待收货订单数
@property (nonatomic, assign) long orderCountWaitRecv;
//待发货订单数
@property (nonatomic, assign) long orderCountWaitSend;
//总消费养老金 4位小数
@property (nonatomic, assign) long totalAnnuityMoney;
//累计待拨划养老金 4位小数
@property (nonatomic, assign) long totalAnnuityWithdraw;
//已经在llwf赚了多少钱 === 帮卖抵用金+已到账抵用金
@property (nonatomic, assign) long totalIncome;


@end

NS_ASSUME_NONNULL_END
