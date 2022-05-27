//
//  UnionOrderModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/20.
//

#import "UnionOrderModel.h"

@implementation UnionOrderModel
+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"skuIds":[NSString class],
             @"shopOrders":[ShopOrdersModel class],
    };
}
- (float)totalMoneyMark{
    
    return NSStringFormat(@"%.2f",_totalMoneyMark).floatValue;;
}
- (float)totalMoneyOrder{
    
    return NSStringFormat(@"%.2f",_totalMoneyOrder).floatValue;
}
- (float)totalMoneyPayed{
    
    return NSStringFormat(@"%.2f",_totalMoneyPayed).floatValue;
}
- (float)totalMoneySale{
    
    return NSStringFormat(@"%.2f",_totalMoneySale).floatValue;
}
@end

@implementation ShopOrdersModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"shopCartItems":[ShopCarItemModel class]};
}
- (float)totalMoneyOrder{
    
    return NSStringFormat(@"%.2f",_totalMoneyOrder).floatValue;
}
- (float)totalMoneyPayed{
    
    return NSStringFormat(@"%.2f",_totalMoneyPayed).floatValue;
}
- (float)totalMoneySale{
    
    return NSStringFormat(@"%.2f",_totalMoneySale).floatValue;
}
@end
