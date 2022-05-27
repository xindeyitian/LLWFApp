

#import "THHttpManager.h"
//#import <AFNetworking/AFHTTPSessionManager.h>
#import <AdSupport/AdSupport.h>
#import "NSString+SCCommon.h"
#import "SCMessageHelper.h"
#import "NSDictionary+SCCommon.h"
#import "AESCipher.h"
#import <MJExtension.h>
#import "RegistOrForgetViewController.h"
#import "THSessionManager.h"

typedef void(^XTHttpCallBackBlock)(NSInteger code, THRequestStatus status, id data);
@implementation THHttpManager
static NSString *AESKey = @"FA4ECD10BA9DB7CF";

+ (AFHTTPSessionManager *)configManger{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 1.初始化单例类
//    manager.securityPolicy.SSLPinningMode = AFSSLPinningModeCertificate;
    // 2.设置证书模式
//    NSString * cerPath = [[NSBundle mainBundle] pathForResource:@"xxx" ofType:@"cer"];
//    NSData * cerData = [NSData dataWithContentsOfFile:cerPath];
//    manager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:[[NSSet alloc] initWithObjects:cerData, nil]];
//    // 客户端是否信任非法证书
    manager.securityPolicy.allowInvalidCertificates = YES;
    // 是否在证书域字段中验证域名
    [manager.securityPolicy setValidatesDomainName:NO];
    
    manager.requestSerializer.timeoutInterval = THTimeOutInterval;
    
    return  manager;
}
/**
 上传公司logo图片
 
 @param URLString 地址
 @param image 图片
 @param parameters 参数
 @param block 回传信息
 */
+ (void)POSTCompanyPic:(NSString *)URLString  Image:(UIImage *)image commonParameters:(id)parameters dataBlock:(void (^)(NSInteger returnCode  , THRequestStatus status , id))block   Progrss:(void (^) (NSProgress * )  )Progress
{
    
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [mutableDic setValue:THUserManagerShareTHUserManager.userModel.userID  forKey:@"userId"];
    [mutableDic setValue:THUserManagerShareTHUserManager.userModel.token  forKey:@"token"];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //默认的类型
    //    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 60;
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",THAppBaseURL,URLString];
    
    
    NSString *fileName = [NSString stringWithFormat:@"%@.png", [NSString getUuid]];
    
    NSData *data;
    if (UIImagePNGRepresentation(image) == nil) {
        
        data = UIImageJPEGRepresentation(image, 1.0);
    } else {
        data = UIImagePNGRepresentation(image);
    }
    
    [manager POST:UrlString parameters:mutableDic headers:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        // 上传文件
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        if (Progress) {
            Progress(uploadProgress);
        }
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self responseSuccess:responseObject block:block];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self responseError:error block:block];
        
    }];
}
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
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",addressAdd];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:address forKey:@"address"];
    [parameters setObject:areaCode forKey:@"areaCode"];
    [parameters setObject:areaName forKey:@"areaName"];
    [parameters setObject:cityCode forKey:@"cityCode"];
    [parameters setObject:cityName forKey:@"cityName"];
    [parameters setObject:@(ifDefault) forKey:@"ifDefault"];
    [parameters setObject:phoneNum forKey:@"phoneNum"];
    [parameters setObject:provinceCode forKey:@"provinceCode"];
    [parameters setObject:provinceName forKey:@"provinceName"];
    [parameters setObject:realName forKey:@"realName"];

    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        block(returnCode, status, data);
    }];
}

+ (void)addressDeleteWithAddresswID:(NSString *)addressID
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",addressDelete];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:addressID forKey:@"addressID"];

    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        block(returnCode, status, data);
    }];
}

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
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",addressEdit];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:address forKey:@"address"];
    [parameters setObject:addressID forKey:@"addressID"];
    [parameters setObject:areaCode forKey:@"areaCode"];
    [parameters setObject:areaName forKey:@"areaName"];
    [parameters setObject:cityCode forKey:@"cityCode"];
    [parameters setObject:cityName forKey:@"cityName"];
    [parameters setObject:@(ifDefault) forKey:@"ifDefault"];
    [parameters setObject:phoneNum forKey:@"phoneNum"];
    [parameters setObject:provinceCode forKey:@"provinceCode"];
    [parameters setObject:provinceName forKey:@"provinceName"];
    [parameters setObject:realName forKey:@"realName"];

    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        block(returnCode, status, data);
    }];
}

