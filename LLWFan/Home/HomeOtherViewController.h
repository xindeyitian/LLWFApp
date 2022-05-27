//
//  HomeOtherViewController.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeOtherViewController : THBaseViewController<JXCategoryListContentViewDelegate>

@property (strong, nonatomic) CategoryModel *model;

@end

NS_ASSUME_NONNULL_END
