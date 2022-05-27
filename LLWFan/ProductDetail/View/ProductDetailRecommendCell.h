//
//  ProductDetailRecommendCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailRecommendCell : ThBaseTableViewCell

- (void)setCellWithModel:(ProductDetailModel *)model AndRecommendproductArr:(NSArray *)arr;

@end

NS_ASSUME_NONNULL_END
