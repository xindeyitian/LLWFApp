//
//  RefundInfoCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/27.
//

#import "RefundInfoCell.h"
#import "ShouHuoStatusPopView.h"

@interface RefundInfoCell()
{
    NSString  *_shouhuoType, *_resion;
    NSInteger _refundType;
}
@property (strong, nonatomic) MyLinearLayout *rootLy, *goodsStatusLy, *refundTypeLy, *sendTypeLy;
@property (strong, nonatomic) UILabel        *goodsStatus, *salesReturnStatus, *refundPrice, *notice;
@property (weak, nonatomic)   LSTPopView     *popView;

@end

@implementation RefundInfoCell
- (void)setCellWithType:(NSInteger)refundType AndItemModel:(OrderItemModel *)model{
    
    _refundType = refundType;
    if (refundType) {
        //退货退款
        self.goodsStatusLy.visibility = MyVisibility_Gone;
        self.sendTypeLy.visibility = MyVisibility_Visible;
    }else{
        //仅退款
        self.goodsStatusLy.visibility = MyVisibility_Visible;
        self.sendTypeLy.visibility = MyVisibility_Gone;
    }
    self.refundPrice.text = NSStringFormat(@"¥%.2f",model.moneyPayed);
    self.notice.text = NSStringFormat(@"不可修改，最多￥%.2f",model.moneyPayed);
}
- (void)chooseGoodsStatus{
    
    ShouHuoStatusPopView *view = [[ShouHuoStatusPopView alloc] initWithFrame:CGRectZero AndType:WhetherReceived];
    view.frame = CGRectMake(0, 0, ScreenWidth, [view.rootLy sizeThatFits:CGSizeMake(ScreenWidth, MAXFLOAT)].height);
    LSTPopView *pop = [LSTPopView initWithCustomView:view popStyle:LSTPopStyleSpringFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
    LSTPopViewWK(pop)
    pop.hemStyle = LSTHemStyleBottom;
    pop.popDuration = 0.25;
    pop.dismissDuration = 0.5;
    pop.isClickFeedback = YES;
    pop.bgClickBlock = ^{
        NSLog(@"点击了背景");
        [wk_pop dismiss];
    };
    self.popView = pop;
    [self.popView pop];
    weakSelf(self)
    view.chooseTypeBlock = ^(NSString * _Nonnull type) {
        
        weakSelf.goodsStatus.text = type;
        weakSelf.goodsStatus.textColor = color_3;
        weakSelf.salesReturnStatus.text = @"请选择";
        weakSelf.salesReturnStatus.textColor = color_9;
        if (weakSelf.returnRefundStatue) {
            
            weakSelf.returnRefundStatue(type, @"");
        }
        [weakSelf.popView dismiss];
    };
    view.cancleBlock = ^{
        
        [weakSelf.popView dismiss];
    };
}
- (void)chooseSalesReturn{
    
    if (_refundType) {
        //1:退货退款
        
        ShouHuoStatusPopView *view = [[ShouHuoStatusPopView alloc] initWithFrame:CGRectZero AndType:Received];
        view.frame = CGRectMake(0, 0, ScreenWidth, [view.rootLy sizeThatFits:CGSizeMake(ScreenWidth, MAXFLOAT)].height);

        LSTPopView *pop = [LSTPopView initWithCustomView:view popStyle:LSTPopStyleSpringFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
        LSTPopViewWK(pop)
        pop.hemStyle = LSTHemStyleBottom;
        pop.popDuration = 0.25;
        pop.dismissDuration = 0.5;
        pop.isClickFeedback = YES;
        pop.bgClickBlock = ^{
            NSLog(@"点击了背景");
            [wk_pop dismiss];
        };
        
        [pop pop];
        weakSelf(self)
        view.chooseTypeBlock = ^(NSString * _Nonnull type) {
            
            weakSelf.salesReturnStatus.text = type;
            weakSelf.salesReturnStatus.textColor = color_3;
            if (weakSelf.returnRefundStatue) {
                
                weakSelf.returnRefundStatue(@"", type);
            }
            [pop dismiss];
        };
        view.cancleBlock = ^{
            
            [pop dismiss];
        };
    }else{
        //0:仅退款
        if ([self.goodsStatus.text isEqualToString:@"请选择"]) {
            
            [self chooseGoodsStatus];
        }else{
            
            ShouHuoStatusPopView *view;
            if ([self.goodsStatus.text isEqualToString:@"已收货"]){
                
                view = [[ShouHuoStatusPopView alloc] initWithFrame:CGRectZero AndType:Received];
                view.frame = CGRectMake(0, 0, ScreenWidth, [view.rootLy sizeThatFits:CGSizeMake(ScreenWidth, MAXFLOAT)].height);
            }else{
                
                view = [[ShouHuoStatusPopView alloc] initWithFrame:CGRectZero AndType:NoReceived];
                view.frame = CGRectMake(0, 0, ScreenWidth, [view.rootLy sizeThatFits:CGSizeMake(ScreenWidth, MAXFLOAT)].height);
            }
            LSTPopView *pop = [LSTPopView initWithCustomView:view popStyle:LSTPopStyleSpringFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
            LSTPopViewWK(pop)
            pop.hemStyle = LSTHemStyleBottom;
            pop.popDuration = 0.25;
            pop.dismissDuration = 0.5;
            pop.isClickFeedback = YES;
            pop.bgClickBlock = ^{
                NSLog(@"点击了背景");
                [wk_pop dismiss];
            };
            
            [pop pop];
            weakSelf(self)
            view.chooseTypeBlock = ^(NSString * _Nonnull type) {
                
                weakSelf.salesReturnStatus.text = type;
                weakSelf.salesReturnStatus.textColor = color_3;
                if (weakSelf.returnRefundStatue) {
                    
                    weakSelf.returnRefundStatue(@"", type);
                }
                [pop dismiss];
            };
            view.cancleBlock = ^{
                
                [pop dismiss];
            };
        }
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
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.padding = UIEdgeInsetsMake(12, 0, 0, 0);
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    contentLy.subviewVSpace = 12;
    contentLy.backgroundColor = UIColor.whiteColor;
    [self.rootLy addSubview:contentLy];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"退款信息" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:title];
    
    UITapGestureRecognizer *goodsStatusTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseGoodsStatus)];
    
    self.goodsStatusLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.goodsStatusLy.myHorzMargin = 0;
    self.goodsStatusLy.myHeight = MyLayoutSize.wrap;
    self.goodsStatusLy.gravity = MyGravity_Vert_Center;
//    self.goodsStatusLy.subviewHSpace = 8;
    [self.goodsStatusLy addGestureRecognizer:goodsStatusTap];
    [contentLy addSubview:self.goodsStatusLy];
    
    UILabel *goodsStatusTitle = [BaseLabel CreateBaseLabelStr:@"货物状态" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    goodsStatusTitle.weight = 1;
    goodsStatusTitle.myHeight = MyLayoutSize.wrap;
    [self.goodsStatusLy addSubview:goodsStatusTitle];
    
    self.goodsStatus = [BaseLabel CreateBaseLabelStr:@"请选择" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.goodsStatus.myWidth = self.goodsStatus.myHeight = MyLayoutSize.wrap;
    [self.goodsStatusLy addSubview:self.goodsStatus];
    
    UIImageView *goodsStatusRight = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    goodsStatusRight.myWidth = goodsStatusRight.myHeight = 18;
    [self.goodsStatusLy addSubview:goodsStatusRight];
    
    UITapGestureRecognizer *salesReturnTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseSalesReturn)];
    
    MyLinearLayout *salesReturnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    salesReturnLy.myHorzMargin = 0;
    salesReturnLy.myHeight = MyLayoutSize.wrap;
    salesReturnLy.gravity = MyGravity_Vert_Center;
//    salesReturnLy.subviewHSpace = 8;
    [salesReturnLy addGestureRecognizer:salesReturnTap];
    [contentLy addSubview:salesReturnLy];
    
    UILabel *salesReturnTitle = [BaseLabel CreateBaseLabelStr:@"退款原因" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    salesReturnTitle.weight = 1;
    salesReturnTitle.myHeight = MyLayoutSize.wrap;
    [salesReturnLy addSubview:salesReturnTitle];
    
    self.salesReturnStatus = [BaseLabel CreateBaseLabelStr:@"请选择" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.salesReturnStatus.myWidth = self.salesReturnStatus.myHeight = MyLayoutSize.wrap;
    [salesReturnLy addSubview:self.salesReturnStatus];
    
    UIImageView *salesReturnRight = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right-gray")];
    salesReturnRight.myWidth = salesReturnRight.myHeight = 18;
    [salesReturnLy addSubview:salesReturnRight];
    
    MyLinearLayout *refundPriceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    refundPriceLy.myHorzMargin = 0;
    refundPriceLy.myHeight = MyLayoutSize.wrap;
    refundPriceLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:refundPriceLy];
    
    UILabel *refundPriceTitle = [BaseLabel CreateBaseLabelStr:@"退款金额" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    refundPriceTitle.weight = 1;
    refundPriceTitle.myHeight = MyLayoutSize.wrap;
    [refundPriceLy addSubview:refundPriceTitle];
    
    self.refundPrice = [BaseLabel CreateBaseLabelStr:@"¥99.99" Font:[UIFont fontWithName:@"DIN-Medium" size:15] Color:[UIColor colorWithHexString:@"#FF3B30"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.refundPrice.myHeight = self.refundPrice.myWidth = MyLayoutSize.wrap;
    [refundPriceLy addSubview:self.refundPrice];
    
    self.notice = [BaseLabel CreateBaseLabelStr:@"不可修改，最多￥199.00" Font:[UIFont systemFontOfSize:13] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    self.notice.myHorzMargin = 0;
    self.notice.myHeight = MyLayoutSize.wrap;
    self.notice.numberOfLines = 0;
    [contentLy addSubview:self.notice];
    
    self.sendTypeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.sendTypeLy.myHorzMargin = 0;
    self.sendTypeLy.myHeight = MyLayoutSize.wrap;
    self.sendTypeLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:self.sendTypeLy];
    
    UILabel *sendLable = [BaseLabel CreateBaseLabelStr:@"退货方式" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    sendLable.weight = 1;
    sendLable.myHeight = MyLayoutSize.wrap;
    [self.sendTypeLy addSubview:sendLable];
    
    UILabel *sendType = [BaseLabel CreateBaseLabelStr:@"自行寄回" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    sendType.myWidth = sendType.myHeight = MyLayoutSize.wrap;
    [self.sendTypeLy addSubview:sendType];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
