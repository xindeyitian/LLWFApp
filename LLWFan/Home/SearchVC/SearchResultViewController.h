//
//  SearchResultViewController.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/7.
//

#import "THSearchBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SearchResultViewController : THSearchBaseViewController

@property (strong, nonatomic) NSArray<ProductModel *> *searchResultArr;
@property (copy, nonatomic) NSString *searchText;

@end

NS_ASSUME_NONNULL_END
