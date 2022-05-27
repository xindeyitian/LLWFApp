//
//  ShopCarTableViewCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^chooseProductBlock)(ShopCarItemModel *model);
typedef void(^reloadProductBlock)(ShopCarItemModel *model);

@interface ShopCarTableViewCell : UITableViewCell

@property (copy, nonatomic) chooseProductBlock chooseProductBlock;

@property (copy, nonatomic) reloadProductBlock reloadProductBlock;

- (void)setCellWithShopCarModel:(ShopCarItemModel *)model;

@end

NS_ASSUME_NONNULL_END
