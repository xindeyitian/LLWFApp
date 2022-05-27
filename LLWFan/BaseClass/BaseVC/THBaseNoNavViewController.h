//
//  THBaseNoNavViewController.h
//  SeaEgret
//
//  Created by MAC on 2021/3/22.
//

#import "THBaseViewController.h"
#import "BaseNavBar.h"

NS_ASSUME_NONNULL_BEGIN

@interface THBaseNoNavViewController : THBaseViewController

@property (strong, nonatomic) BaseNavBar *nav;

@property (assign, nonatomic) NSInteger topHeight;

@end

NS_ASSUME_NONNULL_END
