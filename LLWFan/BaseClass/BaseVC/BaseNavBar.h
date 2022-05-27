//
//  BaseNavBar.h
//  SeaEgret
//
//  Created by MAC on 2021/3/23.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol BaseNavBarDelegate <NSObject>

- (void)searchText:(NSString *)text;

@end

@interface BaseNavBar : THBaseView

@property (weak, nonatomic) id<BaseNavBarDelegate> delegate;

@property (strong, nonatomic) MyLinearLayout *rootLy;
 
@end

NS_ASSUME_NONNULL_END
