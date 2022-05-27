//
//  NSDictionary+SCCommon.m
//  LDSpecialCarService
//
//  Created by Mac on 2017/3/1.
//  Copyright © 2017年 Mac. All rights reserved.
//

#import "NSDictionary+SCCommon.h"

@implementation NSDictionary (SCCommon)

- (NSString *)JSONString
{
    NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];

    NSString *jsonString = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    
    return jsonString;
}
+ (NSDictionary *)dictSorting:(NSDictionary *)dict{

    NSArray *allKeyArray = [dict allKeys];

    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {

        NSComparisonResult resuest = [obj1 compare:obj2]; //[obj1 compare:obj2]：升序

        return resuest;//NSOrderedAscending 倒序
        
    }];
    //通过排列的key值获取value

    NSMutableDictionary *valueDic = [NSMutableDictionary dictionary];

    for (NSString *sortsing in afterSortKeyArray) {

        NSString *valueString = [dict objectForKey:sortsing];

        [valueDic setObject:valueString forKey:sortsing];

    }
     return valueDic;
}
@end
