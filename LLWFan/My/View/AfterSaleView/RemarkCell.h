//
//  RemarkCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^returnImageBlock)(NSArray *imageArr);

typedef void(^returnRemarkBlock)(NSString *remark);

@interface RemarkCell : ThBaseTableViewCell

@property (copy, nonatomic) returnImageBlock returnImageBlock;

@property (copy, nonatomic) returnRemarkBlock returnRemarkBlock;

@end

NS_ASSUME_NONNULL_END
