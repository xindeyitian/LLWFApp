//
//  HomeCollectionViewCell.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/6.
//

#import "HomeCollectionViewCell.h"

@interface HomeCollectionViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView    *productImage;
@property (strong, nonatomic) UILabel        *productName;
@property (strong, nonatomic) UILabel        *manjian;
@property (strong, nonatomic) UILabel        *productprice;
@property (strong, nonatomic) UILabel        *productSoldNum;
@property (strong, nonatomic) UILabel        *commissionNum;
@property (strong, nonatomic) UIButton       *addShopWindowBtn;

@end

@implementation HomeCollectionViewCell
- (void)addShopWindow:(UIButton *)sender{
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCellWithModel:(ProductModel *)model{
    
    self.productName.text = model.goodsName;
    self.productSoldNum.text = NSStringFormat(@"销量%@",model.saleCount);
    self.productprice.text = NSStringFormat(@"¥%.2f",model.salePrice);
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:IMAGE_NAMED(@"")];
    if (model.contributeValue) {
        self.commissionNum.text = NSStringFormat(@"贡献值：%@",model.contributeValue);
    }else{
        
        self.commissionNum.visibility = MyVisibility_Gone;
    }
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.layer.cornerRadius = 8;
    self.rootLy.layer.masksToBounds = YES;
    self.rootLy.myWidth = (ScreenWidth - 32.0) / 2.0;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.padding = UIEdgeInsetsMake(0, 0, 8, 0);
    self.rootLy.backgroundColor = UIColor.whiteColor;
//    self.rootLy.cacheEstimatedRect = YES;
    [self.contentView addSubview:self.rootLy];
    
    self.productImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.productImage.myHorzMargin = 0;
    self.productImage.myHeight = ((ScreenWidth - 32.0) / 2.0) * 3 / 4;
    self.productImage.contentMode = UIViewContentModeScaleAspectFill;
    self.productImage.layer.masksToBounds = YES;
    [self.productImage setImage:IMAGE_NAMED(@"img")];
    [self.rootLy addSubview:self.productImage];

    self.productName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productName.myHorzMargin = 12;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.myTop = 8;
    self.productName.numberOfLines = 2;
    self.productName.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.productName.textColor = color_3;
    self.productName.text = @"";
    [self.rootLy addSubview:self.productName];
    
    self.manjian = [[UILabel alloc] initWithFrame:CGRectZero];
    self.manjian.font = [UIFont systemFontOfSize:13];
    self.manjian.textColor = [UIColor colorWithHexString:@"#F65200"];
    self.manjian.text = @"满129立减10";
    self.manjian.myHorzMargin = 12;
    self.manjian.myHeight = MyLayoutSize.wrap;
    self.manjian.myTop = 4;
    self.manjian.visibility = MyVisibility_Gone;
    [self.rootLy addSubview:self.manjian];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 12;
    numLy.myHeight = 35;
    numLy.myTop = 4;
    numLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:numLy];
    
    self.productprice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productprice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productprice.font = [UIFont systemFontOfSize:25];
    self.productprice.text = @"¥99.90";
    self.productprice.myWidth = MyLayoutSize.wrap;
    self.productprice.myHeight = 35;
    [numLy addSubview:self.productprice];
    
    self.productSoldNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productSoldNum.textColor = color_9;
    self.productSoldNum.font = [UIFont systemFontOfSize:12];
    self.productSoldNum.myWidth = MyLayoutSize.wrap;
    self.productSoldNum.myHeight = 20;
    self.productSoldNum.text = @"销量80";
    self.productSoldNum.myLeft = 4;
    [numLy addSubview:self.productSoldNum];
    
//    MyLinearLayout *bottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
//    bottomLy.myHorzMargin = 12;
//    bottomLy.myHeight = 25;
//    bottomLy.myTop = 7;
//    bottomLy.gravity = MyGravity_Vert_Center;
//    [self.rootLy addSubview:bottomLy];
    
    self.commissionNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.commissionNum.myWidth = MyLayoutSize.wrap;
    self.commissionNum.myHeight = 15;
    self.commissionNum.layer.cornerRadius = 2;
    self.commissionNum.layer.masksToBounds = YES;
    self.commissionNum.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    self.commissionNum.textAlignment = NSTextAlignmentCenter;
    self.commissionNum.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.commissionNum.text = @"贡献值：¥99.9";
    self.commissionNum.font = [UIFont systemFontOfSize:11];
    self.commissionNum.myTop = 4;
    self.commissionNum.myLeft = 12;
    [self.rootLy addSubview:self.commissionNum];
    
//    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
//    nilView1.weight = 1;
//    nilView1.myHeight = 25;
//    [bottomLy addSubview:nilView1];
//
//    self.addShopWindowBtn = [BaseButton CreateBaseButtonTitle:@"加入橱窗" Target:self Action:@selector(addShopWindow:) Font:[UIFont systemFontOfSize:12] BackgroundColor:[UIColor colorWithHexString:@"#FA172D"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
//    self.addShopWindowBtn.myWidth = 66;
//    self.addShopWindowBtn.myHeight = 25;
//    self.addShopWindowBtn.layer.cornerRadius = 12.5;
//    self.addShopWindowBtn.layer.masksToBounds = YES;
//    [bottomLy addSubview:self.addShopWindowBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
-(UICollectionViewLayoutAttributes*)preferredLayoutAttributesFittingAttributes:(UICollectionViewLayoutAttributes*)layoutAttributes {
    [self setNeedsLayout];
    [self layoutIfNeeded];
    CGSize size = [self.rootLy systemLayoutSizeFittingSize: layoutAttributes.size];
    CGRect cellFrame = layoutAttributes.frame;
    cellFrame.size.height = size.height;
    layoutAttributes.frame = cellFrame;
    return layoutAttributes;
}
@end
