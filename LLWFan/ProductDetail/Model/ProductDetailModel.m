//
//  ProductDetailModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/16.
//

#import "ProductDetailModel.h"

@implementation ProductDetailModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"records":[RecordsModel class],
             @"goodsSkuVos":[GoodsSkuVosModel class]
    };
}
@end
@implementation AppraisesModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"records":[RecordsModel class]};
}
@end
@implementation RecordsModel

@end
@implementation GoodsAttVosModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"attrValue":[AttrValueModel class]};
}
@end
@implementation AttrValueModel

@end
@implementation GoodsImgsModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"images":[NSString class]};
}
@end

@implementation GoodsSkuVosModel

- (float)salePrice{
    
    return NSStringFormat(@"%.2f",_salePrice).floatValue;
}
- (float)marketPrice{
    
    return NSStringFormat(@"%.2f",_marketPrice).floatValue;
}

@end

@implementation ShopInfoGoodsVoModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"goodsInfos":[GoodsInfosModel class]};
}
@end
@implementation GoodsInfosModel

@end
