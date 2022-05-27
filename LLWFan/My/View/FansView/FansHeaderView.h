//
//  FansHeaderView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol FansHeaderViewDelegate <NSObject>

- (void)chooseWhitchType:(NSInteger )type;

@end

@interface FansHeaderView : UITableViewHeaderFooterView

@property (weak, nonatomic) id<FansHeaderViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
