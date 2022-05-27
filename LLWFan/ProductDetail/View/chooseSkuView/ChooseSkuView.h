//
//  ChooseSkuView.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/17.
//

#import "THBaseView.h"
@class SkuItem;
@class SkuHeader;
@class SkuNumFooter;

NS_ASSUME_NONNULL_BEGIN

typedef void(^closeBtnClicked)(void);
typedef void(^chosedSku)(GoodsSkuVosModel *model);

@interface ChooseSkuView : THBaseView

- (void)initViewWithProductDetailmodel:(ProductDetailModel *)model;

@property (strong, nonatomic) GoodsSkuVosModel *chosedSkuModel;//后面再研究默认选中的问题

@property (copy, nonatomic) closeBtnClicked closeBlock;

@property (copy, nonatomic) chosedSku succesBlock;

@end


typedef enum : NSUInteger {
    Normal,
    Select,
    Unable,
} itemStatus;
@interface SkuItem : UICollectionViewCell

@property (strong, nonatomic) UILabel *skuLable;
- (void)setItemStatus:(itemStatus) status;

@end



@interface SkuHeader : UICollectionReusableView

@property (strong, nonatomic) UILabel *skuHeaderLable;

@end

typedef void(^chooseSkuCount)(NSString *num);

@interface SkuNumFooter : UICollectionReusableView

@property (copy, nonatomic) chooseSkuCount chooseNumBlock;

@end

NS_ASSUME_NONNULL_END