+ (void)addressListWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",addressList];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        block(returnCode, status, data);
    }];
}
+ (void)addressDefaultWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",addressList];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        block(returnCode, status, data);
    }];
}
+ (void)userMultipleWithUserID:(NSString *)userID AndBlock:(void (^)(NSInteger, THRequestStatus, THUserWithDrawModel *))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",userMultiple];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:userID forKey:@"userID"];

    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        THUserWithDrawModel *model = [THUserWithDrawModel mj_objectWithKeyValues:data];
        block(returnCode, status, model);
    }];
}
+ (void)getBlockDefineWithDefineCode:(NSString *)defindCode
                            AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getBlockDefine];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)getBlockGoodsIdsWithBlockId:(NSString *)blockId
                          AndPageNo:(NSString *)pageNo
                        AndPageSize:(NSString *)pageSize
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getBlockGoodsIds];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:blockId forKey:@"blockId"];
    [parameters setObject:pageNo forKey:@"pageNo"];
    [parameters setObject:pageSize forKey:@"pageSize"];
    
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)queryHomeAndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",queryHome];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)getGoodsCategoryWithPid:(NSString *)pid
                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getGoodsCategory];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:pid forKey:@"pid"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)getAllGoodsCategoryWithPid:(NSString *)pid
                          AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getAllGoodsCategory];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:pid forKey:@"pid"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)shopcartListAndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",shopcartList];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)searchWithKeyword:(NSString *)keyword
               AndPageNum:(NSString *)pageNum
              AndPageSize:(NSString *)pageSize
     AndProductCategoryId:(NSString *)productCategoryId
                AndShopId:(NSString *)shopId
                  AndSort:(NSString *)sort
                 AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",search];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    if (keyword.length) {
        
        [parameters setObject:keyword forKey:@"keyword"];
    }
    [parameters setObject:pageNum forKey:@"pageNum"];
    [parameters setObject:pageSize forKey:@"pageSize"];
    [parameters setObject:productCategoryId forKey:@"productCategoryId"];
    [parameters setObject:shopId forKey:@"shopId"];
    [parameters setObject:sort forKey:@"sort"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)queryGoodsInfoDetailWithGoodsID:(NSString *)goodsID
                           AndGoodsType:(NSString *)goodsType
                              AndShopID:(NSString *)shopID
                               AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",queryGoodsInfoDetail];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:goodsID forKey:@"goodsId"];
    [parameters setObject:goodsType forKey:@"goodsType"];
    [parameters setObject:shopID forKey:@"shopId"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)saveGoodsCollectWithGoodsID:(NSString *)goodsID
                          AndShopID:(NSString *)shopID
                  AndCollectionType:(NSInteger )type
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",saveGoodsCollect];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:goodsID forKey:@"goodsID"];
    [parameters setObject:shopID forKey:@"shopID"];
