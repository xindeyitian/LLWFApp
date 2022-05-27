//
//  TotalPayModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TotalPayModel : NSObject

@property (assign, nonatomic) float quantity;

@property (assign, nonatomic) float totalMoney;

@property (copy, nonatomic) NSString *finalMoney;

@property (copy, nonatomic) NSString *subtractMoney;
@end

NS_ASSUME_NONNULL_END
