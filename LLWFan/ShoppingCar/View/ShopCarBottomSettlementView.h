//
//  ShopCarBottomSettlementView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "THBaseView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    settlement,
    editing,
} SettlementType;

typedef void(^reloadCarListBlock)(NSArray *arr);

typedef void(^reloadDataBlock)(void);

@interface ShopCarBottomSettlementView : THBaseView

- (instancetype)initWithFrame:(CGRect)frame AndType:(SettlementType)type;

- (void)setViewWithModel:(TotalPayModel *)model AndCarList:(NSArray *)arr;

- (void)reset;

@property (assign, nonatomic) SettlementType type;

@property (copy, nonatomic) reloadCarListBlock reloadCarListBlock;

@property (copy, nonatomic) reloadDataBlock reloadDataBlock;

@property (strong, nonatomic) NSArray *carList;

@end

NS_ASSUME_NONNULL_END
