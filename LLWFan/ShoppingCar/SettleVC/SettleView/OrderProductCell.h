//
//  OrderProductCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderProductCell : ThBaseTableViewCell

//- (void)setCellWithSkumodel:(GoodsSkuVosModel *)skuModel AndProductmodel:(ProductDetailModel *)model;
//- (void)setCellWithShopCarItemModel:(NSArray *)carModelArr;
- (void)setCellWithModel:(ShopOrdersModel *)model;

@end

NS_ASSUME_NONNULL_END
