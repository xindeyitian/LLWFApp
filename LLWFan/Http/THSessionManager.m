//
//  THSessionManager.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/10.
//

#import "THSessionManager.h"

NSInteger RETRY_SEMAPHORE = 1;

@implementation THSessionManager

- (nullable NSURLSessionDataTask *)GET:(NSString *)URLString parameters:(nullable NSDictionary *)parameters headers:(nullable NSDictionary <NSString *, NSString *> *)headers progress:(nullable void (^)(NSProgress *))downloadProgress success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure retryCount:(NSInteger)retryCount retryInterval:(NSTimeInterval)retryInterval progressive:(bool)progressive fatalStatusCodes:(NSArray<NSNumber *> *)fatalStatusCodes{
    
    NSURLSessionDataTask *task = [self requestUrlWithRetryRemaining:retryCount maxRetry:retryCount retryInterval:retryInterval progressive:progressive fatalStatusCodes:fatalStatusCodes originalRequestCreator:^NSURLSessionDataTask *(void (^)(NSURLSessionDataTask *, id)) {
        return [self GET:URLString parameters:parameters headers:headers progress:downloadProgress success:success failure:failure];
    } originalSuccess:success];
    return task;
}


- (nullable NSURLSessionDataTask *)POST:(NSString *)URLString parameters:(nullable NSDictionary *)parameters headers:(nullable NSDictionary <NSString *, NSString *> *)headers progress:(nullable void (^)(NSProgress *))downloadProgress success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure retryCount:(NSInteger)retryCount retryInterval:(NSTimeInterval)retryInterval progressive:(bool)progressive fatalStatusCodes:(NSArray<NSNumber *> *)fatalStatusCodes{
    
    NSURLSessionDataTask *task = [self requestUrlWithRetryRemaining:retryCount maxRetry:retryCount retryInterval:retryInterval progressive:progressive fatalStatusCodes:fatalStatusCodes originalRequestCreator:^NSURLSessionDataTask *(void (^)(NSURLSessionDataTask *, id)) {
        return [self POST:URLString parameters:parameters headers:headers progress:downloadProgress success:success failure:failure];
    } originalSuccess:success];
    return task;
}
- (NSURLSessionDataTask *)requestUrlWithRetryRemaining:(NSInteger)retryRemaining maxRetry:(NSInteger)maxRetry retryInterval:(NSTimeInterval)retryInterval progressive:(bool)progressive fatalStatusCodes:(NSArray<NSNumber *> *)fatalStatusCodes originalRequestCreator:(NSURLSessionDataTask *(^)(void (^)(NSURLSessionDataTask *, id)))taskCreator originalSuccess:(void(^)(NSURLSessionDataTask *task, id ))success {
        
    weakSelf(self);
    void(^retryBlock)(NSURLSessionDataTask *,id) = ^(NSURLSessionDataTask *task,id responseObject) {
        
        NSInteger code = [[responseObject objectForKey:@"code"] integerValue];
        /*
         1. 如果401 触发重试，不走success
         2. 并发时，只走一遍刷新接口
         */
        if (code == 401) {
            //401，重试
            @synchronized (self) {
                if (RETRY_SEMAPHORE == 1) {
                    [THHttpHelper loginOpenKeyWithOpenKey:THUserManagerShareTHUserManager.userModel.openkey AndPhoneNum:THUserManagerShareTHUserManager.userModel.userAccount AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                        
                        RETRY_SEMAPHORE = 0;
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            RETRY_SEMAPHORE = 1;
                        });
                        [weakSelf retryRemaining:retryRemaining maxRetry:maxRetry retryInterval:retryInterval progressive:progressive fatalStatusCodes:fatalStatusCodes originalRequestCreator:taskCreator originalSuccess:success];
                    }];
                } else if (RETRY_SEMAPHORE == 0){
                    [weakSelf retryRemaining:retryRemaining maxRetry:maxRetry retryInterval:retryInterval progressive:progressive fatalStatusCodes:fatalStatusCodes originalRequestCreator:taskCreator originalSuccess:success];
                }
            }
        } else {
            if (code == 502) {
                RETRY_SEMAPHORE = -1;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(20 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    RETRY_SEMAPHORE = 1;
                });
            }
        }
        success(task,responseObject);
    };
    NSURLSessionDataTask *task = taskCreator(retryBlock);
    return task;
}
- (void)retryRemaining:(NSInteger)retryRemaining maxRetry:(NSInteger)maxRetry retryInterval:(NSTimeInterval)retryInterval progressive:(bool)progressive fatalStatusCodes:(NSArray<NSNumber *> *)fatalStatusCodes originalRequestCreator:(NSURLSessionDataTask *(^)(void (^)(NSURLSessionDataTask *, id)))taskCreator originalSuccess:(void(^)(NSURLSessionDataTask *task, id ))success {
    if (retryRemaining > 0) {
        void (^addRetryOperation)(void) = ^{
            [self requestUrlWithRetryRemaining:retryRemaining - 1 maxRetry:maxRetry retryInterval:retryInterval progressive:progressive fatalStatusCodes:fatalStatusCodes originalRequestCreator:taskCreator originalSuccess:success];
        };
        if (retryInterval > 0.0) {
            dispatch_time_t delay;
            if (progressive) {
                delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(retryInterval * pow(2, maxRetry - retryRemaining) * NSEC_PER_SEC));
//                [self logMessage:@"Delaying the next attempt by %.0f seconds 登录", retryInterval * pow(2, maxRetry - retryRemaining)];
            } else {
                delay = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(retryInterval * NSEC_PER_SEC));
//                [self logMessage:@"Delaying the next attempt by %.0f seconds 登录", retryInterval];
            }
            // Not accurate because of "Timer Coalescing and App Nap" - which helps to reduce power consumption.
            dispatch_after(delay, dispatch_get_main_queue(), ^(void){
                addRetryOperation();
            });
        } else {
//            [self logMessage:@"Delaying the next attempt by %.0f seconds 登录", retryInterval];
        }
    } else {
//        [self logMessage:@"No more attempts left! Will execute the failure block."];
    }
}
@end
