//
//  THHttpConfig_h.h
//
//  Created by Mac on 2017/1/24.
//  Copyright © 2017年 Mac. All rights reserved.
//

#ifndef THHttpConfig_h
#define THHttpConfig_h

//正式
//#define THAppBaseURL          @"http://192.168.1.252:8080"//陈总
#define THAppBaseURL          @"http://192.168.1.104:8080"//刚哥

//#define XTAppBaseURL          @"http://com.sea.hailukuajing.cn"//测试服

#define imgurl                @"http://static.hailukuajing.cn"
//宏定义封装一下

#define THToken               [THAPPService shareAppService].token
#define THAppVersion          @"4.3"
#define THIOS                 @"iOS"
#define THCHANNELNUM          @"AppStore"
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

#pragma mark - ——————— 支付状态 ————————
// 微信
#define LNotification_WXChatPaySuccess @"LNotification_WXChatPaySuccess"
#define LNotification_WXChatPayFailed @"LNotification_WXChatPayFailed"
// 支付宝
#define LNotification_AliPaySuccess @"LNotification_AliPaySuccess"
#define LNotification_AliPayFailed @"LNotification_AliPayFailed"

#define UMShareKey @"6169135314e22b6a4f23635c"

#define THTimeOutInterval     30

typedef enum {
    
   THRequestStatusOK =   0,
   THRequestStatusError = 1
 
}THRequestStatus;

#define pcaList @"/user/chinaCity/cpi/pcaList"
#define loginPwd @"/user/cpi/loginPwd"
#define sendCheckCode @"/user/msgCode/cpi/sendCheckCode"
#define loginOpenKey @"/user/user/cpi/loginOpenKey"
#define loginCheckCode @"/user/user/cpi/loginCheckCode"
#define checkPhoneNum @"/user/user/cpi/checkPhoneNum"
#define register @"/user/user/cpi/register"
#define userInviteCode @"​/user​/cpi​/userInviteCode"
#define queryCouponTypePage @"/goods/couponInfo/queryCouponTypePage"//优惠券
#define userMultiple @"/user/user/cpi/userMultiple"
#define addressAdd @"/user/userAddress/cpi/addressAdd"//添加收货地址
#define addressDelete @"/user/userAddress/cpi/addressDelete"//删除收货地址
#define addressEdit @"/user/userAddress/cpi/addressEdit"//编辑收货地址
#define addressItem @"/user/userAddress/cpi/addressItem"//收货地址详情
#define addressList @"/user/userAddress/cpi/addressList"//收货地址列表
#define addressDefault @"/user/userAddress/cpi/addressDefault"///userAddress/cpi/addressDefault
#define getBlockDefine @"/goods/mallBlockDefine/getBlockDefine"//查询金刚区
#define getBlockGoodsIds @"/goods/mallBlockDefine/getBlockGoodsIds"//查询金刚区ID对应内容
#define queryHome @"/goods/goodsInfo/queryHome"//查询首页类别
#define queryGoodsInfoDetail @"/goods/goodsInfo/queryGoodsInfoDetail"//查询商品详情
#define getGoodsCategory @"/goods/category/homeList"//查询当前
#define getAllGoodsCategory @"/goods/category/getGoodsCategory"//查询所有类别
#define shopcartList @"/order/shopcart/list"//查询购物车列表
#define search @"/goods/search/search"//商品搜索 金刚区商品查询 三级类目查询
#define saveGoodsCollect @"/goods/goodsInfo/saveGoodsCollect"//商品收藏-取消收藏
#define queryShopGoodsPage @"/goods/shopGoods/queryShopGoodsPage"//店铺商品分页列表
#define queryCategoryForShopPage @"/goods/shopGoods/queryCategoryForShopPage"//店铺分类列表
#define queryShopInfoDetail @"/goods/shop/shopInfo/queryShopInfoDetail"//店铺详情
#define queryNowSeckillModules @"/activity/seckill/queryNowSeckillModules"//查询当天秒杀模块
#define addCar @"/order/shopcart/add"//添加商品到购物车（从商品详情添加时）
#define changeQuantity @"/order/shopcart/changeQuantity"//加购物车/新增/减少购物车数量
#define confirm @"/order/order/confirm"//确认订单，即从购物车结算，或从商品详情中点击立即购买
#define queryUserBalance @"/user/sub/queryUserBalance"//查询用户当前余额
#define queryUserDeducte @"/user/sub/queryUserDeducte"//查询用户当前抵用金
#define changeBalanceVoucher @"/order/order/changeBalanceVoucher"//更换余额，抵用金选中状态
#define submit @"/order/order/submit"//提交订单
#define getTotalPay @"/order/shopcart/getTotalPay"//计算选中商品的统计信息
#define deleteItems @"/order/shopcart/deleteItems"//删除购物车中指定商品
#define guessLike @"/goods/goodsInfo/guessLike"//猜你喜欢
#define listPage @"/order/order/listPage"//查询用户的订单列表
#define afterSaleListPage @"/order/afterSale/listPage"//分页查询退款申请列表
#define getInfo @"/order/order/getInfo"//查询指定订单详情
#define rePayOrder @"/order/order/pay"//重新支付订单
#define cancelOrder @"/order/order/cancel"//取消订单
#define confirmReceiving @"/order/order/confirmReceiving"//用户确认收货
#define deleteOrder @"/order/order/delete"//用户删除订单
#define getUpToken @"/file/qiniu/getUpToken"//获取简单上传凭证
#define applyBack @"/order/afterSale/applyBack"//申请（退货）退款
#define getAfterSaleInfo @"/order/afterSale/getInfo"//查询指定退款申请详情
#define sendBack @"/order/afterSale/sendBack"//寄回商品
#define saveShopCollect @"/goods/shop/shopInfo/saveShopCollect"//店铺收藏
#define cleanInvalidGoods @"/order/shopcart/cleanInvalidGoods"//清空购物车所有失效的商品
#define changeAvatar @"/user/user/cpi/changeAvatar"//修改头像
#define changeRealName @"/user/user/cpi/changeRealName"//修改头像
#define changePwd @"/user/user/cpi/changePwd"//修改密码
#define idCardAuth @"/user/user/cpi/idCardAuth"//实名认证



#endif /* THHttpConfig_h */

