//
//  ProductDetailViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailViewController : THBaseViewController

@property (strong, nonatomic) ProductModel *goods;
@property (copy, nonatomic) NSString *goodsID;

@end

NS_ASSUME_NONNULL_END
