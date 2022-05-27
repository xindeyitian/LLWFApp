//
//  ShopCarCollectionViewCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShopCarCollectionViewCell : UICollectionViewCell

- (void)setItemWithProductModel:(ProductModel *)model;

- (void)setItemWithModel:(ShopCarItemModel *)model;

- (void)setItemWithGuessModel:(GoodsListModel *)model;

@end

NS_ASSUME_NONNULL_END
