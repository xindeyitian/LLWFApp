//
//  ProductModel.h
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductModel : NSObject

//购买可得贡献值
@property (copy, nonatomic) NSString *contributeValue;
@property (copy, nonatomic) NSString *djlsh;
@property (copy, nonatomic) NSString *goodsId;
@property (copy, nonatomic) NSString *shopGoodsId;
@property (copy, nonatomic) NSString *shopCategoryId;
@property (copy, nonatomic) NSString *shopId;
@property (copy, nonatomic) NSString *srcPlatId;
@property (copy, nonatomic) NSString *srcGoodsId;
@property (copy, nonatomic) NSString *feeRate;
@property (assign, nonatomic) float salePrice;
@property (assign, nonatomic) float marketPrice;
@property (copy, nonatomic) NSString *supplyId;
@property (copy, nonatomic) NSString *categoryId;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *goodsThumb;
@property (copy, nonatomic) NSString *videoUrl;
@property (copy, nonatomic) NSString *goodsImgs;
@property (copy, nonatomic) NSString *descImgs;
@property (copy, nonatomic) NSString *postAddress;
@property (copy, nonatomic) NSString *ifPostFree;
@property (copy, nonatomic) NSString *excludeAreas;
@property (copy, nonatomic) NSString *maxQuantity;
@property (copy, nonatomic) NSString *minQuantity;
@property (copy, nonatomic) NSString *unitName;
@property (copy, nonatomic) NSString *ifSelf;
@property (copy, nonatomic) NSString *ifShow;
@property (copy, nonatomic) NSString *ifOnSale;
@property (copy, nonatomic) NSString *ifBlack;
@property (copy, nonatomic) NSString *blackDesc;
@property (copy, nonatomic) NSString *saleCount;
@property (copy, nonatomic) NSString *hotCount;
@property (copy, nonatomic) NSString *expressFeeRuleId;
@property (copy, nonatomic) NSString *createTime;
@property (copy, nonatomic) NSString *updateTime;
@property (copy, nonatomic) NSString *deleteSign;
@property (assign, nonatomic) CGFloat height;

@end

NS_ASSUME_NONNULL_END
