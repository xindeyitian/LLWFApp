//
//  CollectionBottomCancleView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/25.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol CollectionBottomCancleViewDelegate <NSObject>

- (void)chooseAllItem;

@end

@interface CollectionBottomCancleView : THBaseView

@property (weak, nonatomic) id<CollectionBottomCancleViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame AndViewType:(NSInteger )viewType;

@end

NS_ASSUME_NONNULL_END
