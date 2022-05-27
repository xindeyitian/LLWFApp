//
//  OrderDetailBottomView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/15.
//

#import "OrderDetailBottomView.h"

@interface OrderDetailBottomView()
{
    BOOL _isAgree;
}
@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UILabel        *totalPrice;
@property (strong, nonatomic) UIButton       *commitBtn, *yinsiBtn;


@end

@implementation OrderDetailBottomView
- (void)agree:(UIButton *)sender{
    
    if (sender.selected) {
        
        [sender setImage:IMAGE_NAMED(@"rightChoose") forState:UIControlStateNormal];
    }else{
        [sender setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
    }
    sender.selected = !sender.isSelected;
    _isAgree = sender.isSelected;
    [UIButton setNewVesionBtnEnabeld:self.commitBtn status:_isAgree];
}
- (void)commitOrder{
    
    if (!_isAgree) {
        
        shakeView(self.yinsiBtn.layer);
        return;
    }
    [MBProgressHUD showHUDAddedTo:self.currentViewController.view animated:YES];
    [THHttpManager submitOrderWithPayMethod:self.model.payType AndUnionOrderId:self.model.unionOrderId AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
        }else{
            
            [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
        }
    }];
}
- (void)setModel:(UnionOrderModel *)model{
    
    _model = model;
    self.totalPrice.text = NSStringFormat(@"¥%.2f",model.totalMoneyPayed);
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
        _isAgree = NO;
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = 85 + TabbarSafeBottomMargin;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.rootLy];
    
    self.yinsiBtn = [BaseButton CreateBaseButtonTitle:@"我已阅读并同意《购买守则》《取消政策》和《退款政策》我也同意支付以下所示的总金额（含服务费）" Target:self Action:@selector(agree:) Font:[UIFont systemFontOfSize:12] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"rightChoose" HeightLightBackgroundImage:@"rightChoose"];
    [self.yinsiBtn setTitleColor:color_9 forState:UIControlStateNormal];
    self.yinsiBtn.myHorzMargin = 12;
    self.yinsiBtn.myHeight = MyLayoutSize.wrap;
    self.yinsiBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.yinsiBtn.imageEdgeInsets = UIEdgeInsetsMake(-10, -10, 0, 0);
    self.yinsiBtn.myTop = 15;
    [self.rootLy addSubview:self.yinsiBtn];
    
    NSMutableAttributedString *yinsittr = [[NSMutableAttributedString alloc] initWithString:self.yinsiBtn.titleLabel.text];
    [yinsittr addAttribute:NSForegroundColorAttributeName value:[UIColor colorNamed:@"color-red"] range:NSMakeRange(7, 6)];
    [yinsittr addAttribute:NSForegroundColorAttributeName value:[UIColor colorNamed:@"color-red"] range:NSMakeRange(13,6)];
    [yinsittr addAttribute:NSForegroundColorAttributeName value:[UIColor colorNamed:@"color-red"] range:NSMakeRange(20,6)];
//    yinsiBtn.titleLabel.attributedText = yinsittr;
    [self.yinsiBtn setAttributedTitle:yinsittr forState:UIControlStateNormal];
    
    [self.yinsiBtn.titleLabel yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(7, 6)),NSStringFromRange(NSMakeRange(13, 6)),NSStringFromRange(NSMakeRange(20, 6))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
//        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
//
//        [self presentViewController:pvc animated:YES completion:nil];
    }];
    
    MyLinearLayout *totalPriceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    totalPriceLy.myHorzMargin = 0;
    totalPriceLy.myHeight = 50;
    totalPriceLy.gravity = MyGravity_Vert_Center;
    totalPriceLy.backgroundColor = UIColor.whiteColor;
    totalPriceLy.myTop = 8;
    totalPriceLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    [self.rootLy addSubview:totalPriceLy];
    
    UILabel *heji = [[UILabel alloc] initWithFrame:CGRectZero];
    heji.text = @"合计:";
    heji.font = [UIFont systemFontOfSize:15];
    heji.textColor = color_3;
    heji.myWidth = heji.myHeight = MyLayoutSize.wrap;
    [totalPriceLy addSubview:heji];
    
    self.totalPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.totalPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    self.totalPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.totalPrice.text = @"¥0.00";
    self.totalPrice.weight = 1;
    self.totalPrice.myHeight = MyLayoutSize.wrap;
    self.totalPrice.myLeft = 8;
    [totalPriceLy addSubview:self.totalPrice];
    
    NSMutableAttributedString *totalPriceAttr = [[NSMutableAttributedString alloc] initWithString:self.totalPrice.text];
    [totalPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Bold" size:13] range:NSMakeRange(0, 1)];
    [totalPriceAttr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Bold" size:13] range:NSMakeRange([self.totalPrice.text rangeOfString:@"."].location + 1, 2)];
    self.totalPrice.attributedText = totalPriceAttr;
    
    self.commitBtn = [BaseButton CreateBaseButtonTitle:@"提交订单" Target:self Action:@selector(commitOrder) Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.commitBtn.alpha = 0.4;
    self.commitBtn.myWidth = 108;
    self.commitBtn.myHeight = 40;
    self.commitBtn.layer.cornerRadius = 20;
    self.commitBtn.layer.masksToBounds = YES;
    [totalPriceLy addSubview:self.commitBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];;
}
@end
