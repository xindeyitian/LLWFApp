//
//  GuessLikeModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class GoodsListModel;

@interface GuessLikeModel : NSObject

@property (copy, nonatomic) NSString *countId;
@property (copy, nonatomic) NSString *current;
@property (copy, nonatomic) NSString *hitCount;
@property (copy, nonatomic) NSString *maxLimit;
@property (copy, nonatomic) NSString *optimizeCountSql;
@property (copy, nonatomic) NSString *pages;
@property (copy, nonatomic) NSString *searchCount;
@property (copy, nonatomic) NSString *size;
@property (copy, nonatomic) NSString *total;
@property (strong, nonatomic) NSArray *records;

@end

@interface GoodsListModel : NSObject

@property (copy, nonatomic) NSString *contributeValue;
@property (assign, nonatomic) float marketPrice;
@property (copy, nonatomic) NSString *saleCount;
@property (assign, nonatomic) float salePrice;
@property (copy, nonatomic) NSString *shopId;
@property (copy, nonatomic) NSString *goodsId;
@property (copy, nonatomic) NSString *goodsName;
@property (copy, nonatomic) NSString *goodsThumb;
@property (assign, nonatomic) CGFloat height;

@end

NS_ASSUME_NONNULL_END