//    [parameters setObject:@"1519277462561751040" forKey:@"goodsId"];
//    [parameters setObject:@"1511917338507608061" forKey:@"shopId"];
    [parameters setObject:@(type) forKey:@"type"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)queryShopGoodsPageWithCategoryID:(NSString *)categoryID
                              AndKeyWord:(NSString *)keyWord
                               AndPageNo:(NSInteger )pageNo
                             AndPageSize:(NSString *)pageSize
                               AndShopID:(NSString *)shopId
                             AndSortType:(NSString *)sortType
                              AndSortWay:(NSString *)sortWay
                                AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",queryShopGoodsPage];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:categoryID forKey:@"categoryId"];
    [parameters setObject:keyWord forKey:@"keyWord"];
    [parameters setObject:@(pageNo) forKey:@"pageNo"];
    [parameters setObject:pageSize forKey:@"pageSize"];
    [parameters setObject:shopId forKey:@"shopId"];
    [parameters setObject:keyWord forKey:@"keyWord"];
    [parameters setObject:sortType forKey:@"sortType"];
    [parameters setObject:sortWay forKey:@"sortWay"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)queryCategoryForShopPageWithShopId:(NSString *)shopId
                                  AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",queryCategoryForShopPage];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:shopId forKey:@"shopId"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)queryShopInfoDetailWithShopID:(NSString *)shopID
                             AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",queryShopInfoDetail];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:shopID forKey:@"shopId"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)changeQuantityWithCount:(NSInteger )count
                     AndGoodsID:(NSInteger )goodsId
                      AndShopID:(NSString *)shopId
                       AndSkuID:(NSString *)sukId
                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",changeQuantity];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(count) forKey:@"quantity"];
    [parameters setObject:@(goodsId) forKey:@"goodsId"];
    [parameters setObject:shopId forKey:@"shopId"];
    [parameters setObject:sukId forKey:@"skuId"];
//    [parameters setObject:@"1519281847211655170" forKey:@"goodsId"];
//    [parameters setObject:@"1524639752324644864" forKey:@"shopId"];
//    [parameters setObject:@"1518204854974021637" forKey:@"skuId"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)addWithCount:(NSInteger )count
          AndGoodsId:(NSString *)goodsId
           AndShopId:(NSString *)shopId
            AndSkuId:(NSString *)skuId
            AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",addCar];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(count) forKey:@"count"];
    [parameters setObject:goodsId forKey:@"goodsId"];
    [parameters setObject:shopId forKey:@"shopId"];
    [parameters setObject:skuId forKey:@"skuId"];
    [parameters setObject:THUserManagerShareTHUserManager.userModel.userID forKey:@"agentUserId"];
//    [parameters setObject:@"1519281847211655170" forKey:@"goodsId"];
//    [parameters setObject:@"1524639752324644864" forKey:@"shopId"];
//    [parameters setObject:@"1518204854974021637" forKey:@"skuId"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)queryUserBalanceWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",queryUserBalance];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}

