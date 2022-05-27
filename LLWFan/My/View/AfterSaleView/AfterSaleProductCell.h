//
//  AfterSaleProductCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface AfterSaleProductCell : ThBaseTableViewCell

- (void)setCellWithModel:(OrderItemModel *)model;

- (void)setCellWithAfterSaleDetailModel:(AfterSaleDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
