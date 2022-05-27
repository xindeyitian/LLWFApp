//
//  MarketOrderViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MarketOrderViewController : THBaseViewController<JXCategoryListContentViewDelegate>

@property (assign, nonatomic) NSInteger orderType;

@end

NS_ASSUME_NONNULL_END
