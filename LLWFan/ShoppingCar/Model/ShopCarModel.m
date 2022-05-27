//
//  ShopCarModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/13.
//

#import "ShopCarModel.h"

@implementation ShopCarModel

+ (NSDictionary *)mj_objectClassInArray{
    
    return @{@"cartItems":[ShopCarItemModel class]};
}

@end
