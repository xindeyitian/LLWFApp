//
//  SearchNavBar.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^searchResult)(NSArray *resultArr, NSString *searchText);

@interface SearchNavBar : THBaseView

@property (copy, nonatomic) searchResult searchResuleBlcok;

@end

NS_ASSUME_NONNULL_END
