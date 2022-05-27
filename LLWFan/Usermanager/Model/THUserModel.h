//
//  THUserModel.h
//  LLWFan
//
//  Created by MAC on 2022/3/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface THUserModel : NSObject<NSCoding,NSSecureCoding>

/**
 住户主键
 */
@property (nonatomic,copy) NSString * userID;
/**
 用户账号（手机号）
 */
@property (nonatomic,copy) NSString * userAccount;
/**
 用户头像
 */
@property (nonatomic,copy) NSString * avatar;
/**
 用户真实姓名
 */
@property (nonatomic,copy) NSString * realName;
/**
 用户token
 */
@property (nonatomic,copy) NSString * token;
/**
 用户openKey
 */
@property (nonatomic,copy) NSString * openkey;
//用户类型（0.粉丝 1.掌柜 2.店主）
@property (nonatomic,copy) NSString * userTypeShow;
/**
 用户类型（0.粉丝 1.掌柜 2.店主）
 */
@property (nonatomic,assign) NSInteger userType;
/**
 
 */
@property (nonatomic,assign) NSInteger ifShowDailyDeducte;
@property (nonatomic,assign) NSInteger ifShowRegContributeLotus;
@property (nonatomic,assign) NSInteger sign;

@end

NS_ASSUME_NONNULL_END
