//
//  ChooseAfterSaleTypeController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ChooseAfterSaleTypeController : THBaseViewController

@property (assign, nonatomic) NSInteger type;

@property (strong, nonatomic) OrderItemModel *model;

@end

NS_ASSUME_NONNULL_END
