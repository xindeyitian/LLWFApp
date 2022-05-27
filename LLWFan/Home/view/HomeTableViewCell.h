//
//  HomeTableViewCell.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HomeTableViewCell : ThBaseTableViewCell

- (void)initCellWithModel:(ProductModel *)model;

- (void)reloadEditingTypeWith:(BOOL )editingType;

@end

NS_ASSUME_NONNULL_END
