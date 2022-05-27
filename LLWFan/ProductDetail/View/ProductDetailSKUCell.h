//
//  ProductDetailSKUCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnSkuBlock)(GoodsSkuVosModel *model);

@interface ProductDetailSKUCell : ThBaseTableViewCell

- (void)setCellWithModel:(ProductDetailModel *)model;

@property (copy, nonatomic) returnSkuBlock returnSkuBlock;

@end

NS_ASSUME_NONNULL_END
