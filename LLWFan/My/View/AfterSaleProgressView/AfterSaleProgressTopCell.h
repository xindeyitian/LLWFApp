//
//  AfterSaleProgressTopCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/1.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    onlyRefund,
    refundAndSalesReturn
} ProgressType;

@interface AfterSaleProgressTopCell : ThBaseTableViewCell

- (void)initCellWithModel:(AfterSaleDetailModel *)model;

@end

NS_ASSUME_NONNULL_END
