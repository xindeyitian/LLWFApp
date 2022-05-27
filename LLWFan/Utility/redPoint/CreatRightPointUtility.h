//
//  CreatRightPointUtility.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/18.
//

#import <Foundation/Foundation.h>
#import "JSBadgeView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CreatRightPointUtility : NSObject

- (void)creatPointWithParentView:(UIView *)view AndPointPosition:(JSBadgeViewAlignment )position;

- (void)reloadPointWithNum:(NSInteger )num;

@property (assign, nonatomic) NSInteger pointId;
//1、背景色
@property (strong, nonatomic) UIColor *backGroundColor;
//2、没有反光面
@property (strong, nonatomic) UIColor *badgeOverlayColor;
//3、外圈的颜色，默认是白色
@property (strong, nonatomic) UIColor *badgeStrokeColor;

@property (assign, nonatomic) NSInteger badgeText;

@end

NS_ASSUME_NONNULL_END
