//
//  LLWFPayCell.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^ChooseLLWFPayBlock)(UnionOrderModel *model);

@interface LLWFPayCell : UITableViewCell

@property (copy, nonatomic) ChooseLLWFPayBlock chooseLLWFPayBlock;

- (void)setCellWithModel:(UnionOrderModel *)model;

@end

NS_ASSUME_NONNULL_END
