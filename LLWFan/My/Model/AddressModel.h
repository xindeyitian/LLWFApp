//
//  AddressModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AddressModel : NSObject

@property (copy, nonatomic) NSString *address;
@property (copy, nonatomic) NSString *addressID;
@property (copy, nonatomic) NSString *areaCode;
@property (copy, nonatomic) NSString *areaName;
@property (copy, nonatomic) NSString *cityCode;
@property (copy, nonatomic) NSString *cityName;
@property (copy, nonatomic) NSString *ifDefault;
@property (copy, nonatomic) NSString *phoneNum;
@property (copy, nonatomic) NSString *provinceCode;
@property (copy, nonatomic) NSString *provinceName;
@property (copy, nonatomic) NSString *realName;

@end

NS_ASSUME_NONNULL_END