+ (void)queryUserDeducteWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",queryUserBalance];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)confirmWithSettleModel:(SettleModel *)model
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",confirm];
    
    NSMutableDictionary *orderItem = [NSMutableDictionary new];
    if (!model.skuIds.count) {
        [orderItem setObject:@(model.orderItem.activityType) forKey:@"activityType"];
        if (model.orderItem.agentShopId) {
            
            [orderItem setObject:model.orderItem.agentShopId forKey:@"agentShopId"];
        }
        if (model.orderItem.agentUserId) {
            
            [orderItem setObject:model.orderItem.agentUserId forKey:@"agentUserId"];
        }
        [orderItem setObject:model.orderItem.factoryId forKey:@"factoryId"];
        [orderItem setObject:model.orderItem.goodsId forKey:@"goodsId"];
        [orderItem setObject:model.orderItem.isOnline ? model.orderItem.isOnline:@""  forKey:@"isOnline"];
        [orderItem setObject:model.orderItem.periodShopId? model.orderItem.periodShopId:@"" forKey:@"periodShopId"];
        [orderItem setObject:model.orderItem.quantity forKey:@"quantity"];
        [orderItem setObject:model.orderItem.seckillGoodsId ? model.orderItem.seckillGoodsId:@""  forKey:@"seckillGoodsId"];
        [orderItem setObject:model.orderItem.seckillId? model.orderItem.seckillId :@"" forKey:@"seckillId"];
        [orderItem setObject:model.orderItem.shopId forKey:@"shopId"];
        [orderItem setObject:model.orderItem.skuId forKey:@"skuId"];
        [orderItem setObject:@(model.orderItem.sourceType) forKey:@"sourceType"];
    }
    
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:orderItem forKey:@"orderItem"];
    [parameters setObject:model.addrId ? model.addrId:@"" forKey:@"addrId"];
    [parameters setObject:model.from forKey:@"from"];
    [parameters setObject:model.skuIds.count ? model.skuIds :@[] forKey:@"skuIds"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)changeBalanceVoucherWithBalanceSelected:(BOOL )balanceSelected
                             AndVoucherSelected:(BOOL )voucherSelected
                                AndUnionOrderId:(NSString *)unionOrderId
                                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",changeBalanceVoucher];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(balanceSelected) forKey:@"balanceSelected"];
    [parameters setObject:@(voucherSelected) forKey:@"voucherSelected"];
    [parameters setObject:unionOrderId forKey:@"unionOrderId"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)submitOrderWithPayMethod:(NSInteger )payMethod
                 AndUnionOrderId:(NSString *)unionOrderId
                        AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",submit];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(payMethod) forKey:@"payMethod"];
    [parameters setObject:unionOrderId forKey:@"unionOrderId"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)getTotalPayWithSkuIds:(NSArray *)skuIds
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getTotalPay];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:skuIds forKey:@"skuIds"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)deleteItemsWithSkuIds:(NSArray *)skuIds
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",deleteItems];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:skuIds forKey:@"skuIds"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)guessLikeWithPageNo:(NSInteger )pageNo
                AndPageSize:(NSInteger )pageSize
                   AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",guessLike];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(pageNo) forKey:@"pageNo"];
    [parameters setObject:@(pageSize) forKey:@"pageSize"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)listPageWithPage:(NSInteger )page
           AndOrderState:(NSInteger )orderState
                 AndSize:(NSInteger)size
                AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",listPage];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(page) forKey:@"current"];
    [parameters setObject:@(orderState) forKey:@"orderState"];
    [parameters setObject:@(size) forKey:@"size"];
    [parameters setObject:THUserManagerShareTHUserManager.userModel.userID forKey:@"userId"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)afterSaleListPageWithPage:(NSInteger )page
                          AndSize:(NSInteger )size
                         AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",afterSaleListPage];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:@(page) forKey:@"current"];
    [parameters setObject:@(size) forKey:@"size"];
    [parameters setObject:THUserManagerShareTHUserManager.userModel.userID forKey:@"userId"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)getInfoWithOrderID:(NSString *)orderId
                  AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getInfo];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:orderId forKey:@"orderId"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)rePayOrderWithOrderID:(NSString *)orderId
                     AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",rePayOrder];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:orderId forKey:@"orderId"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)cancelOrderWithOrderID:(NSString *)orderId
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",cancelOrder];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:orderId forKey:@"orderId"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)confirmReceivingWithOrderId:(NSString *)orderId
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",confirmReceiving];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:orderId forKey:@"orderId"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)deleteOrderWithOrderId:(NSString *)orderId
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",deleteOrder];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:orderId forKey:@"orderId"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)getUpTokenAndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getUpToken];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)dealDataWithToken:(NSString *)token
                   Images:(NSArray *)images
                 AndTitle:(NSString *)title
                 AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    queue.maxConcurrentOperationCount = images.count;

    NSMutableArray *callBackNames = [NSMutableArray array];
    int i = 0;
    for (UIImage *image in images) {
        if (image) {
            NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{

                NSMutableDictionary *imgItem = [NSMutableDictionary dictionary];
                NSString *imageName = [NSString stringWithFormat:@"%@/%@/%d",title,[DHCCToolsMethod getCurrentDate],i];
                NSData *data;
                if (UIImagePNGRepresentation(image) == nil){
                    data = UIImageJPEGRepresentation(image, 1.0);
                    imageName = [imageName stringByAppendingString:[NSUUID UUID].UUIDString];
                }else{
                    data = UIImagePNGRepresentation(image);
                    imageName = [imageName stringByAppendingString:[NSUUID UUID].UUIDString];
                }
                [imgItem setObject:imageName forKey:@"objectKey"];
                [imgItem setObject:@"llwf2" forKey:@"bucket"];
                [callBackNames addObject:imgItem];

                QNConfiguration *config = [QNConfiguration build:^(QNConfigurationBuilder *builder) {
//                    builder.zone = [QNFixedZone zone0];
                }];
                QNUploadManager *upManager = [[QNUploadManager alloc] initWithConfiguration:config];
                [upManager putData:data key:imageName token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {

                    if(info.ok){
                        NSLog(@"请求成功");
                        if (image == images.lastObject) {
                            NSLog(@"upload object finished!");
                            if (block) {
                                block(200,THRequestStatusOK,callBackNames);
                            }
                        }
                    }else{
                        if (block) {
                            block(201,THRequestStatusError,nil);
                        }
                        NSLog(@"失败");
                        //如果失败，这里可以把info信息上报自己的服务器，便于后面分析上传错误原因
                    }
                } option:nil];
            }];
            if (queue.operations.count != 0) {
                [operation addDependency:queue.operations.lastObject];
            }
            [queue addOperation:operation];
         }
        i++;
    }
}
+ (void)applyBackWithAdditionalDesc:(NSString *)additionalDesc
                       AndApplyType:(NSInteger )applyType
                      AndBackReason:(NSString *)backReason
                     AndGoodsStatus:(NSString *)goodsStatus
                  AndMoneyBackValue:(float )moneyBackValue
                     AndOrderItemId:(NSString *)orderItemId
                        AndQuantity:(NSString *)quantity
                       AndImageList:(NSArray *)imageList
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",applyBack];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:orderItemId forKey:@"orderItemId"];
    [parameters setObject:NSStringFormat(@"%.2f",moneyBackValue) forKey:@"moneyBackValue"];
    [parameters setObject:@(applyType) forKey:@"applyType"];
    [parameters setObject:THUserManagerShareTHUserManager.userModel.userID forKey:@"userId"];
    [parameters setObject:additionalDesc.length?additionalDesc:@"" forKey:@"additionalDesc"];
    [parameters setObject:backReason forKey:@"backReason"];
    [parameters setObject:goodsStatus.length?goodsStatus:@"" forKey:@"goodsStatus"];
    [parameters setObject:quantity forKey:@"quantity"];
    [parameters setObject:imageList forKey:@"imgList"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)getAfterSaleInfoWithApplyId:(NSString *)applyId
                           AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",getAfterSaleInfo];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:applyId forKey:@"applyId"];
    [THHttpManager GET:url parameters:parameters block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)sendBackWithApplyId:(NSString *)applyId
             AndExpressComp:(NSString *)expressComp
               AndExpressNo:(NSString *)expressNo
                   AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",sendBack];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:applyId forKey:@"applyId"];
    [parameters setObject:expressComp forKey:@"expressComp"];
    [parameters setObject:expressNo forKey:@"expressNo"];
    [parameters setObject:THUserManagerShareTHUserManager.userModel.userID forKey:@"userId"];
    [THHttpManager POST:url commonParameters:parameters isjson:YES dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)saveShopCollectWithShopId:(NSString *)shopId
                         AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",saveShopCollect];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:shopId forKey:@"shopId"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)cleanInvalidGoodsWithBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",cleanInvalidGoods];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)changeAvatarWithAvatar:(NSString *)avatar
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",changeAvatar];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:avatar forKey:@"avatar"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)changeRealNameWithRealName:(NSString *)realName
                          AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",changeRealName];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:realName forKey:@"realName"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}
