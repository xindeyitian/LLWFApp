//
//  ProductDetailInfoCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailInfoCell.h"

#define cycleViewHeight 375

@interface ProductDetailInfoCell()<SDCycleScrollViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *cycleView;
@property (strong, nonatomic) UILabel           *pageLable, *productTitle, *productPrice, *productOldPrice, *soldNum, *gongxianzhi;
@property (strong, nonatomic) MyLinearLayout    *rootLy, *infoLy;
@property (strong, nonatomic) ProductDetailModel *model;

@end

@implementation ProductDetailInfoCell
- (void)setCellWithModel:(ProductDetailModel *)model{
    
    self.model = model;
    self.cycleView.imageURLStringsGroup = model.goodsImgs.images;
    self.pageLable.text = NSStringFormat(@"1/%ld",model.goodsImgs.images.count);
    self.productTitle.text = model.goodsName;
    self.productPrice.text = NSStringFormat(@"¥%.2f",model.salePrice);
    self.productOldPrice.text = NSStringFormat(@"¥%.2f",model.marketPrice);
    self.gongxianzhi.text = NSStringFormat(@"提升贡献值:%@",model.contributionValue);
    self.soldNum.text = NSStringFormat(@"销量:%@",model.saleCount);
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
    self.pageLable.text = NSStringFormat(@"%ld/%ld",index + 1,self.model.goodsImgs.images.count);
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    [self.contentView addSubview:self.rootLy];
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:IMAGE_NAMED(@"")];
    self.cycleView.localizationImageNamesGroup = @[];
    self.cycleView.showPageControl = NO;
    self.cycleView.autoScroll = NO;
    self.cycleView.bannerImageViewContentMode = UIViewContentModeScaleToFill;
    self.cycleView.backgroundColor = UIColor.whiteColor;
    self.cycleView.myWidth = ScreenWidth;
    self.cycleView.myHeight = 375;
    [self.rootLy addSubview:self.cycleView];
    
    UIView *pageCtl = [[UIView alloc] initWithFrame:CGRectZero];
    pageCtl.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.4];
    pageCtl.myWidth = 44;
    pageCtl.myHeight = 22;
    pageCtl.myTop = -34;
    pageCtl.myLeft = ScreenWidth - 44 - 12;
    pageCtl.layer.cornerRadius = 11;
    pageCtl.layer.masksToBounds = YES;
    [self.rootLy addSubview:pageCtl];
    
    self.pageLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 44, 22)];
    self.pageLable.font = [UIFont systemFontOfSize:12];
    self.pageLable.textColor = UIColor.whiteColor;
    self.pageLable.textAlignment = NSTextAlignmentCenter;
    [pageCtl addSubview:self.pageLable];
    
    self.infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.infoLy.myTop = 12;
    self.infoLy.myHorzMargin = 0;
    self.infoLy.myHeight = MyLayoutSize.wrap;
    self.infoLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.infoLy.backgroundColor = UIColor.whiteColor;
    [self.rootLy addSubview:self.infoLy];
    
    self.productTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productTitle.font = [UIFont systemFontOfSize:17 weight:UIFontWeightSemibold];
    self.productTitle.numberOfLines = 0;
    self.productTitle.myHorzMargin = 0;
    self.productTitle.myHeight = MyLayoutSize.wrap;
    self.productTitle.textColor = UIColor.blackColor;
    self.productTitle.text = @"东京购物精华日本药妆店便宜必败妆店便宜必";
    [self.infoLy addSubview:self.productTitle];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 0;
    numLy.myHeight = MyLayoutSize.wrap;
    numLy.gravity = MyGravity_Vert_Bottom;
    numLy.myTop = 8;
    numLy.subviewHSpace = 5;
    [self.infoLy addSubview:numLy];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productPrice.font = [UIFont fontWithName:@"DIN-Medium" size:25];
    self.productPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productPrice.myWidth = MyLayoutSize.wrap;
    self.productPrice.myHeight = MyLayoutSize.wrap;
    [numLy addSubview:self.productPrice];
    
    self.productOldPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productOldPrice.font = [UIFont fontWithName:@"DIN-Regular" size:13];
    self.productOldPrice.textColor = color_9;
    self.productOldPrice.myWidth = MyLayoutSize.wrap;
    self.productOldPrice.myHeight = MyLayoutSize.wrap;
    self.productOldPrice.text = @"999";
    [numLy addSubview:self.productOldPrice];
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.productOldPrice.text attributes:attribtDic];
    // 赋值
    self.productOldPrice.attributedText = attribtStr;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.weight = 1;
    view.myHeight = 33;
    view.backgroundColor = UIColor.whiteColor;
    [numLy addSubview:view];
    
    self.soldNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.soldNum.font = [UIFont systemFontOfSize:12];
    self.soldNum.textColor = color_9;
    self.soldNum.myWidth = MyLayoutSize.wrap;
    self.soldNum.myHeight = 20;
    self.soldNum.text = @"销量：2000";
    [numLy addSubview:self.soldNum];
    
    self.gongxianzhi = [[UILabel alloc] initWithFrame:CGRectZero];
    self.gongxianzhi.myWidth = MyLayoutSize.wrap;
    self.gongxianzhi.myHeight = 20;
    self.gongxianzhi.textColor = UIColor.redColor;
    self.gongxianzhi.text = @"提升贡献值：999";
    self.gongxianzhi.font = [UIFont systemFontOfSize:12];
    self.gongxianzhi.myTop = 2;
    [self.infoLy addSubview:self.gongxianzhi];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
