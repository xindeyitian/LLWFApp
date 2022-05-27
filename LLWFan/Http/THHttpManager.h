

#import <Foundation/Foundation.h>
#import "model.h"
#import "THHttpConfig.h"
/*!
 @class
 @abstract 封装网络请求
 */

/// <#Description#>
@interface THHttpManager : NSObject
/**
 登录之外的所有接口  包含userId token 参数的请求 内部已经添加

 @param URLString  路径地址
 @param parameters  公用参数之外的参数
 @param block 数据回传
 */
+ (void)POST:(NSString *)URLString commonParameters:(id)parameters isjson:(BOOL )isJson dataBlock:(void (^)(NSInteger returnCode  , THRequestStatus status , id data))block;

//复杂类型
+ (void)POSTComplexStructure:(NSString *)URLString commonParameters:(id)parameters  block:(void (^)(NSInteger, THRequestStatus, id))block;

/*!
 @method
 @abstract post请求
 @diXTussion post请求
 @param URLString  url
 @param parameters 参数
 @param timeInterval 超时时间
 没有公共参数
 */
+ (void)POST:(NSString *)URLString
  parameters:(id)parameters
withTimeoutInterval:(NSTimeInterval)timeInterval
 isSecret:(BOOL)isSecret
       block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/**
 post请求

 @param URLString 地址
 @param parameters 参数
 @param block 请求回调
 */
+ (void)NoLoginPOST:(NSString *)URLString parameters:(id)parameters sign:(NSString *)sign dataBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/*!
 @method
 @abstract get请求
 @diXTussion get请求
 @param URLString  url
 @param parameters 参数
 */
+ (void)GET:(NSString *)URLString
 parameters:(id)parameters
      block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (NSString *)getWANIPAddress;

+ (void)addressAddWithAddress:(NSString *)address
                  AndAreaCode:(NSString *)areaCode
                  AndAreaName:(NSString *)areaName
                  AndCityCode:(NSString *)cityCode
                  AndCityName:(NSString *)cityName
                 AndIfDefault:(NSInteger )ifDefault
                  AndPhoneNum:(NSString *)phoneNum
              AndProvinceCode:(NSString *)provinceCode
              AndProvinceName:(NSString *)provinceName
                  AndRealName:(NSString *)realName
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)addressDeleteWithAddresswID:(NSString *)addressID
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)addressEditWithAddress:(NSString *)address
                  AndAddressID:(NSString *)addressID
                   AndAreaCode:(NSString *)areaCode
                   AndAreaName:(NSString *)areaName
                   AndCityCode:(NSString *)cityCode
                   AndCityName:(NSString *)cityName
                  AndIfDefault:(NSInteger )ifDefault
                   AndPhoneNum:(NSString *)phoneNum
               AndProvinceCode:(NSString *)provinceCode
               AndProvinceName:(NSString *)provinceName
                   AndRealName:(NSString *)realName
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)addressListWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)addressDefaultWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)userMultipleWithUserID:(NSString *)userID
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,THUserWithDrawModel *model))block;

+ (void)getBlockDefineWithDefineCode:(NSString *)defindCode
                            AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)getBlockGoodsIdsWithBlockId:(NSString *)blockId
                          AndPageNo:(NSString *)pageNo
                        AndPageSize:(NSString *)pageSize
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)queryHomeAndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)getGoodsCategoryWithPid:(NSString *)pid
                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;
+ (void)getAllGoodsCategoryWithPid:(NSString *)pid
                          AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;
+ (void)shopcartListAndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 商品搜索 金刚区商品查询 三级类目查询
/// @param keyword 搜索内容
/// @param pageNum 页码
/// @param pageSize 条数
/// @param productCategoryId 查询类目下面商品列表用的
/// @param shopId 店铺id
/// @param sort 排序方式 0->按相关度；1->按新品；2->按销量；3->价格从低到高；4->价格从高到低
/// @param block block description
+ (void)searchWithKeyword:(NSString *)keyword
               AndPageNum:(NSString *)pageNum
              AndPageSize:(NSString *)pageSize
     AndProductCategoryId:(NSString *)productCategoryId
                AndShopId:(NSString *)shopId
                  AndSort:(NSString *)sort
                 AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 商品详情
