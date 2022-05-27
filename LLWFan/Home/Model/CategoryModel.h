//
//  CategoryModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/13.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryModel : NSObject

@property (copy, nonatomic) NSArray *bannerUrls;
//分类编号
@property (copy, nonatomic) NSString *categoryId;
//级别
@property (copy, nonatomic) NSString *categoryLevel;
//分类名称
@property (copy, nonatomic) NSString *categoryName;
//分类图标
@property (copy, nonatomic) NSString *categoryThumb;
//下级分类
@property (copy, nonatomic) NSArray<CategoryModel *> *listVos;

@end

NS_ASSUME_NONNULL_END
