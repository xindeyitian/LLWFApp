//
//  ProductDetailBottomView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailBottomView : THBaseView

@property (strong, nonatomic) ProductDetailModel *model;
@property (strong, nonatomic) GoodsSkuVosModel   *chosedSkuModel;

@end

NS_ASSUME_NONNULL_END
