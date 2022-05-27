//
//  BottomCollectionView.h
//  DynamicHeightView
//
//  Created by heng on 2020/11/13.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BottomCollectionView : UIView

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArr;

@end

NS_ASSUME_NONNULL_END
