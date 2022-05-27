//
//  ShopCarRecommendCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/7.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarRecommendCell : ThBaseTableViewCell

- (void)initCellWithArr:(NSArray<GuessLikeModel *> *)arr;

@end

NS_ASSUME_NONNULL_END
