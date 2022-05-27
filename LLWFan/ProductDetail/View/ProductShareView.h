//
//  ProductShareView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/3.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^cancleBtnBlock)(void);

@interface ProductShareView : THBaseView

@property (strong, nonatomic) MyLinearLayout *rootLy;

@property (copy, nonatomic) cancleBtnBlock cancleCilcked;

@property (strong, nonatomic) ProductDetailModel *model;

@end

NS_ASSUME_NONNULL_END
