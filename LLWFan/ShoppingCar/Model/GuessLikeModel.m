//
//  GuessLikeModel.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/23.
//

#import "GuessLikeModel.h"

@implementation GuessLikeModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{@"records":[GoodsListModel class]};
}
@end
@implementation GoodsListModel

- (float)marketPrice{
    
    return NSStringFormat(@"%.2f",_marketPrice).floatValue;
}
- (float)salePrice{
    
    return NSStringFormat(@"%.2f",_salePrice).floatValue;
}
- (void)setGoodsName:(NSString *)goodsName{
    _goodsName = goodsName;
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectZero];
    lable.text = goodsName;
    lable.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    lable.numberOfLines = 2;
    CGFloat lineHeight = ceilf(lable.font.lineHeight);
    
    CGFloat lableHeight = [goodsName sizeWithLabelWidth:(ScreenWidth - 32 - 24) / 2 font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium]].height;
    // + 16 优惠政策暂无  + 19 贡献值
    if (lableHeight > lineHeight) {
        
        if (self.contributeValue.length) {
            
            self.height = lineHeight * 2 + 8 + ((ScreenWidth - 32) / 2) * 3 / 4 + 39 + 8 + 19;
        }else{
            
            self.height = lineHeight * 2 + 8 + ((ScreenWidth - 32) / 2) * 3 / 4 + 39 + 8;
        }
    }else{
        
        if (self.contributeValue.length) {
            
            self.height = lineHeight + 8 + ((ScreenWidth - 32) / 2) * 3 / 4 + 39 + 8 + 19;
        }else{
            
            self.height = lineHeight + 8 + ((ScreenWidth - 32) / 2) * 3 / 4 + 39 + 8;
        }
    }
}
@end
