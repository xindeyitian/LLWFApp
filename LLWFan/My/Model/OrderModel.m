//
//  OrderModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/24.
//

#import "OrderModel.h"

@implementation OrderModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"itemList":[OrderItemModel class]};
}
@end
@implementation OrderItemModel
- (float)priceMark{
    
    return NSStringFormat(@"%.2f",_priceMark).floatValue;
}
- (float)priceSale{
    
    return NSStringFormat(@"%.2f",_priceSale).floatValue;
}
- (float)moneyPayed{
    
    return NSStringFormat(@"%.2f",_moneyPayed).floatValue;
}
@end
