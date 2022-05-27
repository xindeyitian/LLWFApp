//
//  OrderFooterView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "OrderFooterView.h"
#import "AfterSaleFirstViewController.h"
#import "AfterSaleProgressViewController.h"
#import "OrderDetailViewController.h"
#import "AfterSaleProgressViewController.h"

@interface OrderFooterView()

@property (strong, nonatomic) MyLinearLayout *rootLy, *priceLy, *contentLy, *gxzLy, *btnLy;
@property (strong, nonatomic) UILabel        *allPrice, *youhui, *payNum, *gxz;
@property (strong, nonatomic) UIButton       *leftBtn, *middleBtn ,*rightBtn;
@property (strong, nonatomic) OrderModel     *orderModel;
@property (strong, nonatomic) AfterSaleModel *afterSaleModel;

@end

@implementation OrderFooterView

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
            
        }
            break;
        case 9:
        {
            
        }
            break;
        default:
            break;
    }
}

- (void)rightBtnLCicked:(UIButton *)sender{
    
    if (self.orderModel) {
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
    }else{
        
        AfterSaleProgressViewController *vc = [[AfterSaleProgressViewController alloc] init];
        vc.model = self.afterSaleModel;
        [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
    }
}
- (void)setFooterWithModel:(OrderModel *)model{
    
    self.orderModel = model;
    self.allPrice.text = model.totalMoneyOrder;
    self.youhui.text = model.totalMoneysub > 0 ? NSStringFormat(@"%.2f",model.totalMoneysub) : @"0";
    self.payNum.text = NSStringFormat(@"¥%@",model.totalMoneyPayed);
    if (model.contributionValue.length) {
        
        self.gxz.text = NSStringFormat(@"确认收货后%@贡献值到账",model.contributionValue);
    }else{
        self.gxzLy.visibility = MyVisibility_Gone;
    }
    //订单状态（0上门定制、1待支付默认，2待发货、3待收货，9完成，-1客户取消、-2管理员取消、-3待退货、-4已部分退货、-5已全部退货）
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
//            [self.leftBtn setTitle:@"申请售后" forState:UIControlStateNormal];
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
    
    //    添加刷新标记
    [self setNeedsLayout];
    //    让当前ruloop立即刷新（不调用这个方法不会立即刷新 会等到View Drawing Cycle循环到这里时才刷新）
    [self layoutIfNeeded];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.contentLy.bounds   byRoundingCorners:UIRectCornerBottomLeft   |   UIRectCornerBottomRight    cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.contentLy.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.contentLy.layer.mask = maskLayer1;
}
- (void)setFooterWithAfterSaleModel:(AfterSaleModel *)model{
    
    self.afterSaleModel = model;
    self.priceLy.visibility = MyVisibility_Gone;
    self.leftBtn.visibility = MyVisibility_Gone;
    self.gxzLy.visibility = MyVisibility_Gone;
    [self.rightBtn setTitle:@"售后进度" forState:UIControlStateNormal];
    //    添加刷新标记
    [self setNeedsLayout];
    //    让当前ruloop立即刷新（不调用这个方法不会立即刷新 会等到View Drawing Cycle循环到这里时才刷新）
    [self layoutIfNeeded];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:self.contentLy.bounds   byRoundingCorners:UIRectCornerBottomLeft   |   UIRectCornerBottomRight    cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = self.contentLy.bounds;
    maskLayer1.path = maskPath1.CGPath;
    self.contentLy.layer.mask = maskLayer1;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
- (void)goToOrderDetail{
    
    if (self.orderModel) {
        
        OrderDetailViewController *vc = [[OrderDetailViewController alloc] init];
        vc.orderID = self.orderModel.djlsh;
        [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
    }
}
- (void)initCustomView{

    UITapGestureRecognizer *goToDetail = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToOrderDetail)];
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.rootLy.padding = UIEdgeInsetsMake(0, 0, 0, 0);
    [self.rootLy addGestureRecognizer:goToDetail];
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.subviewVSpace = 15;
    [self.rootLy addSubview:self.contentLy];
    
    self.priceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.priceLy.myHorzMargin = 0;
    self.priceLy.myHeight = 20;
    self.priceLy.gravity = MyGravity_Vert_Bottom;
    [self.contentLy addSubview:self.priceLy];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 20;
    [self.priceLy addSubview:nilView];
    
    UILabel *zj = [[UILabel alloc] initWithFrame:CGRectZero];
    zj.text = @"总价 ¥";
    zj.font = [UIFont systemFontOfSize:13];
    zj.textColor = color_9;
    zj.myWidth = zj.myHeight = MyLayoutSize.wrap;
    [self.priceLy addSubview:zj];
    
    self.allPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.allPrice.font = [UIFont fontWithName:@"DIN-Medium" size:13];
    self.allPrice.textColor = color_9;
    self.allPrice.text = @"289.74";
    self.allPrice.myWidth = self.allPrice.myHeight = MyLayoutSize.wrap;
    [self.priceLy addSubview:self.allPrice];
    
    UILabel *yh = [[UILabel alloc] initWithFrame:CGRectZero];
    yh.text = @"优惠 ¥";
    yh.font = [UIFont systemFontOfSize:13];
    yh.textColor = color_9;
    yh.myWidth = yh.myHeight = MyLayoutSize.wrap;
    yh.myLeft = 8;
    [self.priceLy addSubview:yh];
    
    self.youhui = [[UILabel alloc] initWithFrame:CGRectZero];
    self.youhui.font = [UIFont fontWithName:@"DIN-Medium" size:13];
    self.youhui.textColor = color_9;
    self.youhui.text = @"89.74";
    self.youhui.myWidth = self.youhui.myHeight = MyLayoutSize.wrap;
    [self.priceLy addSubview:self.youhui];
    
    UILabel *sfk = [[UILabel alloc] initWithFrame:CGRectZero];
    sfk.text = @"实付款 ";
    sfk.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    sfk.textColor = color_3;
    sfk.myWidth = sfk.myHeight = MyLayoutSize.wrap;
    sfk.myLeft = 8;
    [self.priceLy addSubview:sfk];
    
    self.payNum = [[UILabel alloc] initWithFrame:CGRectZero];
    self.payNum.font = [UIFont fontWithName:@"DIN-Medium" size:13];
    self.payNum.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.payNum.text = @"¥200.74";
    self.payNum.myWidth = self.payNum.myHeight = MyLayoutSize.wrap;
    [self.priceLy addSubview:self.payNum];
    
    self.gxzLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.gxzLy.myHorzMargin = 0;
    self.gxzLy.myHeight = MyLayoutSize.wrap;
    self.gxzLy.gravity = MyGravity_Vert_Center | MyGravity_Horz_Right;
    self.gxzLy.subviewHSpace = 4;
    [self.contentLy addSubview:self.gxzLy];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"qianbao")];
    img.myWidth = 10;
    img.myHeight = 12;
    [self.gxzLy addSubview:img];
    
    self.gxz = [BaseLabel CreateBaseLabelStr:@"确认收货后278贡献值到账" Font:[UIFont systemFontOfSize:12] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.gxz.myWidth = self.gxz.myHeight = MyLayoutSize.wrap;
    [self.gxzLy addSubview:self.gxz];
    
    self.btnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.btnLy.myHeight = MyLayoutSize.wrap;
    self.btnLy.myHorzMargin = 0;
    self.btnLy.subviewHSpace = 12;
    self.btnLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:self.btnLy];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 0;
    [self.btnLy addSubview:nilView1];
    
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
//    [btnLy addSubview:self.middleBtn];
    
    self.rightBtn = [BaseButton CreateBaseButtonTitle:@"去付款" Target:self Action:@selector(rightBtnLCicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:[UIColor colorWithHexString:@"#E61F10"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.rightBtn.myWidth = 72;
    self.rightBtn.myHeight = 25;
    self.rightBtn.layer.cornerRadius = 12.5;
    self.rightBtn.layer.masksToBounds = YES;
    self.rightBtn.layer.borderColor = [UIColor colorWithHexString:@"#E61F10"].CGColor;
    self.rightBtn.layer.borderWidth = 0.5;
    [self.btnLy addSubview:self.rightBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
