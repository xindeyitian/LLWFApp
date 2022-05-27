//
//  PriceDetialCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "PriceDetialCell.h"

@interface PriceDetialCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *totalPrice, *discountsPrice, *carriagePrice, *allPrice, *yue, *llwf;

@end

@implementation PriceDetialCell

- (void)setCellWithModel:(UnionOrderModel *)model{
    
    self.totalPrice.text = NSStringFormat(@"¥%.2f",model.totalMoneySale);
    self.carriagePrice.text = NSStringFormat(@"¥%@",model.expressFee);
    self.yue.text = NSStringFormat(@"-¥%@",model.balanceSub);
    self.llwf.text = NSStringFormat(@"-¥%@",model.voucherSub);
    self.allPrice.text = NSStringFormat(@"¥%.2f",model.totalMoneyPayed);
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
    self.contentLy.layer.cornerRadius = 8;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.contentLy.subviewVSpace = 12;
    [self.rootLy addSubview:self.contentLy];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.text = @"价格明细";
    title.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    title.textColor = color_3;
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [self.contentLy addSubview:title];
    
    MyLinearLayout *totalPriceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    totalPriceLy.myHorzMargin = 0;
    totalPriceLy.myHeight = MyLayoutSize.wrap;
    totalPriceLy.gravity = MyGravity_Vert_Center;
    totalPriceLy.myTop = 5;
    [self.contentLy addSubview:totalPriceLy];
    
    UILabel *totalPriceTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    totalPriceTitle.text = @"商品总价";
    totalPriceTitle.font = [UIFont systemFontOfSize:15];
    totalPriceTitle.textColor = color_3;
    totalPriceTitle.myWidth = totalPriceTitle.myHeight = MyLayoutSize.wrap;
    [totalPriceLy addSubview:totalPriceTitle];
    
    self.totalPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalPrice.weight = 1;
    self.totalPrice.myHeight = MyLayoutSize.wrap;
    self.totalPrice.textAlignment = NSTextAlignmentRight;
    self.totalPrice.text = @"¥8999.87";
    self.totalPrice.textColor = color_3;
    self.totalPrice.font = [UIFont fontWithName:@"DIN-Medium" size:17];
    [totalPriceLy addSubview:self.totalPrice];
    
    NSMutableAttributedString *totalPriceAttr = [[NSMutableAttributedString alloc] initWithString:self.totalPrice.text];
    [totalPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange(0, 1)];
    [totalPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange([self.totalPrice.text rangeOfString:@"."].location + 1, 2)];
    self.totalPrice.attributedText = totalPriceAttr;
    
    MyLinearLayout *discountsPriceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    discountsPriceLy.myHorzMargin = 0;
    discountsPriceLy.myHeight = MyLayoutSize.wrap;
    discountsPriceLy.gravity = MyGravity_Vert_Center;
    discountsPriceLy.visibility = MyVisibility_Gone;
    [self.contentLy addSubview:discountsPriceLy];
    
    UILabel *discountsPriceTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    discountsPriceTitle.text = @"优惠券";
    discountsPriceTitle.font = [UIFont systemFontOfSize:15];
    discountsPriceTitle.textColor = color_3;
    discountsPriceTitle.myWidth = discountsPriceTitle.myHeight = MyLayoutSize.wrap;
    [discountsPriceLy addSubview:discountsPriceTitle];
    
    self.discountsPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.discountsPrice.weight = 1;
    self.discountsPrice.myHeight = MyLayoutSize.wrap;
    self.discountsPrice.textAlignment = NSTextAlignmentRight;
    self.discountsPrice.text = @"-¥8.89";
    self.discountsPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.discountsPrice.font = [UIFont fontWithName:@"DIN-Medium" size:15];
    [discountsPriceLy addSubview:self.discountsPrice];
    
    NSMutableAttributedString *discountsPriceAttr = [[NSMutableAttributedString alloc] initWithString:self.discountsPrice.text];
    [discountsPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range: NSMakeRange(1, 1)];
    [discountsPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange([self.discountsPrice.text rangeOfString:@"."].location + 1, 2)];
    self.discountsPrice.attributedText = discountsPriceAttr;
    
    MyLinearLayout *carriagePriceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    carriagePriceLy.myHorzMargin = 0;
    carriagePriceLy.myHeight = MyLayoutSize.wrap;
    carriagePriceLy.gravity = MyGravity_Vert_Center;
    carriagePriceLy.paddingBottom = 12;
    [self.contentLy addSubview:carriagePriceLy];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:12 tailIndent:12];
    carriagePriceLy.bottomBorderline = line;
    
    UILabel *carriagePriceTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    carriagePriceTitle.text = @"快递运费";
    carriagePriceTitle.font = [UIFont systemFontOfSize:15];
    carriagePriceTitle.textColor = color_3;
    carriagePriceTitle.myWidth = carriagePriceTitle.myHeight = MyLayoutSize.wrap;
    [carriagePriceLy addSubview:carriagePriceTitle];
    
    self.carriagePrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.carriagePrice.weight = 1;
    self.carriagePrice.myHeight = MyLayoutSize.wrap;
    self.carriagePrice.textAlignment = NSTextAlignmentRight;
    self.carriagePrice.text = @"¥0";
    self.carriagePrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.carriagePrice.font = [UIFont fontWithName:@"DIN-Medium" size:13];
    [carriagePriceLy addSubview:self.carriagePrice];
    
    MyLinearLayout *yueLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    yueLy.myHorzMargin = 0;
    yueLy.myHeight = MyLayoutSize.wrap;
    yueLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:yueLy];
    
    UILabel *yueTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    yueTitle.text = @"余额抵扣";
    yueTitle.font = [UIFont systemFontOfSize:15];
    yueTitle.textColor = color_3;
    yueTitle.myWidth = yueTitle.myHeight = MyLayoutSize.wrap;
    [yueLy addSubview:yueTitle];
    
    self.yue = [[UILabel alloc] initWithFrame:CGRectZero];
    self.yue.weight = 1;
    self.yue.myHeight = MyLayoutSize.wrap;
    self.yue.textAlignment = NSTextAlignmentRight;
    self.yue.text = @"-¥60.00";
    self.yue.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.yue.font = [UIFont fontWithName:@"DIN-Medium" size:15];
    [yueLy addSubview:self.yue];
    
    NSMutableAttributedString *yueAttr = [[NSMutableAttributedString alloc] initWithString:self.yue.text];
    [yueAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range: NSMakeRange(1, 1)];
    [yueAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange([self.yue.text rangeOfString:@"."].location + 1, 2)];
    self.yue.attributedText = yueAttr;
    
    MyLinearLayout *llwfLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    llwfLy.myHorzMargin = 0;
    llwfLy.myHeight = MyLayoutSize.wrap;
    llwfLy.gravity = MyGravity_Vert_Center;
    llwfLy.paddingBottom = 12;
    [self.contentLy addSubview:llwfLy];
    
    MyBorderline *line1 = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:12 tailIndent:12];
    llwfLy.bottomBorderline = line1;
    
    UILabel *llwfTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    llwfTitle.text = @"LLWF抵用金";
    llwfTitle.font = [UIFont systemFontOfSize:15];
    llwfTitle.textColor = color_3;
    llwfTitle.myWidth = llwfTitle.myHeight = MyLayoutSize.wrap;
    [llwfLy addSubview:llwfTitle];
    
    self.llwf = [[UILabel alloc] initWithFrame:CGRectZero];
    self.llwf.weight = 1;
    self.llwf.myHeight = MyLayoutSize.wrap;
    self.llwf.textAlignment = NSTextAlignmentRight;
    self.llwf.text = @"-¥60.00";
    self.llwf.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.llwf.font = [UIFont fontWithName:@"DIN-Medium" size:15];
    [llwfLy addSubview:self.llwf];
    
    NSMutableAttributedString *llwfAttr = [[NSMutableAttributedString alloc] initWithString:self.llwf.text];
    [llwfAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range: NSMakeRange(1, 1)];
    [llwfAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange([self.llwf.text rangeOfString:@"."].location + 1, 2)];
    self.llwf.attributedText = llwfAttr;
    
    MyLinearLayout *allPriceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    allPriceLy.myHorzMargin = 0;
    allPriceLy.myHeight = MyLayoutSize.wrap;
    allPriceLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:allPriceLy];
    
    UILabel *allPriceTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    allPriceTitle.text = @"合计";
    allPriceTitle.font = [UIFont systemFontOfSize:15];
    allPriceTitle.textColor = color_3;
    allPriceTitle.myWidth = allPriceTitle.myHeight = MyLayoutSize.wrap;
    [allPriceLy addSubview:allPriceTitle];
    
    self.allPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.allPrice.weight = 1;
    self.allPrice.myHeight = MyLayoutSize.wrap;
    self.allPrice.textAlignment = NSTextAlignmentRight;
    self.allPrice.text = @"¥8999.87";
    self.allPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.allPrice.font = [UIFont fontWithName:@"DIN-Medium" size:15];
    [allPriceLy addSubview:self.allPrice];
    
    NSMutableAttributedString *allPriceAttr = [[NSMutableAttributedString alloc] initWithString:self.allPrice.text];
    [allPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange(0, 1)];
    [allPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Medium" size:13] range:NSMakeRange([self.allPrice.text rangeOfString:@"."].location + 1, 2)];
    self.allPrice.attributedText = allPriceAttr;
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];;
}
@end
