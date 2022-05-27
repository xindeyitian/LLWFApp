//
//  OrderFooterView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OrderFooterView : UITableViewHeaderFooterView

- (void)setFooterWithModel:(OrderModel *)model;

- (void)setFooterWithAfterSaleModel:(AfterSaleModel *)model;

@end

NS_ASSUME_NONNULL_END
