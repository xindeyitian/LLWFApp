//
//  SettleViewController.h
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "THBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SettleViewController : THBaseViewController

@property (assign, nonatomic) NSInteger activityType;

@property (strong, nonatomic) GoodsSkuVosModel *chosedSkuModel;

@property (strong, nonatomic) ProductDetailModel *detailModel;

//@property (strong, nonatomic) ShopCarItemModel *carModel;
@property (strong, nonatomic) NSArray          *carModelArr;

@property (strong, nonatomic) NSArray          *addressArr;

@end

NS_ASSUME_NONNULL_END