/// @param goodsID 商品ID
/// @param goodsType 商品类型：0 普通商品 1：秒杀2：0元 3：魔盒
/// @param shopID 店铺编号
/// @param block block description
+ (void)queryGoodsInfoDetailWithGoodsID:(NSString *)goodsID
                           AndGoodsType:(NSString *)goodsType
                              AndShopID:(NSString *)shopID
                               AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 商品收藏/取消收藏
/// @param goodsID 商品编号
/// @param shopID 店铺编号
/// @param type 1收藏,2取消收藏
/// @param block block description
+ (void)saveGoodsCollectWithGoodsID:(NSString *)goodsID
                          AndShopID:(NSString *)shopID
                  AndCollectionType:(NSInteger )type
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 店铺商品分页列表
/// @param categoryID 分类编号
/// @param keyWord 搜索关键字
/// @param pageNo 页码
/// @param pageSize 每页条数
/// @param shopId 店铺编号
/// @param sortType 排序类型 1价格 ,2销量
/// @param sortWay 排序排序方式1升序,2降序
/// @param block block description
+ (void)queryShopGoodsPageWithCategoryID:(NSString *)categoryID
                              AndKeyWord:(NSString *)keyWord
                               AndPageNo:(NSInteger )pageNo
                             AndPageSize:(NSString *)pageSize
                               AndShopID:(NSString *)shopId
                             AndSortType:(NSString *)sortType
                              AndSortWay:(NSString *)sortWay
                                AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 店铺分类列表
/// @param shopId shopId description
/// @param block block description
+ (void)queryCategoryForShopPageWithShopId:(NSString *)shopId
                                  AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)queryShopInfoDetailWithShopID:(NSString *)shopID
                             AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// /shopcart/changeQuantity
/// @param count （增减的）商品个数
/// @param goodsId 商品ID
/// @param shopId 店铺ID
/// @param sukId skuId
/// @param block block description
+ (void)changeQuantityWithCount:(NSInteger )count
                     AndGoodsID:(NSInteger )goodsId
                      AndShopID:(NSString *)shopId
                       AndSkuID:(NSString *)sukId
                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 添加商品到购物车（从商品详情添加时）
/// @param count 数量
/// @param goodsId 商品ID
/// @param shopId 商铺ID
/// @param skuId skuID
/// @param block block description
+ (void)addWithCount:(NSInteger )count
          AndGoodsId:(NSString *)goodsId
           AndShopId:(NSString *)shopId
            AndSkuId:(NSString *)skuId
            AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;


/// 确认订单，即从购物车结算，或从商品详情中点击立即购买
/// @param model model description
/// @param block block description
+ (void)confirmWithSettleModel:(SettleModel *)model
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 查询用户当前余额
/// @param block block description
+ (void)queryUserBalanceWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 查询用户当前抵用金
/// @param block block description
+ (void)queryUserDeducteWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 更换余额，抵用金选中状态
/// @param balanceSelected 是否选中余额抵扣
/// @param voucherSelected 是否选中抵用金抵扣
/// @param unionOrderId unionOrderId description聚合订单号
/// @param block block description
+ (void)changeBalanceVoucherWithBalanceSelected:(BOOL )balanceSelected
                             AndVoucherSelected:(BOOL )voucherSelected
                                AndUnionOrderId:(NSString *)unionOrderId
                                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 提交订单
/// @param payMethod 支付方式 1支付宝 2微信
/// @param unionOrderId 聚合订单号
/// @param block block description
+ (void)submitOrderWithPayMethod:(NSInteger )payMethod
                 AndUnionOrderId:(NSString *)unionOrderId
                        AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 计算选中商品的统计信息
/// @param skuIds sku数组
/// @param block block description
+ (void)getTotalPayWithSkuIds:(NSArray *)skuIds
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 删除购物车中指定商品
/// @param skuIds sku数组
/// @param block block description
+ (void)deleteItemsWithSkuIds:(NSArray *)skuIds
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 猜你喜欢
/// @param pageNo pageNo description
/// @param pageSize pageSize description
/// @param block block description
+ (void)guessLikeWithPageNo:(NSInteger )pageNo
                AndPageSize:(NSInteger )pageSize
                   AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 查询用户的订单列表
