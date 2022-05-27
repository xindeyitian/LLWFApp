//
//  OrderHeaderView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface OrderHeaderView : UITableViewHeaderFooterView

- (void)setHeaderWithModel:(OrderModel *)model;

- (void)setHeaderWithAfterSaleModel:(AfterSaleModel *)model;

@end

NS_ASSUME_NONNULL_END
