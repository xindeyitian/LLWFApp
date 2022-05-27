//
//  HomeTableViewCell.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/1.
//

#import "HomeTableViewCell.h"

@interface HomeTableViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy, *gxzLy;
@property (strong, nonatomic) UILabel        *prodcutName, *manjian, *price, *oldPirce, *gxz;
@property (strong, nonatomic) UIImageView    *productImage;
@property (strong, nonatomic) UIButton       *chooseBtn;

@end

@implementation HomeTableViewCell
- (void)initCellWithModel:(ProductModel *)model{
    
    self.prodcutName.text = model.goodsName;
    if (model.contributeValue) {
        self.gxz.text = NSStringFormat(@"贡献值：%@",model.contributeValue);
    }
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:IMAGE_NAMED(@"")];
    self.price.text = NSStringFormat(@"¥%.2f",model.marketPrice);
    self.oldPirce.text = NSStringFormat(@"¥%.2f",model.salePrice);
}
- (void)chooseCurProduct{
    
    
}
- (void)reloadEditingTypeWith:(BOOL )editingType{
    
    if (editingType) {
        
        self.chooseBtn.visibility = MyVisibility_Visible;
    }else{
        
        self.chooseBtn.visibility = MyVisibility_Gone;
    }
}
#pragma mark ----------init------------
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{

    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    [self.contentView addSubview:self.rootLy];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:12 tailIndent:12];
    self.rootLy.bottomBorderline = line;
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.subviewHSpace = 12;
    [self.rootLy addSubview:self.contentLy];
    
    self.chooseBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(chooseCurProduct) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.chooseBtn.myWidth = 24;
    self.chooseBtn.myVertMargin = 0;
    self.chooseBtn.visibility = MyVisibility_Gone;
    [self.contentLy addSubview:self.chooseBtn];
    
    self.productImage = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    self.productImage.layer.cornerRadius = 4;
    self.productImage.layer.masksToBounds = YES;
    self.productImage.myWidth = self.productImage.myHeight = 80;
    [self.contentLy addSubview:self.productImage];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.weight = 1;
    infoLy.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:infoLy];
    
    self.prodcutName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.prodcutName.font = [UIFont systemFontOfSize:15];
    self.prodcutName.textColor = color_3;
    self.prodcutName.text = @"阔色法式复古针织连衣裙女2021新款早秋装长袖内搭黑长裙子冬";
    self.prodcutName.numberOfLines = 2;
    self.prodcutName.myHorzMargin = 0;
    self.prodcutName.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:self.prodcutName];
    
    MyLinearLayout *bottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    bottomLy.myHorzMargin = 0;
    bottomLy.myHeight = MyLayoutSize.wrap;
    bottomLy.myTop = 4;
    [infoLy addSubview:bottomLy];
    
    MyLinearLayout *priceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    priceLy.weight = 1;
    priceLy.myHeight = 70;
    priceLy.subviewVSpace = 8;
    priceLy.gravity = MyGravity_Vert_Center;
    [bottomLy addSubview:priceLy];
    
    self.manjian = [[UILabel alloc] initWithFrame:CGRectZero];
    self.manjian.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.manjian.textColor = [UIColor colorWithHexString:@"#F65200"];
    self.manjian.text = @"满129立减10";
    self.manjian.myWidth = self.manjian.myHeight = MyLayoutSize.wrap;
    self.manjian.visibility = MyVisibility_Gone;
    [priceLy addSubview:self.manjian];
    
    MyLinearLayout *priceMidLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    priceMidLy.myWidth = priceMidLy.myHeight = MyLayoutSize.wrap;
    priceMidLy.subviewHSpace = 4;
    priceMidLy.gravity = MyGravity_Vert_Center;
    [priceLy addSubview:priceMidLy];
    
    self.price = [[UILabel alloc] initWithFrame:CGRectZero];
    self.price.font = [UIFont fontWithName:@"DIN-Bold" size:13];
    self.price.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.price.text = @"¥108.88";
    self.price.myWidth = self.price.myHeight = MyLayoutSize.wrap;
    [priceMidLy addSubview:self.price];
    
    self.oldPirce = [[UILabel alloc] initWithFrame:CGRectZero];
    self.oldPirce.myWidth = self.oldPirce.myHeight = MyLayoutSize.wrap;
    self.oldPirce.font = [UIFont systemFontOfSize:11];
    self.oldPirce.textColor = color_9;
    NSString *textStr = @"¥288.88";
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr attributes:attribtDic];
    // 赋值
    self.oldPirce.attributedText = attribtStr;
    [priceMidLy addSubview:self.oldPirce];
    
    self.gxzLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.gxzLy.myWidth = MyLayoutSize.wrap;
    self.gxzLy.myHeight = 15;
    self.gxzLy.padding = UIEdgeInsetsMake(0, 4, 0, 4);
    self.gxzLy.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    self.gxzLy.layer.cornerRadius = 2;
    self.gxzLy.layer.masksToBounds = YES;
//    self.gxzLy.visibility = MyVisibility_Gone;
    [priceLy addSubview:self.gxzLy];

    self.gxz = [[UILabel alloc] initWithFrame:CGRectZero];
    self.gxz.myWidth = self.gxz.myHeight = MyLayoutSize.wrap;
    self.gxz.font = [UIFont systemFontOfSize:11];
    self.gxz.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.gxz.text = @"贡献值：99.9";
    self.gxzLy.gravity = MyGravity_Vert_Center;
    [self.gxzLy addSubview:self.gxz];
    
    UIButton *shareBtn = [BaseButton CreateBaseButtonTitle:@"分享赚钱" Target:self Action:@selector(shareProduct) Font:[UIFont systemFontOfSize:12] BackgroundColor:[UIColor bm_colorGradientChangeWithSize:CGSizeMake(80, 25) direction:IHGradientChangeDirectionLevel startColor:[UIColor colorWithHexString:@"#FF6010"] endColor:[UIColor colorNamed:@"color-red"]] Color:[UIColor colorWithHexString:@"#FFFFFF"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    shareBtn.myWidth = 80;
    shareBtn.myHeight = 25;
    shareBtn.layer.cornerRadius = 12.5;
    shareBtn.layer.shadowColor = [UIColor colorWithRed:255/255.0 green:96/255.0 blue:16/255.0 alpha:0.35].CGColor;
    shareBtn.layer.shadowOffset = CGSizeMake(-1,1);
    shareBtn.layer.shadowOpacity = 1;
    shareBtn.layer.shadowRadius = 6;
    shareBtn.myTop = 35;
    [bottomLy addSubview:shareBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
