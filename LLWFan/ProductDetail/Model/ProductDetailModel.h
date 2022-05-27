//
//  ProductDetailModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AppraisesModel;
@class RecordsModel;
@class GoodsAttVosModel;
@class AttrValueModel;
@class GoodsImgsModel;
@class GoodsSkuVosModel;
@class ShopInfoGoodsVoModel;
@class GoodsInfosModel;

@interface ProductDetailModel : NSObject
//商品评价列表
@property (strong, nonatomic) AppraisesModel *appraisesListVoPage;
//贡献值
@property (copy, nonatomic) NSString *contributionValue;
//商品类别id
@property (copy, nonatomic) NSString *categoryId;
//商品详情图
@property (copy, nonatomic) NSString *descImgs;
//运费模板编号
@property (copy, nonatomic) NSString *expressFeeRuleId;
//规格属性
@property (strong, nonatomic) NSArray<GoodsAttVosModel *> *goodsAttVos;
//商品编号
@property (copy, nonatomic) NSString *goodsId;
//商品图片
@property (strong, nonatomic) GoodsImgsModel *goodsImgs;
//商品名称
@property (copy, nonatomic) NSString *goodsName;
//商品Sku
@property (strong, nonatomic) NSArray<GoodsSkuVosModel *> *goodsSkuVos;
//是否收藏该商品 1已收藏 , 0未收藏
@property (assign, nonatomic) NSInteger ifCollect;
//市场价格
@property (assign, nonatomic) float marketPrice;
//销量数量
@property (copy, nonatomic) NSString *saleCount;
//销售价格
@property (assign, nonatomic) float salePrice;
//店铺编号
@property (copy, nonatomic) NSString *shopId;
//店铺详情广告返参
@property (strong, nonatomic) ShopInfoGoodsVoModel *shopInfoGoodsVo;
//渠道来源0平台 1 .1688,2.鲸灵,3行云货仓 默认0
@property (assign, nonatomic) NSInteger sourceType;
//供货商id
@property (copy, nonatomic) NSString *supplyId;
//商品视频
@property (copy, nonatomic) NSString *videoUrl;
//分享赚
@property (assign, nonatomic) float commission;

@end

@interface AppraisesModel : NSObject

@property (copy, nonatomic) NSString *countId;
@property (copy, nonatomic) NSString *current;
@property (copy, nonatomic) NSString *hitCount;
@property (copy, nonatomic) NSString *maxLimit;
@property (copy, nonatomic) NSString *optimizeCountSql;
@property (copy, nonatomic) NSString *pages;
@property (copy, nonatomic) NSString *searchCount;
@property (copy, nonatomic) NSString *size;
@property (copy, nonatomic) NSString *total;
@property (strong, nonatomic) NSArray<RecordsModel *> *records;

@end

@interface RecordsModel : NSObject
//评价编号
@property (copy, nonatomic) NSString *appraisesId;
//评价用户头像
@property (copy, nonatomic) NSString *avatar;
//点评内容
@property (copy, nonatomic) NSString *content;
//评价时间
@property (copy, nonatomic) NSString *createTime;
//商品评分
@property (copy, nonatomic) NSString *goodsScore;
//sku名称
@property (copy, nonatomic) NSString *goodsSkuName;
//图片
@property (copy, nonatomic) NSString *images;
//评价用户名称
@property (copy, nonatomic) NSString *nickName;
//评价用户编号
@property (copy, nonatomic) NSString *userId;

@end

@interface GoodsAttVosModel : NSObject

@property (copy, nonatomic) NSString *attrName;
@property (strong, nonatomic) NSArray<AttrValueModel *> *attrValue;

@end

@interface AttrValueModel : NSObject

@property (copy, nonatomic) NSString *attrValueId;
@property (copy, nonatomic) NSString *attrValueName;

@end
@interface GoodsImgsModel : NSObject

@property (strong, nonatomic) NSArray *images;

