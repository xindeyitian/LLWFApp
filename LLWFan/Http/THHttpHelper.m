//
//  THHttpHelper.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/1/20.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "THHttpHelper.h"
#import "THAPPService.h"
#import "MBProgressHUD.h"
#import "THHttpManager.h"
#import <MJExtension.h>
#import "ZbankGetDeviceTypeTool.h"



@implementation THHttpHelper
/**
 3.2账号密码登录

 @param phone 手机号
 @param passWord 密码
 @param block 回传数据
 */
+ (void)requestLoginWithPhone:(NSString *)phone PassWord:(NSString *)passWord block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block
{

    NSDictionary *dic = @{@"phoneNum":phone,
                          @"passWord":passWord};

    [THHttpManager NoLoginPOST:loginCheckCode parameters:dic sign:NSStringFormat(@"%@_%@",phone,passWord) dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
    }];
}
+ (void)requestLoginWithPhone:(NSString *)phone SmsCode:(NSString *)smsCode block:(void (^)(NSInteger returnCode,THRequestStatus status,THUserModel *user))block{
    
    NSDictionary *dic = @{@"phoneNum":phone,
                          @"checkCode":smsCode};

    [THHttpManager NoLoginPOST:loginCheckCode parameters:dic sign:NSStringFormat(@"%@_%@",smsCode,phone) dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            THUserModel *model = [THUserModel mj_objectWithKeyValues:data];
            
            block(returnCode,status,model);
        }
    }];
}
+ (void)pcaListblock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",pcaList];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [THHttpManager NoLoginPOST:url parameters:parameters sign:@"" dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode,status,data);
    }];
}

+ (void)checkPhoneNumWithPhoneNum:(NSString *)phoneNum
                            block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",checkPhoneNum];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:phoneNum forKey:@"phoneNum"];
    [THHttpManager NoLoginPOST:url parameters:parameters sign:phoneNum dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode,status,data);
    }];
}

+ (void)sendCheckCodeWithPhoneNum:(NSString *)phoneNum
                       AndMsgType:(NSString *)msgType
                            block:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",sendCheckCode];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:msgType forKey:@"msgType"];
    [parameters setObject:@"User" forKey:@"userType"];
    [parameters setObject:phoneNum forKey:@"phoneNum"];
    [THHttpManager NoLoginPOST:url parameters:parameters sign:NSStringFormat(@"%@_%@_%@",msgType,phoneNum,@"User") dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode,status,data);
    }];
}

+ (void)registerWithAreaCode:(NSString *)areaCode
                  AndSmsCode:(NSString *)smsCode
                 AndCityCode:(NSString *)cityCode
            AndCommunityCode:(NSString *)communityCode
               AndInviteCode:(NSString *)inviteCode
                 AndPassword:(NSString *)password
                 AndPhoneNum:(NSString *)phoneNum
             AndprovinceCode:(NSString *)provinceCode
                       block:(void(^)(NSInteger returnCode,THRequestStatus status,THUserModel *model))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",register];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:areaCode forKey:@"areaCode"];
    [parameters setObject:smsCode forKey:@"checkCode"];
    [parameters setObject:cityCode forKey:@"cityCode"];
    [parameters setObject:communityCode forKey:@"communityCode"];
    [parameters setObject:inviteCode forKey:@"inviteUserID"];
    [parameters setObject:password forKey:@"password"];
    [parameters setObject:phoneNum forKey:@"phoneNum"];
    [parameters setObject:provinceCode forKey:@"provinceCode"];
    
    NSString *sign = NSStringFormat(@"%@_%@_%@_%@_%@_%@_%@_%@",areaCode,smsCode,cityCode,communityCode,inviteCode.length?inviteCode:@"-1",password,phoneNum,provinceCode);

    [THHttpManager NoLoginPOST:url parameters:parameters sign:sign dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        THUserModel *model = [THUserModel mj_objectWithKeyValues:data];
        block(returnCode,status,model);
    }];
}

+ (void)loginOpenKeyWithOpenKey:(NSString *)openKey
                    AndPhoneNum:(NSString *)phoneNum
                       AndBlock:(void(^)(NSInteger returnCode,THRequestStatus status,id data))block{
    
    NSString *url = [NSString stringWithFormat:@"%@",loginOpenKey];
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setObject:openKey forKey:@"openKey"];
    [parameters setObject:phoneNum forKey:@"phoneNum"];
    [THHttpManager NoLoginPOST:url parameters:parameters sign:NSStringFormat(@"%@_%@",openKey,phoneNum) dataBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        block(returnCode,status,data);
    }];
}
@end
