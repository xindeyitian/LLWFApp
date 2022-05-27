//
//  OrderProductCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "OrderProductCell.h"

@interface OrderProductCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy, *productLy;
@property (strong, nonatomic) UIView         *nilView;
@property (strong, nonatomic) UILabel        *marketName;
@property (strong, nonatomic) UILabel        *sendService, *manjianService, *message;

@end

@implementation OrderProductCell
- (void)setCellWithModel:(ShopOrdersModel *)model{
    self.marketName.text = model.shopName;
    
    [self.productLy removeAllSubviews];
    for (ShopCarItemModel *itemModel in model.shopCartItems) {
        
        [self initProcductItemWithShopCarItemModel:itemModel];
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
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.rootLy.padding = UIEdgeInsetsMake(12, 12, 0, 12);
    self.rootLy.subviewVSpace = 12;
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.subviewVSpace = 12;
    self.contentLy.layer.cornerRadius = 8;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.rootLy addSubview:self.contentLy];
    
    MyLinearLayout *merchantLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    merchantLy.myHorzMargin = 0;
    merchantLy.myHeight = MyLayoutSize.wrap;
    merchantLy.backgroundColor = UIColor.whiteColor;
    merchantLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:merchantLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"dianpu")];
    img.myWidth = img.myHeight = 18;
    [merchantLy addSubview:img];
    
    self.marketName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.marketName.textColor = UIColor.blackColor;
    self.marketName.font = [UIFont systemFontOfSize:15];
    self.marketName.myWidth = MyLayoutSize.wrap;
    self.marketName.myHeight = 24;
    self.marketName.myLeft = 3;
    [merchantLy addSubview:self.marketName];
    
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right.myWidth = 8;
    right.myHeight = 13;
    right.myLeft = 8;
    [merchantLy addSubview:right];
    
    self.productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.productLy.myHorzMargin = 0;
    self.productLy.myHeight = MyLayoutSize.wrap;
    self.productLy.subviewVSpace = 8;
    [self.contentLy addSubview:self.productLy];
    
    //服务模块
    UITapGestureRecognizer *sendTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseSendService)];
    
    MyLinearLayout *sendServiceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    sendServiceLy.myHorzMargin = 0;
    sendServiceLy.myHeight = 48;
    sendServiceLy.gravity = MyGravity_Vert_Center;
    sendServiceLy.subviewHSpace = 8;
    [sendServiceLy addGestureRecognizer:sendTap];
    [self.contentLy addSubview:sendServiceLy];
    
    UILabel *send = [[UILabel alloc] initWithFrame:CGRectZero];
    send.text = @"配送服务";
    send.font = [UIFont systemFontOfSize:17];
    send.textColor = color_3;
    send.myWidth = send.myHeight = MyLayoutSize.wrap;
    [sendServiceLy addSubview:send];
    
    self.sendService = [[UILabel alloc] initWithFrame:CGRectZero];
    self.sendService.weight = 1;
    self.sendService.myHeight = MyLayoutSize.wrap;
    self.sendService.font = [UIFont systemFontOfSize:17];
    self.sendService.textColor = color_3;
    self.sendService.text = @"包邮";
    self.sendService.textAlignment = NSTextAlignmentRight;
    [sendServiceLy addSubview:self.sendService];
    
    //右箭头
    UIImageView *rightsend = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    rightsend.myWidth = 13;
    rightsend.myHeight = 13;
    [sendServiceLy addSubview:rightsend];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:0 tailIndent:0];
    sendServiceLy.bottomBorderline = line;
    
    UITapGestureRecognizer *manjianTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseManjian)];
    
    MyLinearLayout *manjianLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    manjianLy.myHorzMargin = 0;
    manjianLy.myHeight = 48;
    manjianLy.gravity = MyGravity_Vert_Center;
    manjianLy.subviewHSpace = 8;
    manjianLy.visibility = MyVisibility_Gone;
    [manjianLy addGestureRecognizer:manjianTap];
    [self.contentLy addSubview:manjianLy];
    
    UILabel *manjian = [[UILabel alloc] initWithFrame:CGRectZero];
    manjian.text = @"优惠券";
    manjian.font = [UIFont systemFontOfSize:17];
    manjian.textColor = color_3;
    manjian.myWidth = manjian.myHeight = MyLayoutSize.wrap;
    [manjianLy addSubview:manjian];
    
    self.manjianService = [[UILabel alloc] initWithFrame:CGRectZero];
    self.manjianService.weight = 1;
    self.manjianService.myHeight = MyLayoutSize.wrap;
    self.manjianService.font = [UIFont systemFontOfSize:17];
    self.manjianService.textColor = color_9;
    self.manjianService.text = @"暂无优惠券";
    self.manjianService.textAlignment = NSTextAlignmentRight;
    [manjianLy addSubview:self.manjianService];
    
    //右箭头
    UIImageView *right1 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right1.myWidth = 13;
    right1.myHeight = 13;
    [manjianLy addSubview:right1];
    
    MyBorderline *line1 = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:0 tailIndent:0];
    manjianLy.bottomBorderline = line1;
    
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseManjian)];
    
    MyLinearLayout *messageLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    messageLy.myHorzMargin = 0;
    messageLy.myHeight = 48;
    messageLy.gravity = MyGravity_Vert_Center;
    messageLy.subviewHSpace = 8;
    [messageLy addGestureRecognizer:messageTap];
    [self.contentLy addSubview:messageLy];
    
    UILabel *messageTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    messageTitle.text = @"留言备注";
    messageTitle.font = [UIFont systemFontOfSize:17];
    messageTitle.textColor = color_3;
    messageTitle.myWidth = messageTitle.myHeight = MyLayoutSize.wrap;
    [messageLy addSubview:messageTitle];
    
    self.message = [[UILabel alloc] initWithFrame:CGRectZero];
    self.message.weight = 1;
    self.message.myHeight = MyLayoutSize.wrap;
    self.message.font = [UIFont systemFontOfSize:17];
    self.message.textColor = color_9;
    self.message.text = @"无备注";
    self.message.textAlignment = NSTextAlignmentRight;
    [messageLy addSubview:self.message];
    
    //右箭头
    UIImageView *right2 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-black")];
    right2.myWidth = 13;
    right2.myHeight = 13;
    [messageLy addSubview:right2];
    
}
- (void)initProcductItemWithShopCarItemModel:(ShopCarItemModel *)model{
    
    MyLinearLayout *productItemLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    productItemLy.myHorzMargin = 0;
    productItemLy.myHeight = MyLayoutSize.wrap;
    productItemLy.backgroundColor = UIColor.whiteColor;
    productItemLy.gravity = MyGravity_Vert_Center;
    [self.productLy addSubview:productItemLy];
    
    UIImageView *productImage = [[UIImageView alloc] initWithFrame:CGRectZero];
    [productImage sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    productImage.myWidth = productImage.myHeight = 72;
    productImage.layer.cornerRadius = 4;
    productImage.layer.masksToBounds = YES;
    [productItemLy addSubview:productImage];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.myWidth = ScreenWidth - 60 - 72;
    infoLy.myHeight = MyLayoutSize.wrap;
    infoLy.subviewVSpace = 8;
    infoLy.myLeft = 12;
    [productItemLy addSubview:infoLy];
    
    UILabel *productName = [[UILabel alloc] initWithFrame:CGRectZero];
    productName.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    productName.textColor = color_3;
    productName.text = model.goodsName;
    productName.myHorzMargin = 0;
    productName.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:productName];
    
    MyLinearLayout *skuLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    skuLy.myHorzMargin = 0;
    skuLy.myHeight = 20;
    skuLy.gravity = MyGravity_Vert_Center;
    [infoLy addSubview:skuLy];
    
    UILabel *sku = [[UILabel alloc] initWithFrame:CGRectZero];
    sku.font = [UIFont systemFontOfSize:11];
    sku.textColor = color_6;
    sku.text = model.skuName;
    sku.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    sku.myWidth = MyLayoutSize.wrap;
    sku.myHeight = 20;
    sku.layer.cornerRadius = 10;
    sku.layer.masksToBounds = YES;
    [skuLy addSubview:sku];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 20;
    [skuLy addSubview:nilView1];
    
    UILabel *productNum = [[UILabel alloc] initWithFrame:CGRectZero];
    productNum.text = NSStringFormat(@"x%@",model.quantity);
    productNum.font = [UIFont systemFontOfSize:15];
    productNum.textColor = color_6;
    productNum.myWidth = productNum.myHeight = MyLayoutSize.wrap;
    [skuLy addSubview:productNum];
    
    MyLinearLayout *priceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    priceLy.myHorzMargin = 0;
    priceLy.myHeight = MyLayoutSize.wrap;
    priceLy.gravity = MyGravity_Vert_Center;
    priceLy.subviewHSpace = 8;
    [infoLy addSubview:priceLy];
    
    UILabel *productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    productPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    productPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    productPrice.text = NSStringFormat(@"¥%.2f",model.priceSale);
    productPrice.myHeight = productPrice.myWidth = MyLayoutSize.wrap;
    [priceLy addSubview:productPrice];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:productPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:NSMakeRange(0, 1)];
    productPrice.attributedText = attr;
    
    UILabel *oldPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    oldPrice.font = [UIFont fontWithName:@"DIN-Medium" size:11];
    oldPrice.textColor = color_9;
    oldPrice.myWidth = oldPrice.myHeight = MyLayoutSize.wrap;
    oldPrice.text = NSStringFormat(@"¥%.2f",model.priceMark);;
    [priceLy addSubview:oldPrice];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];;
}
@end
