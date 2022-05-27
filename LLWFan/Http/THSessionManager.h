//
//  THSessionManager.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/10.
//

#import "AFHTTPSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface THSessionManager : AFHTTPSessionManager

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(nullable NSDictionary *)parameters headers:(nullable NSDictionary <NSString *, NSString *> *)headers progress:(nullable void (^)(NSProgress *))downloadProgress success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure retryCount:(NSInteger)retryCount retryInterval:(NSTimeInterval)retryInterval progressive:(bool)progressive fatalStatusCodes:(NSArray<NSNumber *> *)fatalStatusCodes;


- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(nullable NSDictionary *)parameters headers:(nullable NSDictionary <NSString *, NSString *> *)headers progress:(nullable void (^)(NSProgress *))downloadProgress success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure retryCount:(NSInteger)retryCount retryInterval:(NSTimeInterval)retryInterval progressive:(bool)progressive fatalStatusCodes:(NSArray<NSNumber *> *)fatalStatusCodes;

@end

NS_ASSUME_NONNULL_END
