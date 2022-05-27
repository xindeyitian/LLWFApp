//
//  KongKimModel.h
//  LLWFan
//
//  Created by 张昊男 on 2022/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface KongKimModel : NSObject

@property (strong, nonatomic) NSArray *bannerInfos;
@property (strong, nonatomic) NSArray *bannerAdv;
@property (strong, nonatomic) NSArray *blockDefine;
@property (strong, nonatomic) NSArray *blockDefineGoods;
@property (strong, nonatomic) NSArray *blockDefineCentre;
@property (strong, nonatomic) NSArray *blockDefineCentreRight;

@end

@interface KongKinItemModel : NSObject

//图片路径
@property (nonatomic,copy) NSString * logoImgPath;
//是否显示 1显示,0隐藏
@property (nonatomic,copy) NSString * ifShow;
@property (nonatomic,copy) NSString * blockCode;
@property (nonatomic,copy) NSString * sortNum;
@property (nonatomic,copy) NSString * logoImgName;
@property (nonatomic,copy) NSString * blockName;
//主键id
@property (nonatomic,copy) NSString * djlsh;
@property (nonatomic,copy) NSString * blockDesc;
//删除状态
@property (nonatomic,copy) NSString * deleteSign;
//删除人ID
@property (nonatomic,copy) NSString * cancelUkey;


@end

@interface BannerModel : NSObject

@property (nonatomic,copy) NSString * bannerCode;
@property (nonatomic,copy) NSString * bannerName;
@property (nonatomic,copy) NSString * bannerDesc;
@property (nonatomic,copy) NSString * ossImgPath;
@property (nonatomic,copy) NSString * ossImgName;
@property (nonatomic,copy) NSString * linkType;
@property (nonatomic,copy) NSString * linkId;
@property (nonatomic,copy) NSString * ifShow;
@property (nonatomic,copy) NSString * createTime;
@property (nonatomic,copy) NSString * deleteSign;
@property (nonatomic,copy) NSString * cancelUkey;
@property (nonatomic,copy) NSString * sortNum;

@end
NS_ASSUME_NONNULL_END
