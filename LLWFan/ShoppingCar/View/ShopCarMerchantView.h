//
//  ShopCarMerchantView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^reloadCarModelBlock)(ShopCarModel *model);

@interface ShopCarMerchantView : UITableViewHeaderFooterView

- (void)setViewWithModel:(ShopCarModel *)model;

@property (copy, nonatomic) reloadCarModelBlock reloadCarModelBlock;

@end

NS_ASSUME_NONNULL_END