@end
@interface GoodsSkuVosModel : NSObject
//活动结束时间
@property (copy, nonatomic) NSString *activityEndTime;
//活动销售原价，非0才生效
@property (copy, nonatomic) NSString *activityMarketPrice;
//活动销售单价，非0才生效
@property (copy, nonatomic) NSString *activitySalePrice;
//活动开始时间
@property (copy, nonatomic) NSString *activityStartTime;
//贡献值
@property (copy, nonatomic) NSString *contributionValue;
//成本价=供应商给平台的价格
@property (copy, nonatomic) NSString *costPrice;
//货号
@property (copy, nonatomic) NSString *goodsNo;
//市场价=被删除的销售标价
@property (assign, nonatomic) float marketPrice;
//平台价=对外开放的价格
@property (assign, nonatomic) float platPrice;
//销售价=实际成交单价
@property (assign, nonatomic) float salePrice;
//sku编号
@property (copy, nonatomic) NSString *skuId;
//sku图片
@property (copy, nonatomic) NSString *skuImgUrl;
//多维度规格组合名称，比较长
@property (copy, nonatomic) NSString *skuName;
//规格详情
@property (copy, nonatomic) NSString *skuValues;
//原始skuID
@property (copy, nonatomic) NSString *srcSkuId;
//在售数量=库存数量
@property (copy, nonatomic) NSString *stockQuantity;
//单重（克）
@property (copy, nonatomic) NSString *unitWeight;
//专属价=会员价，可能区分多个，非0才生效
@property (assign, nonatomic) float vipPrice;
//选择sku时自己赋值使用
@property (copy, nonatomic) NSString *num;
//分享赚
@property (assign, nonatomic) float commission;

@end

@interface ShopInfoGoodsVoModel : NSObject
//收藏数量
@property (copy, nonatomic) NSString *collectCount;
//店铺商品信息
@property (strong, nonatomic) NSArray<GoodsInfosModel *> *goodsInfos;
//店铺logo头像
@property (copy, nonatomic) NSString *logoImgUrl;
//店铺编号
@property (copy, nonatomic) NSString *shopId;
//店铺名称
@property (copy, nonatomic) NSString *shopName;
//店铺星级
@property (copy, nonatomic) NSString *shopStars;

@end

@interface GoodsInfosModel : NSObject
//拉黑理由
@property (copy, nonatomic) NSString *blackDesc;
//删除人ID: u_123
@property (copy, nonatomic) NSString *cancelUkey;
//平台的类别ID
@property (copy, nonatomic) NSString *categoryId;
//创建时间
@property (copy, nonatomic) NSString *createTime;
//删除状态，默认0
@property (copy, nonatomic) NSString *deleteSign;
//详情图列表
@property (copy, nonatomic) NSString *descImgs;
//商品id
@property (copy, nonatomic) NSString *djlsh;
//非包邮地区
@property (copy, nonatomic) NSString *excludeAreas;
//运费规则ID
@property (copy, nonatomic) NSString *expressFeeRuleId;
//帮卖佣金比例 默认0
@property (copy, nonatomic) NSString *feeRate;
//轮播图列表
@property (copy, nonatomic) NSString *goodsImgs;
//商品名称，有些名称很长
@property (copy, nonatomic) NSString *goodsName;
//商品缩略图
@property (copy, nonatomic) NSString *goodsThumb;
//产品热度
@property (copy, nonatomic) NSString *hotCount;
//是否拉黑，默认0
@property (copy, nonatomic) NSString *ifBlack;
//是否在售(上下架) 默认1
@property (copy, nonatomic) NSString *ifOnSale;
//是否包邮,0不包邮,1包邮并为渠道专享价商品
@property (copy, nonatomic) NSString *ifPostFree;
//是否自营 默认0非自营,1自营
@property (copy, nonatomic) NSString *ifSelf;
//准入状态，默认1 允许前端显示，-1不准入，自营默认0待审核
@property (copy, nonatomic) NSString *ifShow;
//市场价格
@property (assign, nonatomic) float marketPrice;
//最高限购数量
@property (copy, nonatomic) NSString *maxQuantity;
//最低起售量
@property (copy, nonatomic) NSString *minQuantity;
//发货地
@property (copy, nonatomic) NSString *postAddress;
//销售价格
@property (assign, nonatomic) float saleCount;
//已售数量
@property (copy, nonatomic) NSString *salePrice;
//渠道来源0平台 1 .1688,2.鲸灵,3行云货仓 默认0
@property (copy, nonatomic) NSString *sourceType;
//平台的原始商品ID
@property (copy, nonatomic) NSString *srcGoodsId;
//来源的平台ID，对应goods_from表id
@property (copy, nonatomic) NSString *srcPlatId;
//平台的供应商ID
@property (copy, nonatomic) NSString *supplyId;
//产品单位
@property (copy, nonatomic) NSString *unitName;
//更新时间
@property (copy, nonatomic) NSString *updateTime;
//视频地址
@property (copy, nonatomic) NSString *videoUrl;

@end
NS_ASSUME_NONNULL_END
