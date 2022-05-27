//
//  AddressTopCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnAddressModelBlock)(AddressModel *model);

@interface AddressTopCell : ThBaseTableViewCell

- (void)setCellWithAddressArr:(NSArray *)arr;

@property (copy, nonatomic) returnAddressModelBlock returnAddressModelBlock;

@end

NS_ASSUME_NONNULL_END
