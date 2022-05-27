//
//  ProductDetailStoreCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailStoreCell.h"
#import "MerchantDetailBaseViewController.h"

@interface ProductDetailStoreCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *productLy;
@property (strong, nonatomic) UIImageView    *storeImg;
@property (strong, nonatomic) UILabel        *storeName, *noticeLable;
@property (strong, nonatomic) ShopInfoGoodsVoModel *shopModel;

@end

@implementation ProductDetailStoreCell
- (void)setCellWithModel:(ProductDetailModel *)model{
    
    self.shopModel = model.shopInfoGoodsVo;
    
    [self.storeImg sd_setImageWithURL:[NSURL URLWithString:self.shopModel.logoImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    self.storeName.text = self.shopModel.shopName;
    self.noticeLable.text = NSStringFormat(@"%@人关注",self.shopModel.collectCount);
    
    if (self.shopModel.goodsInfos.count) {
        self.productLy.visibility = MyVisibility_Visible;
        [self.productLy removeAllSubviews];
        for (GoodsInfosModel *goodsInfo in self.shopModel.goodsInfos) {
            
            [self addProductWithModel:goodsInfo];
        }
    }else{
        self.productLy.visibility = MyVisibility_Gone;
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)goToStoreDetail{
    
    MerchantDetailBaseViewController *vc = [[MerchantDetailBaseViewController alloc] init];
    vc.shopID = self.shopModel.shopId;
    [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
}
- (void)initCustomView{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToStoreDetail)];
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.rootLy addGestureRecognizer:tap];
    [self.contentView addSubview:self.rootLy];
    
    //内容布局
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    contentLy.backgroundColor = UIColor.whiteColor;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 16, 12);
    contentLy.gravity = MyGravity_Horz_Center;
    [self.rootLy addSubview:contentLy];
    
    MyLinearLayout *storeTitleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    storeTitleLy.myHorzMargin = 0;
    storeTitleLy.myHeight = 44;
    storeTitleLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:storeTitleLy];
    
    self.storeImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    self.storeImg.myWidth = self.storeImg.myHeight = 44;
    self.storeImg.layer.cornerRadius = 4;
    [storeTitleLy addSubview:self.storeImg];
    
    MyLinearLayout *storeInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    storeInfoLy.weight = 1;
    storeInfoLy.myHeight = 44;
    storeInfoLy.gravity = MyGravity_Vert_Fill;
    storeInfoLy.myLeft = 12;
    [storeTitleLy addSubview:storeInfoLy];
    
    self.storeName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.storeName.font = [UIFont systemFontOfSize:15 weight:UIFontWeightSemibold];
    self.storeName.textColor = UIColor.blackColor;
    self.storeName.text = @"LLWF官方旗舰店";
    self.storeName.myHorzMargin = 0;
    self.storeName.myHeight = MyLayoutSize.wrap;
    [storeInfoLy addSubview:self.storeName];
    
    self.noticeLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.noticeLable.font = [UIFont systemFontOfSize:12 weight:UIFontWeightRegular];
    self.noticeLable.textColor = color_9;
    self.noticeLable.text = @"36万人关注";
    self.noticeLable.myHorzMargin = 0;
    self.noticeLable.myHeight = MyLayoutSize.wrap;
    [storeInfoLy addSubview:self.noticeLable];
    
    //右箭头
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"youjiantou")];
    right.myWidth = right.myHeight = 18;
    [storeTitleLy addSubview:right];
//
//    MyFlowLayout *targetLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:0];
//    targetLy.myHorzMargin = 0;
//    targetLy.myHeight = MyLayoutSize.wrap;
//    targetLy.subviewHSpace = 12;
//    targetLy.subviewVSpace = 12;
//    targetLy.myTop = 8;
//    [contentLy addSubview:targetLy];
//
//    for (int i = 0; i < 3; i++) {
//
//        UILabel *target = [[UILabel alloc] initWithFrame:CGRectZero];
//        target.myWidth = 90;
//        target.myHeight = 25;
//        target.layer.cornerRadius = 12.5;
//        target.layer.masksToBounds = YES;
//        target.text = @"商品很好用";
//        target.backgroundColor = [UIColor colorWithHexString:@"#FF7332"];
//        target.textColor = UIColor.whiteColor;
//        target.textAlignment = NSTextAlignmentCenter;
//        target.font = [UIFont systemFontOfSize:13];
//        [targetLy addSubview:target];
//    }
    
    self.productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.productLy.myHorzMargin = 0;
    self.productLy.myHeight = MyLayoutSize.wrap;
    self.productLy.gravity = MyGravity_Vert_Center;
    self.productLy.subviewHSpace = 8;
    self.productLy.myTop = 8;
    [contentLy addSubview:self.productLy];
    
    UIButton *enterStore = [BaseButton CreateBaseButtonTitle:@"进店逛逛" Target:self Action:@selector(goToStoreDetail) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:UIColor.blackColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    enterStore.myWidth = 125;
    enterStore.myHeight = 40;
    enterStore.myTop = 16;
    enterStore.layer.borderColor = color_9.CGColor;
    enterStore.layer.borderWidth = 1;
    enterStore.layer.cornerRadius = 20;
    enterStore.layer.masksToBounds = YES;
    [contentLy addSubview:enterStore];
    
    MyLinearLayout *imgLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    imgLy.myHeight = 40;
    imgLy.myHorzMargin = 0;
    imgLy.gravity = MyGravity_Center;
    imgLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    [self.rootLy addSubview:imgLy];
    
    UIImageView *tuijian = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"weinituijian")];
    tuijian.myWidth = tuijian.myHeight = MyLayoutSize.wrap;
    [imgLy addSubview:tuijian];
    
}
- (void)addProductWithModel:(GoodsInfosModel *)model{
    
    MyLinearLayout *productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    productLy.myWidth = (ScreenWidth - 72) / 4;
    productLy.myHeight = MyLayoutSize.wrap;
    productLy.subviewVSpace = 4;
    [self.productLy addSubview:productLy];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectZero];
    img.myWidth = img.myHeight = (ScreenWidth - 72) / 4;
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    [img sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:IMAGE_NAMED(@"")];
    [productLy addSubview:img];
    
    UILabel *goodsName = [[UILabel alloc] initWithFrame:CGRectZero];
    goodsName.font = [UIFont systemFontOfSize:12];
    goodsName.textColor = [UIColor colorWithHexString:@"#000000"];
    goodsName.myHorzMargin = 0;
    goodsName.myHeight = 20;
    goodsName.text = model.goodsName;
    [productLy addSubview:goodsName];
    
    UILabel *oldprice = [[UILabel alloc] initWithFrame:CGRectZero];
    oldprice.font = [UIFont fontWithName:@"DIN-Medium" size:12];
    oldprice.textColor = UIColor.redColor;
    oldprice.myHorzMargin = 0;
    oldprice.myHeight = MyLayoutSize.wrap;
    oldprice.text = NSStringFormat(@"¥%@",model.salePrice);
    [productLy addSubview:oldprice];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
