//
//  OrderTableViewCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/13.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderTableViewCell : ThBaseTableViewCell

- (void)setCellWithModel:(OrderItemModel *)model;
- (void)setCellWithAfterSaleModel:(AfterSaleModel *)model;

@end

NS_ASSUME_NONNULL_END
