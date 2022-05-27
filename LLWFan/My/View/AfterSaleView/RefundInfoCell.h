//
//  RefundInfoCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnRefundStatue)(NSString *shouhuoType, NSString *resion);

@interface RefundInfoCell : ThBaseTableViewCell

//0:仅退款 1:退货退款
- (void)setCellWithType:(NSInteger )refundType AndItemModel:(OrderItemModel *)model;

@property (copy, nonatomic) returnRefundStatue returnRefundStatue;

@end

NS_ASSUME_NONNULL_END
