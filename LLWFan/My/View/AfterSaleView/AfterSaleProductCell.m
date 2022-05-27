//
//  AfterSaleProductCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "AfterSaleProductCell.h"

@interface AfterSaleProductCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *gxzLy;
@property (strong, nonatomic) UIImageView *productImage;
@property (strong, nonatomic) UILabel     *productName, *productPrice, *sku, *productNum, *gxz;

@end

@implementation AfterSaleProductCell
- (void)setCellWithModel:(OrderItemModel *)model{
    
    self.productName.text = model.goodsName;
    self.productPrice.text = NSStringFormat(@"¥%.2f",model.priceSale);
    self.sku.text = model.skuName;
    self.productNum.text = NSStringFormat(@"x%@",model.quantityTotal);
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    if (model.contributionValue.length) {
        
        self.gxz.text = NSStringFormat(@"下单赚%@贡献值",model.contributionValue);
    }else{
        
        self.gxzLy.visibility = MyVisibility_Gone;
    }
}
- (void)setCellWithAfterSaleDetailModel:(AfterSaleDetailModel *)model{
    
    self.productName.text = model.goodsName;
    self.productPrice.text = NSStringFormat(@"¥%.2f",model.priceSale);
    self.sku.text = model.skuName;
    self.productNum.text = NSStringFormat(@"x%@",model.quantityTotal);
    self.gxzLy.visibility = MyVisibility_Gone;
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:IMAGE_NAMED(@"")];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)initCustomView{
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.padding = UIEdgeInsetsMake(12, 0, 0, 0);
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    topLy.myHorzMargin = 12;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.backgroundColor = UIColor.whiteColor;
    topLy.layer.cornerRadius = 8;
    topLy.layer.masksToBounds = YES;
    [self.rootLy addSubview:topLy];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"退款商品" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    title.myTop = title.myLeft = 12;
    [topLy addSubview:title];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    contentLy.myWidth = ScreenWidth - 24;
    contentLy.myHeight = 90;
    contentLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    contentLy.backgroundColor = UIColor.whiteColor;
    contentLy.gravity = MyGravity_Vert_Center;
    [topLy addSubview:contentLy];
    
    self.productImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.productImage setImage:IMAGE_NAMED(@"img")];
    self.productImage.myWidth = self.productImage.myHeight = 72;
    self.productImage.layer.cornerRadius = 4;
    self.productImage.layer.masksToBounds = YES;
    [contentLy addSubview:self.productImage];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.myWidth = ScreenWidth - 60 - 72;
    infoLy.myHeight = 72;
    infoLy.subviewVSpace = 8;
    infoLy.myLeft = 12;
    [contentLy addSubview:infoLy];
    
    MyLinearLayout *titleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    titleLy.myHorzMargin = 0;
    titleLy.myHeight = 20;
    titleLy.gravity = MyGravity_Vert_Center;
    titleLy.alignment = MyGravity_Fill;
    titleLy.subviewHSpace = 8;
    [infoLy addSubview:titleLy];
    
    self.productName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productName.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.productName.textColor = color_3;
    self.productName.text = @"￼￼三只松鼠每日坚果鼠每日坚果鼠每日坚";
    self.productName.weight = 1;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.lineBreakMode = NSLineBreakByTruncatingTail;
    self.productName.numberOfLines = 1;
    [titleLy addSubview:self.productName];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    self.productPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productPrice.text = @"¥199.87";
    self.productPrice.myHeight = self.productPrice.myWidth = MyLayoutSize.wrap;
    [titleLy addSubview:self.productPrice];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.productPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange(0, 1)];
    self.productPrice.attributedText = attr;
    
    MyLinearLayout *skuLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    skuLy.myHorzMargin = 0;
    skuLy.myHeight = 20;
    skuLy.gravity = MyGravity_Vert_Center;
    [infoLy addSubview:skuLy];
    
    self.sku = [[UILabel alloc] initWithFrame:CGRectZero];
    self.sku.font = [UIFont systemFontOfSize:11];
    self.sku.textColor = color_6;
    self.sku.text = @"桶装每日坚果";
    self.sku.myWidth = MyLayoutSize.wrap;
    self.sku.myHeight = 20;
    self.sku.layer.cornerRadius = 10;
    self.sku.layer.masksToBounds = YES;
    [skuLy addSubview:self.sku];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 20;
    [skuLy addSubview:nilView1];
    
    self.productNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productNum.text = @"×1";
    self.productNum.font = [UIFont systemFontOfSize:15];
    self.productNum.textColor = color_6;
    self.productNum.myWidth = self.productNum.myHeight = MyLayoutSize.wrap;
    [skuLy addSubview:self.productNum];
    
    self.gxzLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.gxzLy.myWidth = MyLayoutSize.wrap;
    self.gxzLy.myHeight = 15;
    self.gxzLy.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    self.gxzLy.layer.cornerRadius = 2;
    self.gxzLy.layer.masksToBounds = YES;
    self.gxzLy.gravity = MyGravity_Vert_Center;
    self.gxzLy.padding = UIEdgeInsetsMake(0, 4, 0, 4);
    [infoLy addSubview:self.gxzLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"qianbao")];
    img.myWidth = img.myHeight = 15;
    [self.gxzLy addSubview:img];
    
    self.gxz = [[UILabel alloc] initWithFrame:CGRectZero];
    self.gxz.font = [UIFont systemFontOfSize:11];
    self.gxz.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.gxz.text = @"下单赚1699贡献值";
    self.gxz.myWidth = self.gxz.myHeight = MyLayoutSize.wrap;
    self.gxz.textAlignment = NSTextAlignmentCenter;
    [self.gxzLy addSubview:self.gxz];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
