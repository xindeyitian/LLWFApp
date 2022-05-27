//
//  THUserManager.h
//  LLWFan
//
//  Created by MAC on 2022/3/21.
//

#import <Foundation/Foundation.h>
#import "THUserModel.h"
#import "THUserWithDrawModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface THUserManager : NSObject

/**
 维护用户模型的工具类

 @return 自己的对象
 */
+ (instancetype)shareTHUserManager;
/**
  归档对象
 
 */
-(void)archiverUserModel:(THUserModel *)userModel;
/**
 解归档对象
 
 @return 自己的对象
 */
-(THUserModel *)unarchiverUserModel:(NSData *)userModelData;

/**
 用户模型
 */
@property (nonatomic,strong) THUserModel* userModel;
/**
  归档收益对象
 
 */
- (void)archiverUserWithDrawModel:(THUserWithDrawModel *)userWithDrawModel;
/**
 解归档收益对象
 
 @return 自己的收益对象
 */
- (THUserWithDrawModel *)unarchiverUserWithDrawModel:(NSData *)userModelData;

/**
 用户收益模型
 */
@property (nonatomic,strong) THUserWithDrawModel *userWithDrawModel;


/**
 清除用户模型的数据 但是保留用户模型的手机号码
 */
+ (void)clearUserModel;

/**
 是否是登录状态

 @return 返回登录状态 YES 登录 NO l未登录
 */
+ (BOOL)isLogin;


/**
 退出登录
 */
+ (void)logOut;


@end

NS_ASSUME_NONNULL_END
