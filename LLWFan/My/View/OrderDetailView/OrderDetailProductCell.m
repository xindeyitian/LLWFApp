//
//  OrderDetailProductCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/26.
//

#import "OrderDetailProductCell.h"
#import "AfterSaleFirstViewController.h"

@interface OrderDetailProductCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy, *btnLy, *productLy;
@property (strong, nonatomic) UIImageView     *merchantImg, *productImage;
@property (strong, nonatomic) UILabel        *merchantName, *productName, *productPrice, *productNum, *sku, *oldPrice, *gxz;
@property (strong, nonatomic) UIButton       *leftBtn, *middleBtn ,*rightBtn, *tuiHuoBtn;
@property (strong, nonatomic) OrderModel     *orderModel;

@end

@implementation OrderDetailProductCell
- (void)leftBtnLCicked:(UIButton *)sender{
    
    switch (self.orderModel.orderState) {
        case 1:
        {
            [THHttpManager cancelOrderWithOrderID:self.orderModel.djlsh AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
               
                if (returnCode == 200) {
                    
                    [[THAPPService shareAppService].currentViewController.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
            break;
        case 3:
        {
            //查看物流
        }
        default:
            break;
    }
}
- (void)rightBtnCicked:(UIButton *)sender{
    
    switch (self.orderModel.orderState) {
        case 1:
        {
            
            [THHttpManager rePayOrderWithOrderID:self.orderModel.djlsh AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                
                if (returnCode == 200) {
                    
                    
                }
            }];
        }
            break;
        case 3:
        {
            [THHttpManager confirmReceivingWithOrderId:self.orderModel.djlsh AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                
                if (returnCode == 200) {
                    
                    
                }
            }];
        }
            break;
        case 9:
        {
            [THHttpManager deleteOrderWithOrderId:self.orderModel.djlsh AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
                
                if (returnCode == 200) {
                    
                    
                }
            }];
        }
            break;
        default:
            break;
    }
}
- (void)tuihuoClicked:(UIButton *)sender{
    
    AfterSaleFirstViewController *vc = [[AfterSaleFirstViewController alloc] init];
    vc.model = self.orderModel.itemList[sender.tag];
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}
- (void)setCellWithModel:(OrderModel *)model{
    
    self.orderModel = model;
    self.merchantName.text = model.shopName;
    [self.productLy removeAllSubviews];
    for (int i = 0; i < model.itemList.count; i ++) {
        
        OrderItemModel *itemModel = model.itemList[i];
        [self setProductItemWithModel:itemModel AndTag:i];
    }
    if (model.orderState == 2 || model.orderState == 3) {
        self.tuiHuoBtn.visibility = MyVisibility_Visible;
    }else{
        self.tuiHuoBtn.visibility = MyVisibility_Gone;
    }
    switch (model.orderState) {
        case 1:
        {
            self.leftBtn.visibility = MyVisibility_Visible;
            self.rightBtn.visibility = MyVisibility_Visible;
            [self.leftBtn setTitle:@"取消订单" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"去付款" forState:UIControlStateNormal];
        }
            break;
        case 2:
        {
            self.btnLy.visibility = MyVisibility_Gone;
        }
            break;
        case 3:
        {
            self.leftBtn.visibility = MyVisibility_Visible;
            self.rightBtn.visibility = MyVisibility_Visible;
            [self.leftBtn setTitle:@"查看物流" forState:UIControlStateNormal];
            [self.rightBtn setTitle:@"确认收货" forState:UIControlStateNormal];
        }
            break;
        case 9:
        {
            self.leftBtn.visibility = MyVisibility_Gone;
            self.rightBtn.visibility = MyVisibility_Visible;
            [self.rightBtn setTitle:@"删除订单" forState:UIControlStateNormal];
        }
            break;
        case -1:
        {
            self.btnLy.visibility = MyVisibility_Gone;
        }
            break;
        case -2:
        {
            self.btnLy.visibility = MyVisibility_Gone;
        }
            break;
            
        default:
            break;
    }
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
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 12;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.subviewVSpace = 8;
    self.contentLy.layer.cornerRadius = 12;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.rootLy addSubview:self.contentLy];
    
    MyLinearLayout *merchantLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    merchantLy.myHorzMargin = 0;
    merchantLy.myHeight = MyLayoutSize.wrap;
    merchantLy.subviewHSpace = 8;
    merchantLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:merchantLy];
    
    self.merchantImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"dianpu")];
    self.merchantImg.myWidth = self.merchantImg.myHeight = 20;
    self.merchantImg.layer.cornerRadius = 2;
    self.merchantImg.layer.masksToBounds = YES;
    [merchantLy addSubview:self.merchantImg];
    
    self.merchantName = [BaseLabel CreateBaseLabelStr:@"三只松鼠旗舰店" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.merchantName.myWidth = self.merchantName.myHeight = MyLayoutSize.wrap;
    [merchantLy addSubview:self.merchantName];
    
    self.productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.productLy.myHorzMargin = 0;
    self.productLy.myHeight = MyLayoutSize.wrap;
    self.productLy.subviewHSpace = 8;
    [self.contentLy addSubview:self.productLy];
    
    self.btnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.btnLy.myHeight = 25;
    self.btnLy.myHorzMargin = 0;
    self.btnLy.subviewHSpace = 12;
    self.btnLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:self.btnLy];
    
    UIView *nilView2 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView2.weight = 1;
    nilView2.myHeight = 20;
    [self.btnLy addSubview:nilView2];
    
    self.leftBtn = [BaseButton CreateBaseButtonTitle:@"取消订单" Target:self Action:@selector(leftBtnLCicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.leftBtn.myWidth = 72;
    self.leftBtn.myHeight = 25;
    self.leftBtn.layer.cornerRadius = 12.5;
    self.leftBtn.layer.masksToBounds = YES;
    self.leftBtn.layer.borderColor = color_9.CGColor;
    self.leftBtn.layer.borderWidth = 0.5;
    [self.btnLy addSubview:self.leftBtn];
    
//    self.middleBtn = [BaseButton CreateBaseButtonTitle:@"查看物流" Target:self Action:@selector(middleBtnLCicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:[UIColor colorWithHexString:@"#E61F10"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
//    self.middleBtn.myWidth = 72;
//    self.middleBtn.myHeight = 25;
//    self.middleBtn.layer.cornerRadius = 12.5;
//    self.middleBtn.layer.masksToBounds = YES;
//    self.middleBtn.layer.borderColor = [UIColor colorWithHexString:@"#E61F10"].CGColor;
//    self.middleBtn.layer.borderWidth = 0.5;
//    [self.btnLy addSubview:self.middleBtn];
    
    self.rightBtn = [BaseButton CreateBaseButtonTitle:@"去付款" Target:self Action:@selector(rightBtnCicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:[UIColor colorWithHexString:@"#E61F10"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.rightBtn.myWidth = 72;
    self.rightBtn.myHeight = 25;
    self.rightBtn.layer.cornerRadius = 12.5;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.borderColor = [UIColor colorWithHexString:@"#E61F10"].CGColor;
    self.rightBtn.layer.borderWidth = 0.5;
    [self.btnLy addSubview:self.rightBtn];
    
}
- (void)setProductItemWithModel:(OrderItemModel *)model AndTag:(NSInteger )tag{
    
    self.productImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    self.productImage.myWidth = self.productImage.myHeight = 72;
    self.productImage.layer.cornerRadius = 4;
    self.productImage.layer.masksToBounds = YES;
    [self.productLy addSubview:self.productImage];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.weight = 1;
    infoLy.myHeight = MyLayoutSize.wrap;
    infoLy.subviewVSpace = 8;
    infoLy.myLeft = 12;
    [self.productLy addSubview:infoLy];
    
    MyLinearLayout *titleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    titleLy.myHorzMargin = 0;
    titleLy.myHeight = 20;
    titleLy.gravity = MyGravity_Vert_Center;
    titleLy.alignment = MyGravity_Fill;
    [infoLy addSubview:titleLy];
    
    self.productName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productName.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.productName.textColor = color_3;
    self.productName.text = model.goodsName;
    self.productName.weight = 1;
    self.productName.myHeight = MyLayoutSize.wrap;
    self.productName.numberOfLines = 1;
    [titleLy addSubview:self.productName];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    self.productPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productPrice.text = NSStringFormat(@"¥%.2f",model.priceSale);
    self.productPrice.myHeight = self.productPrice.myWidth = MyLayoutSize.wrap;
    [titleLy addSubview:self.productPrice];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.productPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 1)];
    self.productPrice.attributedText = attr;
    
    MyLinearLayout *skuLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    skuLy.myHorzMargin = 0;
    skuLy.myHeight = 20;
    skuLy.gravity = MyGravity_Vert_Center;
    [infoLy addSubview:skuLy];
    
    self.sku = [[UILabel alloc] initWithFrame:CGRectZero];
    self.sku.font = [UIFont systemFontOfSize:12];
    self.sku.textColor = color_6;
    self.sku.text = model.skuName;
    self.sku.myWidth = MyLayoutSize.wrap;
    self.sku.myHeight = 20;
    [skuLy addSubview:self.sku];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 20;
    [skuLy addSubview:nilView1];
    
    self.productNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productNum.text = NSStringFormat(@"×%@",model.quantityTotal);
    self.productNum.font = [UIFont systemFontOfSize:15];
    self.productNum.textColor = color_6;
    self.productNum.myWidth = MyLayoutSize.wrap;
    self.productNum.myHeight = MyLayoutSize.wrap;
    [skuLy addSubview:self.productNum];
    
    MyLinearLayout *bottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    bottomLy.myHorzMargin = 0;
    bottomLy.myHeight = MyLayoutSize.wrap;
    bottomLy.gravity = MyGravity_Vert_Center;
    [infoLy addSubview:bottomLy];
    
    MyLinearLayout *gxzLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    gxzLy.myWidth = MyLayoutSize.wrap;
    gxzLy.myHeight = 15;
    gxzLy.backgroundColor = [UIColor colorWithHexString:@"#FFECE3"];
    gxzLy.layer.cornerRadius = 2;
    gxzLy.layer.masksToBounds = YES;
    gxzLy.gravity = MyGravity_Vert_Center;
    gxzLy.padding = UIEdgeInsetsMake(0, 4, 0, 4);
    [bottomLy addSubview:gxzLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"qianbao")];
    img.myWidth = img.myHeight = 15;
    [gxzLy addSubview:img];
    
    self.gxz = [[UILabel alloc] initWithFrame:CGRectZero];
    self.gxz.font = [UIFont systemFontOfSize:11];
    self.gxz.textColor = [UIColor colorWithHexString:@"#FF6010"];
    self.gxz.text = NSStringFormat(@"下单赚%@贡献值",model.contributionValue);
    self.gxz.myWidth = self.gxz.myHeight = MyLayoutSize.wrap;
    self.gxz.textAlignment = NSTextAlignmentCenter;
    [gxzLy addSubview:self.gxz];
    
    UIView *nilView2 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView2.weight = 1;
    nilView2.myHeight = 20;
    [bottomLy addSubview:nilView2];
    
    self.tuiHuoBtn = [BaseButton CreateBaseButtonTitle:@"申请退货" Target:self Action:@selector(tuihuoClicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.tuiHuoBtn.myWidth = 72;
    self.tuiHuoBtn.myHeight = 25;
    self.tuiHuoBtn.layer.cornerRadius = 12.5;
    self.tuiHuoBtn.layer.masksToBounds = YES;
    self.tuiHuoBtn.layer.borderColor = color_9.CGColor;
    self.tuiHuoBtn.layer.borderWidth = 0.5;
    self.tuiHuoBtn.tag = tag;
    [bottomLy addSubview:self.tuiHuoBtn];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
