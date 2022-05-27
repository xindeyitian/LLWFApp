//
//  ShopCarModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarModel : NSObject

//商铺id
@property (copy, nonatomic) NSString *shopId;
//商铺name
@property (copy, nonatomic) NSString *shopName;
//哪里的商家 llwf
@property (copy, nonatomic) NSString *groupType;
@property (copy, nonatomic) NSString *factoryId;
@property (copy, nonatomic) NSString *sourceType;
@property (assign, nonatomic) BOOL isSelect;
@property (strong, nonatomic) NSArray<ShopCarItemModel *> *cartItems;

@end

NS_ASSUME_NONNULL_END
