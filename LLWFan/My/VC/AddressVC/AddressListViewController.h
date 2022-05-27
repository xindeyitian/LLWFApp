//
//  AddressListViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/15.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
 
typedef void(^chosedAddressBlock)(AddressModel *model);

@interface AddressListViewController : THBaseViewController

@property (copy, nonatomic) chosedAddressBlock chosedAddressBlock;

@end

NS_ASSUME_NONNULL_END
