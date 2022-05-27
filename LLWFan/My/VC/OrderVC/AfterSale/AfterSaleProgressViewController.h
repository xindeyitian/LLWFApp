//
//  AfterSaleProgressViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/28.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AfterSaleProgressViewController : THBaseViewController

@property (assign, nonatomic) NSInteger type;//0:仅退款 1:退货退款

@property (strong, nonatomic) AfterSaleModel *model;

@end

NS_ASSUME_NONNULL_END