+ (void)changePwdWithCheckCode:(NSString *)checkCode
                     AndNewPwd:(NSString *)newPwd
                      AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",changePwd];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:checkCode forKey:@"checkCode"];
    [parameters setObject:newPwd forKey:@"newPwd"];
    [THHttpManager POST:url commonParameters:parameters isjson:NO dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode, status, data);
    }];
}



























+ (NSString *)getWANIPAddress
{
    NSError *error;
    NSURL *ipURL = [NSURL URLWithString:@"http://pv.sohu.com/cityjson?ie=utf-8"];

    NSMutableString *ip = [NSMutableString stringWithContentsOfURL:ipURL encoding:NSUTF8StringEncoding error:&error];
    //判断返回字符串是否为所需数据
    if ([ip hasPrefix:@"var returnCitySN = "]) {
        //对字符串进行处理，然后进行json解析
        //删除字符串多余字符串
        NSRange range = NSMakeRange(0, 19);
        [ip deleteCharactersInRange:range];
        NSString * nowIp =[ip substringToIndex:ip.length-1];
        //将字符串转换成二进制进行Json解析
        NSData * data = [nowIp dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",dict);
        return dict[@"cip"] ? dict[@"cip"] : @"";
    }
    return @"";
}

+ (void)GET:(NSString *)URLString parameters:(id)parameters block:(void(^)(NSInteger,THRequestStatus,id))block
{

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];

    NSString *UrlString = [NSString stringWithFormat:@"%@%@",THAppBaseURL,URLString];
    
    NSDictionary *dataDic = (NSDictionary *)parameters;
    
    [manager GET:UrlString parameters:dataDic headers:@{@"Authorization":THUserManagerShareTHUserManager.userModel.token} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self responseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [self responseError:error block:block];
    }];
}
+ (void)POST:(NSString *)URLString commonParameters:(id)parameters isjson:(BOOL )isJson dataBlock:(void (^)(NSInteger returnCode  , THRequestStatus status , id data))block
{
    
    NSDictionary *dic = parameters;
    NSMutableDictionary *mutableDic = [NSMutableDictionary dictionaryWithDictionary:dic];
    [self POST:URLString parameters:[NSDictionary dictSorting:mutableDic] isJsonPost:isJson block:^(NSInteger returnCode, THRequestStatus status, id data) {

        if (status == THRequestStatusOK) {


        }

        if (block) {

            block(returnCode,status,data);
        }
    }];
}
+ (void)POST:(NSString *)URLString parameters:(id)parameters isJsonPost:(BOOL )isJson block:(void (^)(NSInteger returnCode, THRequestStatus status, id data))block{
    [self POST:URLString parameters:parameters withTimeoutInterval:THTimeOutInterval  isJsonPost:isJson block:block];
}
+ (void)NoLoginPOST:(NSString *)URLString parameters:(id)parameters sign:(NSString *)sign dataBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = 30;
    
    //生成新的默认s
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //默认的类型
    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",THAppBaseURL,URLString];
    
    NSMutableDictionary *dataDic = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    NSMutableString *fullSignStr = [[NSMutableString alloc] initWithString:NSStringFormat(@"ThTec_yb_iOS@%@#%@",sign,[NSString new].currentTimeStr)];

    [dataDic setObject:(NSString *)fullSignStr.md5Str forKey:@"sign"];
    [dataDic setObject:@"yb_iOS" forKey:@"platCode"];
    [dataDic setObject:[NSString new].currentTimeStr forKey:@"timeStamp"];
    
    [manager POST:UrlString parameters:[NSDictionary dictSorting:dataDic] headers:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        [self responseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSDictionary *erroInfo = error.userInfo;
        NSData *data = [erroInfo valueForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self responseError:error block:block];
    }];
}
+ (void)POST:(NSString *)URLString parameters:(id)parameters withTimeoutInterval:(NSTimeInterval)timeInterval isJsonPost:(BOOL )isJson block:(void (^)(NSInteger returnCode, THRequestStatus status, id data))block
{
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    THSessionManager *manager = [THSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"multipart/form-data",@"text/html", @"image/jpeg",@"image/png",@"application/octet-stream", @"text/json",@"application/json",nil];
    manager.requestSerializer.timeoutInterval = timeInterval;

    if (isJson) {
        
        //生成新的默认
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //默认的类型
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }else{
        
        //生成新的默认
        manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        //默认的类型
        [manager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    }
    
    NSString *UrlString = [NSString stringWithFormat:@"%@%@",THAppBaseURL,URLString];
    
    NSMutableDictionary *dataDic = (NSMutableDictionary *)[[NSMutableDictionary alloc] initWithDictionary:parameters];
    
    NSMutableString *fullSignStr = [[NSMutableString alloc] initWithString:NSStringFormat(@"ThTec_%@",[NSString new].currentTimeStr)];
    
    [dataDic setObject:fullSignStr.md5Str forKey:@"sign"];
    [dataDic setObject:@"yb_iOS" forKey:@"platCode"];
    [dataDic setObject:[NSString new].currentTimeStr forKey:@"timeStamp"];
    [dataDic setObject:THUserManagerShareTHUserManager.userModel.token forKey:@"token"];
    PLog(@"%@",THUserManagerShareTHUserManager.userModel.token);

    [manager POST:[UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:[NSDictionary dictSorting:dataDic] headers:@{@"Authorization":THUserManagerShareTHUserManager.userModel.token} progress:^(NSProgress * _Nonnull uploadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

        [self responseSuccess:responseObject block:block];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSDictionary *erroInfo = error.userInfo;
        NSData *data = [erroInfo valueForKey:@"com.alamofire.serialization.response.error.data"];
        NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self responseError:error block:block];
    }];
    
//    [manager POST:[UrlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] parameters:[NSDictionary dictSorting:dataDic] headers:@{@"Authorization":THUserManagerShareTHUserManager.userModel.token} progress:^(NSProgress * _Nonnull) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            [self responseSuccess:responseObject block:block];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSDictionary *erroInfo = error.userInfo;
//            NSData *data = [erroInfo valueForKey:@"com.alamofire.serialization.response.error.data"];
//            NSString *errorString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//            [self responseError:error block:block];
//        } retryCount:1 retryInterval:30 progressive:YES fatalStatusCodes:@[]];
    
}
+ (void)responseSuccess:(id)responseObject block:(void (^)(NSInteger, THRequestStatus, id))block
{
    THRequestStatus status = THRequestStatusError;
    NSDictionary *res = [ [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding] JSONObject];
    NSInteger code = [[res objectForKey:@"code"] integerValue];
    NSString *msg = [res valueForKey:@"msg"];
    
    if (code == 200) {
       status = THRequestStatusOK;
        
        NSDictionary *dictionary = [NSDictionary new];
        if ([[res allKeys] containsObject:@"data"]) {
            
            dictionary = [res objectForKey:@"data"];
        }else{
            
            dictionary = res;
        }
        PLog(@"%@",dictionary);
        if (block) {
            
             block(code,status,dictionary);
        }
    }else if (code == 502){
        if(msg != nil){
            [[AllNoticePopUtility shareInstance] popViewWithTitle:msg AndType:warning IsHideBg:YES AnddataBlock:nil];
        }
        if (block) {
            
             block(code,status,nil);
        }
    }else if(code == 500){
        if(msg != nil){
            [[AllNoticePopUtility shareInstance] popViewWithTitle:msg AndType:warning IsHideBg:YES AnddataBlock:nil];
        }
        if (block) {
            
             block(code,status,nil);
        }
    }else if(code == 503){
        
        if (block) {
            
             block(code,status,nil);
        }
        RegistOrForgetViewController *vc = [[RegistOrForgetViewController alloc] init];
        vc.modalPresentationStyle = UIModalPresentationFullScreen;
        [[THAPPService shareAppService].currentViewController.navigationController presentViewController:vc animated:YES completion:nil];
    }else{
        if(msg != nil){
            [[AllNoticePopUtility shareInstance] popViewWithTitle:msg AndType:hint IsHideBg:YES AnddataBlock:nil];
        }
        if (block) {
            block(code,status,nil);
        }
    }
}
+ (void)responseError:(NSError *)error block:(void (^)(NSInteger, THRequestStatus, id))block
{
    NSInteger errorCode = 000;//请求错误
    
    if (    [[AFNetworkReachabilityManager sharedManager] isReachable] == NO) {
             errorCode = 998;
            [SCMessageHelper showAutoMessage:@"网络已断开，请检查网络"];
    }else{
        [SCMessageHelper showAutoMessage:@"服务器未连接"];
    }
    
    if (block) {
        block(errorCode,THRequestStatusError,error);
    }
}

@end
