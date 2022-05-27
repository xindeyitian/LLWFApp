//
//  HomeOtherTopView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/7.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeOtherTopView : UICollectionReusableView

@property (strong, nonatomic) MyLinearLayout *topUtilityLy;
- (void)setViewWithModel:(CategoryModel *)model;

@end

NS_ASSUME_NONNULL_END
