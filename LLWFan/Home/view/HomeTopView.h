//
//  HomeTopView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/3/29.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol HomeTopViewDelegate <NSObject>

- (void)chooseWhichKongkingType:(NSInteger )type;

@end

@interface HomeTopView : ThBaseTableViewCell

- (void) setCellWithModel:(KongKimModel *)model;

@property (strong, nonatomic) MyLinearLayout   *rootLy;

@property (weak, nonatomic) id<HomeTopViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
