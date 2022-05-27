//
//  THHttpHelper.h
//
//  Created by Mac on 2017/1/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "THHttpConfig.h"
#import "THUserModel.h"
@interface THHttpHelper : NSObject


/**
 3.2账号密码登录
 
 @param phone 手机号
 @param passWord 密码
 @param block 回传数据
 */
+ (void)requestLoginWithPhone:(NSString *)phone PassWord:(NSString *)passWord block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block;


/// 验证码登陆
/// @param phone 手机号
/// @param smsCode 验证码
/// @param block 回调
+ (void)requestLoginWithPhone:(NSString *)phone SmsCode:(NSString *)smsCode block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block;

+ (void)pcaListblock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)checkPhoneNumWithPhoneNum:(NSString *)phoneNum
                            block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)sendCheckCodeWithPhoneNum:(NSString *)phoneNum
                       AndMsgType:(NSString *)msgType
                            block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;

+ (void)registerWithAreaCode:(NSString *)areaCode
                  AndSmsCode:(NSString *)smsCode
                 AndCityCode:(NSString *)cityCode
            AndCommunityCode:(NSString *)communityCode
               AndInviteCode:(NSString *)inviteCode
                 AndPassword:(NSString *)password
                 AndPhoneNum:(NSString *)phoneNum
             AndprovinceCode:(NSString *)provinceCode
                       block:(void(^)(NSInteger returnCode,THRequestStatus status,THUserModel *model))block;

+ (void)loginOpenKeyWithOpenKey:(NSString *)openKey
                    AndPhoneNum:(NSString *)phoneNum
                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block;
@end
