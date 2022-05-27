//
//  PayTypeCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnUnionModelBlock)(UnionOrderModel *model);

@interface PayTypeCell : ThBaseTableViewCell

@property (copy, nonatomic) returnUnionModelBlock returnUnionModelBlock;

- (void)setCellWithModel:(UnionOrderModel *)model;

@end

NS_ASSUME_NONNULL_END
