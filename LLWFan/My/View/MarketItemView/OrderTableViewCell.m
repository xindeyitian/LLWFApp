//
//  OrderTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/13.
//

#import "OrderTableViewCell.h"

@interface OrderTableViewCell()

@property (strong, nonatomic) MyLinearLayout *contentLy ,*gxzLy;
@property (strong, nonatomic) UILabel        *productName, *productPrice, *productNum, *sku, *gxz, *tuiHuo;
@property (strong, nonatomic) UIImageView    *productImage;

@end

@implementation OrderTableViewCell
- (void)setCellWithModel:(OrderItemModel *)model{
    
    self.tuiHuo.visibility = MyVisibility_Gone;
    self.productName.text = model.goodsName;
    self.productNum.text = NSStringFormat(@"x%@",model.quantityTotal);
    self.sku.text = model.skuName;
    self.productPrice.text = NSStringFormat(@"¥%.2f",model.priceSale);
    if (model.contributionValue.length) { 
        self.gxzLy.visibility = MyVisibility_Visible;
        self.gxz.text = NSStringFormat(@"下单赚%@贡献值",model.contributionValue);
    }else{
        self.gxzLy.visibility = MyVisibility_Gone;
    }
}
- (void)setCellWithAfterSaleModel:(AfterSaleModel *)model{
    
    self.tuiHuo.visibility = MyVisibility_Visible;
    self.productName.text = model.goodsName;
    self.productNum.text = NSStringFormat(@"x%@",model.quantity);
    self.sku.text = model.skuName;
    self.productPrice.text = NSStringFormat(@"¥%@",model.moneyBackValue);

    self.gxzLy.visibility = MyVisibility_Gone;
    
    //申请类型 1：仅退款 2：退货退款
    //处理状态（1 等待商家同意、2等待揽件、3等待退款、9退货完成、-1退货失败、-2客户取消、-3商家取消）
    if (model.applyType == 1) {
        
        if (model.dealSign == 1 || model.dealSign == 2 || model.dealSign == 3) {
            self.tuiHuo.text = @"退款中";
        }else if (model.dealSign == 9){
            self.tuiHuo.text = @"退款成功";
        }else if(model.dealSign == -1){
            self.tuiHuo.text = @"退款失败";
        }else{
            self.tuiHuo.text = @"退款取消";
        }
    }else{
        
        if (model.dealSign == 1 || model.dealSign == 2 || model.dealSign == 3) {
            self.tuiHuo.text = @"售后中";
        }else if (model.dealSign == 9){
            self.tuiHuo.text = @"售后成功";
        }else if(model.dealSign == -1){
            self.tuiHuo.text = @"售后失败";
        }else{
            self.tuiHuo.text = @"售后取消";
        }
    }
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
//    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
//    self.rootLy.myHeight = MyLayoutSize.wrap;
//    self.rootLy.myWidth = ScreenWidth - 24;
//    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
//    self.rootLy.padding = UIEdgeInsetsMake(0, 0, 0, 0);
//    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.contentLy.myWidth = ScreenWidth - 24;
    self.contentLy.myHeight = 90;
    self.contentLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    [self.contentView addSubview:self.contentLy];
    
    self.productImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.productImage setImage:IMAGE_NAMED(@"img")];
    self.productImage.myWidth = self.productImage.myHeight = 72;
    self.productImage.layer.cornerRadius = 4;
    self.productImage.layer.masksToBounds = YES;
    [self.contentLy addSubview:self.productImage];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.myWidth = ScreenWidth - 60 - 72;
    infoLy.myHeight = 72;
    infoLy.subviewVSpace = 8;
    infoLy.myLeft = 12;
    [self.contentLy addSubview:infoLy];
    
    MyLinearLayout *titleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    titleLy.myHorzMargin = 0;
    titleLy.myHeight = 20;
    titleLy.gravity = MyGravity_Vert_Center;
    titleLy.alignment = MyGravity_Fill;
    [infoLy addSubview:titleLy];
    
    self.productName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productName.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.productName.textColor = color_3;
    self.productName.text = @"￼￼三只松鼠每日坚果…";
    self.productName.weight = 1;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.numberOfLines = 1;
    [titleLy addSubview:self.productName];
    
//    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
//    nilView.weight = 1;
//    nilView.myHeight = 20;
//    nilView.backgroundColor = UIColor.whiteColor;
//    [titleLy addSubview:nilView];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    self.productPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productPrice.text = @"¥199.87";
    self.productPrice.myHeight = self.productPrice.myWidth = MyLayoutSize.wrap;
    [titleLy addSubview:self.productPrice];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.productPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange(1, 1)];
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
    self.sku.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
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
    
    MyLinearLayout *bottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    bottomLy.myHorzMargin = 0;
    bottomLy.myHeight = 15;
    [infoLy addSubview:bottomLy];
    
    self.gxzLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.gxzLy.myWidth = MyLayoutSize.wrap;
    self.gxzLy.myHeight = 15;
    self.gxzLy.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    self.gxzLy.layer.cornerRadius = 2;
    self.gxzLy.layer.masksToBounds = YES;
    self.gxzLy.gravity = MyGravity_Vert_Center;
    self.gxzLy.padding = UIEdgeInsetsMake(0, 4, 0, 4);
    [bottomLy addSubview:self.gxzLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"qianbao")];
    img.myWidth = 10;
    img.myHeight = 12;
    [self.gxzLy addSubview:img];
    
    self.gxz = [[UILabel alloc] initWithFrame:CGRectZero];
    self.gxz.font = [UIFont systemFontOfSize:11];
    self.gxz.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.gxz.text = @"下单赚1699贡献值";
    self.gxz.myWidth = self.gxz.myHeight = MyLayoutSize.wrap;
    self.gxz.textAlignment = NSTextAlignmentCenter;
    self.gxz.myLeft = 2;
    [self.gxzLy addSubview:self.gxz];
    
    UIView *nilView2 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView2.weight = 1;
    nilView2.myHeight = 20;
    nilView2.backgroundColor = UIColor.whiteColor;
    [bottomLy addSubview:nilView2];
    
    self.tuiHuo = [BaseLabel CreateBaseLabelStr:@"退款中" Font:[UIFont systemFontOfSize:12] Color:[UIColor colorWithHexString:@"#FDA918"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.tuiHuo.myWidth = self.tuiHuo.myHeight = MyLayoutSize.wrap;
    self.tuiHuo.visibility = MyVisibility_Gone;
    [bottomLy addSubview:self.tuiHuo];
    
}
@end
