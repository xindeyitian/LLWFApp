//
//  AfterSaleFirstViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/26.
//

#import "AfterSaleFirstViewController.h"
#import "ChooseAfterSaleTypeController.h"

@interface AfterSaleFirstViewController ()

@property (strong, nonatomic) UIImageView *productImage;
@property (strong, nonatomic) UILabel     *productName, *productPrice, *sku, *productNum, *gxz;

@end

@implementation AfterSaleFirstViewController
- (void)onlyRefund{
    
    //仅退款
    ChooseAfterSaleTypeController *vc = [[ChooseAfterSaleTypeController alloc] init];
    vc.type = 0;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)salesReturnAndRefund{
    
    //退货退款
    ChooseAfterSaleTypeController *vc = [[ChooseAfterSaleTypeController alloc] init];
    vc.type = 1;
    vc.model = self.model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"选择售后类型"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myHorzMargin = 0;
    rootLy.myHeight = MyLayoutSize.wrap;
    rootLy.padding = UIEdgeInsetsMake(12, 0, 12, 0);
    rootLy.subviewVSpace = 12;
    [self.view addSubview:rootLy];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    topLy.myHorzMargin = 12;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.backgroundColor = UIColor.whiteColor;
    topLy.layer.cornerRadius = 8;
    topLy.layer.masksToBounds = YES;
    [rootLy addSubview:topLy];
    
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
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:self.model.skuImgUrl] placeholderImage:IMAGE_NAMED(@"")];
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
    self.productName.text = self.model.goodsName;
    self.productName.weight = 1;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.lineBreakMode = NSLineBreakByTruncatingTail;
    self.productName.numberOfLines = 1;
    [titleLy addSubview:self.productName];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    self.productPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productPrice.text = NSStringFormat(@"¥%.2f",self.model.priceSale);
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
    self.sku.text = self.model.skuName;
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
    self.productNum.text = NSStringFormat(@"x%@",self.model.quantityTotal);
    self.productNum.font = [UIFont systemFontOfSize:15];
    self.productNum.textColor = color_6;
    self.productNum.myWidth = self.productNum.myHeight = MyLayoutSize.wrap;
    [skuLy addSubview:self.productNum];
    
    MyLinearLayout *gxzLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    gxzLy.myWidth = MyLayoutSize.wrap;
    gxzLy.myHeight = 15;
    gxzLy.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    gxzLy.layer.cornerRadius = 2;
    gxzLy.layer.masksToBounds = YES;
    gxzLy.gravity = MyGravity_Vert_Center;
    gxzLy.padding = UIEdgeInsetsMake(0, 4, 0, 4);
    [infoLy addSubview:gxzLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"qianbao")];
    img.myWidth = img.myHeight = 15;
    [gxzLy addSubview:img];
    
    self.gxz = [[UILabel alloc] initWithFrame:CGRectZero];
    self.gxz.font = [UIFont systemFontOfSize:11];
    self.gxz.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.gxz.text = NSStringFormat(@"下单赚%@贡献值",self.model.contributionValue);
    self.gxz.myWidth = self.gxz.myHeight = MyLayoutSize.wrap;
    self.gxz.textAlignment = NSTextAlignmentCenter;
    [gxzLy addSubview:self.gxz];
    
    MyLinearLayout *chooseTypeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    chooseTypeLy.myHorzMargin = 12;
    chooseTypeLy.myHeight = MyLayoutSize.wrap;
    chooseTypeLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    chooseTypeLy.subviewVSpace = 12;
    chooseTypeLy.layer.cornerRadius = 12;
    chooseTypeLy.layer.masksToBounds = YES;
    chooseTypeLy.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:chooseTypeLy];
    
    UILabel *chooseTypeLable = [BaseLabel CreateBaseLabelStr:@"选择服务类型" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    chooseTypeLable.myWidth = chooseTypeLable.myHeight = MyLayoutSize.wrap;
    [chooseTypeLy addSubview:chooseTypeLable];
    
    //仅退款
    
    UITapGestureRecognizer *onlyRefundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onlyRefund)];
    
    MyLinearLayout *onlyRefundLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    onlyRefundLy.myHorzMargin = 0;
    onlyRefundLy.myHeight = MyLayoutSize.wrap;
    [onlyRefundLy addGestureRecognizer:onlyRefundTap];
    [chooseTypeLy addSubview:onlyRefundLy];
    
    UIImageView *refundImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"refund")];
    refundImg.myWidth = 16;
    refundImg.myHeight = 15;
    [onlyRefundLy addSubview:refundImg];
    
    MyLinearLayout *onlyRefundInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    onlyRefundInfoLy.weight = 1;
    onlyRefundInfoLy.myHeight = MyLayoutSize.wrap;
    onlyRefundInfoLy.subviewVSpace = 8;
    onlyRefundInfoLy.myLeft = 8;
    [onlyRefundLy addSubview:onlyRefundInfoLy];
    
    UILabel *onlyRefundTitle = [BaseLabel CreateBaseLabelStr:@"我要退款(无需退货)" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    onlyRefundTitle.myWidth = onlyRefundTitle.myHeight = MyLayoutSize.wrap;
    [onlyRefundInfoLy addSubview:onlyRefundTitle];
    
    UILabel *onlyRefundInfo = [BaseLabel CreateBaseLabelStr:@"没有收到货，或与卖家协商同意不用退货只退款" Font:[UIFont systemFontOfSize:13] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    onlyRefundInfo.numberOfLines = 0;
    onlyRefundInfo.myWidth = onlyRefundInfo.myHeight = MyLayoutSize.wrap;
    [onlyRefundInfoLy addSubview:onlyRefundInfo];
    
    UIImageView *onlyRefundRight = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    onlyRefundRight.myWidth = onlyRefundRight.myHeight = 18;
    onlyRefundRight.myTop = 10;
    [onlyRefundLy addSubview:onlyRefundRight];
    
    //退货退款
    UITapGestureRecognizer *salesReturnRefundTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(salesReturnAndRefund)];
    
    MyLinearLayout *salesReturnAndRefundLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    salesReturnAndRefundLy.myHorzMargin = 0;
    salesReturnAndRefundLy.myHeight = MyLayoutSize.wrap;
    [salesReturnAndRefundLy addGestureRecognizer:salesReturnRefundTap];
    [chooseTypeLy addSubview:salesReturnAndRefundLy];
    
    UIImageView *salesReturnAndrefundImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"salesReturnAndRefund")];
    salesReturnAndrefundImg.myWidth = 16;
    salesReturnAndrefundImg.myHeight = 15;
    [salesReturnAndRefundLy addSubview:salesReturnAndrefundImg];
    
    MyLinearLayout *salesReturnRefundInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    salesReturnRefundInfoLy.weight = 1;
    salesReturnRefundInfoLy.myHeight = MyLayoutSize.wrap;
    salesReturnRefundInfoLy.subviewVSpace = 8;
    salesReturnRefundInfoLy.myLeft = 8;
    [salesReturnAndRefundLy addSubview:salesReturnRefundInfoLy];
    
    UILabel *salesReturnRefundTitle = [BaseLabel CreateBaseLabelStr:@"我要退货退款" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    salesReturnRefundTitle.myWidth = salesReturnRefundTitle.myHeight = MyLayoutSize.wrap;
    [salesReturnRefundInfoLy addSubview:salesReturnRefundTitle];
    
    UILabel *salesReturnRefundInfo = [BaseLabel CreateBaseLabelStr:@"已收到货，需要退还收到的货物" Font:[UIFont systemFontOfSize:13] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    salesReturnRefundInfo.numberOfLines = 0;
    salesReturnRefundInfo.myWidth = salesReturnRefundInfo.myHeight = MyLayoutSize.wrap;
    [salesReturnRefundInfoLy addSubview:salesReturnRefundInfo];
    
    UIImageView *salesReturnRefundRight = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    salesReturnRefundRight.myWidth = salesReturnRefundRight.myHeight = 18;
    salesReturnRefundRight.myTop = 10;
    [salesReturnAndRefundLy addSubview:salesReturnRefundRight];
    
}
@end
