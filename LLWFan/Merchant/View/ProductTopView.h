//
//  ProductTopView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol ProductTopViewDelegate <NSObject>

- (void)chooseSortType:(NSInteger )type AndSortWay:(NSInteger )way;

@end

@interface ProductTopView : UICollectionReusableView

@property (weak, nonatomic) id<ProductTopViewDelegate> delegate;

@property (strong, nonatomic) MyLinearLayout    *rootLy;

@property (strong, nonatomic) ShopModel *model;

@end

NS_ASSUME_NONNULL_END
