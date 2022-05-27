//
//  AfterSaleDetailModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/25.
//

#import "AfterSaleDetailModel.h"

@implementation AfterSaleDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"imgUrlList":[NSString class]};
}
- (float)priceSale{
    
    return NSStringFormat(@"%.2f",_priceSale).floatValue;
}
- (float)moneyBackValue{
    
    return NSStringFormat(@"%.2f",_moneyBackValue).floatValue;
}
@end