/// @param page 当前页
/// @param orderState 要查询的订单状态 -100全部(默认) 1待支付，2待发货、3待收货
/// @param size 页码
/// @param block block description
+ (void)listPageWithPage:(NSInteger )page
           AndOrderState:(NSInteger )orderState
                 AndSize:(NSInteger)size
                AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 分页查询退款申请列表
/// @param page page description
/// @param size size description
/// @param block block description
+ (void)afterSaleListPageWithPage:(NSInteger )page
                          AndSize:(NSInteger )size
                         AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 查询指定订单详情
/// @param orderId orderId description
/// @param block block description
+ (void)getInfoWithOrderID:(NSString *)orderId
                  AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 用户重新支付制定商铺订单
/// @param orderId orderId description
/// @param block block description
+ (void)rePayOrderWithOrderID:(NSString *)orderId
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 取消订单
/// @param orderId orderId description
/// @param block block description
+ (void)cancelOrderWithOrderID:(NSString *)orderId
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 用户确认收货
/// @param orderId orderId description
/// @param block block description
+ (void)confirmReceivingWithOrderId:(NSString *)orderId
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 用户删除订单
/// @param orderId orderId description
/// @param block block description
+ (void)deleteOrderWithOrderId:(NSString *)orderId
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

///  上传七牛云图片拿到key
/// @param token 调用获取凭证接口拿到凭证
/// @param images 图片数组
/// @param block block description
+ (void)dealDataWithToken:(NSString *)token
                   Images:(NSArray *)images
                 AndTitle:(NSString *)title
                 AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 获取七牛云简单上传凭证
/// @param block block description
+ (void)getUpTokenAndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 申请（退货）退款
/// @param additionalDesc 补充说明
/// @param applyType 申请类型 1仅退款 2退货退款
/// @param backReason 退回原因
/// @param goodsStatus （退货退款时）货物状态: 未收货/已收货
/// @param moneyBackValue 申请退款金额
/// @param orderItemId 选择的itemId
/// @param quantity 退回的数量
/// @param block block description
+ (void)applyBackWithAdditionalDesc:(NSString *)additionalDesc
                       AndApplyType:(NSInteger )applyType
                      AndBackReason:(NSString *)backReason
                     AndGoodsStatus:(NSString *)goodsStatus
                  AndMoneyBackValue:(float )moneyBackValue
                     AndOrderItemId:(NSString *)orderItemId
                        AndQuantity:(NSString *)quantity
                       AndImageList:(NSArray *)imageList
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 查询指定退款申请详情
/// @param applyId applyId description
/// @param block block description
+ (void)getAfterSaleInfoWithApplyId:(NSString *)applyId
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 寄回商品
/// @param applyId 申请id
/// @param expressComp 快递公司名称
/// @param expressNo 快递单号
/// @param block block description
+ (void)sendBackWithApplyId:(NSString *)applyId
             AndExpressComp:(NSString *)expressComp
               AndExpressNo:(NSString *)expressNo
                   AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 店铺收藏
/// @param shopId shopId
/// @param block block description
+ (void)saveShopCollectWithShopId:(NSString *)shopId
                         AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// /shopcart/cleanInvalidGoods
/// @param block block description
+ (void)cleanInvalidGoodsWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 修改头像
/// @param avatar 头像
/// @param block block description
+ (void)changeAvatarWithAvatar:(NSString *)avatar
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// /user/cpi/changeRealName
/// @param realName 昵称
/// @param block block description
+ (void)changeRealNameWithRealName:(NSString *)realName
                          AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// 修改登录密码
/// @param checkCode 短信验证码
/// @param newPwd 新密码
/// @param block block description
+ (void)changePwdWithCheckCode:(NSString *)checkCode
                     AndNewPwd:(NSString *)newPwd
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

/// <#Description#>
/// @param checkCode <#checkCode description#>
/// @param idCard <#idCard description#>
/// @param realName <#realName description#>
/// @param block <#block description#>
+ (void)idCardAuthWithSmsCode:(NSString *)checkCode AndIdCard:(NSString *)idCard AndRealName:(NSString *)realName AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;






@end
