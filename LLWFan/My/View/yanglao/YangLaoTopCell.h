//
//  YangLaoTopCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/21.
//

#import "ThBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface YangLaoTopCell : ThBaseTableViewCell

@end

@interface YLItemView : THBaseView

- (instancetype)initWithFrame:(CGRect)frame AndLayoutType:(MyGravity )gravity;

@end

NS_ASSUME_NONNULL_END
