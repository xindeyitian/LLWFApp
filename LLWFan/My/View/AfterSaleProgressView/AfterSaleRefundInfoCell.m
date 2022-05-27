//
//  AfterSaleRefundInfoCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/28.
//

#import "AfterSaleRefundInfoCell.h"

@interface AfterSaleRefundInfoCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *refundTypeLy, *expressageLy, *expressageIDLy;
@property (strong, nonatomic) UILabel        *refundReasion, *refundPrice, *notice, *refundType, *expressage, *expressageID, *time, *applyID;
@property (weak,   nonatomic) LSTPopView     *pop;
@property (strong, nonatomic) AfterSaleDetailModel *detailModel;

@end

@implementation AfterSaleRefundInfoCell
- (void)initCellWithModel:(AfterSaleDetailModel *)model{
    
    self.detailModel = model;
    if (model.applyType == 1) {
        self.expressageLy.visibility = self.refundTypeLy.visibility = self.expressageIDLy.visibility = MyVisibility_Gone;
        self.refundReasion.text = model.applyReason;
        self.refundPrice.text = NSStringFormat(@"¥%.2f",model.moneyBackValue);
        self.notice.text = NSStringFormat(@"不可修改，最多￥%.2f",model.moneyBackValue);
        self.time.text = model.orderTime;
        self.applyID.text = model.applyId;
    }else{
        self.refundReasion.text = model.applyReason;
        self.refundPrice.text = NSStringFormat(@"¥%.2f",model.moneyBackValue);
        self.notice.text = NSStringFormat(@"不可修改，最多￥%.2f",model.moneyBackValue);
        self.time.text = model.orderTime;
        self.applyID.text = model.applyId;
        switch (model.dealSign) {
            case 1:
            {
                self.expressageLy.visibility = self.expressageIDLy.visibility = MyVisibility_Gone;
            }
                break;
            case 2:
            {
                self.expressageLy.visibility = self.expressageIDLy.visibility = MyVisibility_Gone;
            }
                break;
            default:
                break;
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
    
    UILabel *refundInfoLable = [BaseLabel CreateBaseLabelStr:@"退款信息" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    refundInfoLable.myWidth = refundInfoLable.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:refundInfoLable];
    //退款原因
    MyLinearLayout *refundReasionLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    refundReasionLy.myHorzMargin = 0;
    refundReasionLy.myHeight = MyLayoutSize.wrap;
    refundReasionLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:refundReasionLy];
    
    UILabel *refundReasionLable = [BaseLabel CreateBaseLabelStr:@"退款原因" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    refundReasionLable.weight = 1;
    refundReasionLable.myHeight = MyLayoutSize.wrap;
    [refundReasionLy addSubview:refundReasionLable];
    
    self.refundReasion = [BaseLabel CreateBaseLabelStr:@"我不想要了" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.refundReasion.myWidth = self.refundReasion.myHeight = MyLayoutSize.wrap;
    [refundReasionLy addSubview:self.refundReasion];
    
    MyLinearLayout *refundPriceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    refundPriceLy.myHorzMargin = 0;
    refundPriceLy.myHeight = MyLayoutSize.wrap;
    refundPriceLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:refundPriceLy];
    //退款金额
    UILabel *refundPriceTitle = [BaseLabel CreateBaseLabelStr:@"退款金额" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    refundPriceTitle.weight = 1;
    refundPriceTitle.myHeight = MyLayoutSize.wrap;
    [refundPriceLy addSubview:refundPriceTitle];
    
    self.refundPrice = [BaseLabel CreateBaseLabelStr:@"¥99.99" Font:[UIFont fontWithName:@"DIN-Medium" size:15] Color:[UIColor colorWithHexString:@"#FF3B30"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.refundPrice.myHeight = self.refundPrice.myWidth = MyLayoutSize.wrap;
    [refundPriceLy addSubview:self.refundPrice];
    //提示
    self.notice = [BaseLabel CreateBaseLabelStr:@"不可修改，最多￥199.00" Font:[UIFont systemFontOfSize:13] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    self.notice.myHorzMargin = 0;
    self.notice.myHeight = MyLayoutSize.wrap;
    self.notice.numberOfLines = 0;
    [contentLy addSubview:self.notice];
    
    //退货方式
    self.refundTypeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.refundTypeLy.myHorzMargin = 0;
    self.refundTypeLy.myHeight = MyLayoutSize.wrap;
    self.refundTypeLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:self.refundTypeLy];
    
    UILabel *refundTypeLable = [BaseLabel CreateBaseLabelStr:@"退货方式" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    refundTypeLable.weight = 1;
    refundTypeLable.myHeight = MyLayoutSize.wrap;
    [self.refundTypeLy addSubview:refundTypeLable];
    
    UILabel *refundType = [BaseLabel CreateBaseLabelStr:@"快递" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    refundType.myWidth = refundType.myHeight = MyLayoutSize.wrap;
    [self.refundTypeLy addSubview:refundType];
    
    //快递公司
    self.expressageLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.expressageLy.myHorzMargin = 0;
    self.expressageLy.myHeight = MyLayoutSize.wrap;
    self.expressageLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:self.expressageLy];
    
    UILabel *expressageLable = [BaseLabel CreateBaseLabelStr:@"快递公司" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    expressageLable.weight = 1;
    expressageLable.myHeight = MyLayoutSize.wrap;
    [self.expressageLy addSubview:expressageLable];
    
    self.expressage = [BaseLabel CreateBaseLabelStr:@"请点击选择寄回快递公司" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.expressage.myWidth = self.expressage.myHeight = MyLayoutSize.wrap;
    [self.expressageLy addSubview:self.expressage];
    
    //快递单号
    self.expressageIDLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.expressageIDLy.myHorzMargin = 0;
    self.expressageIDLy.myHeight = MyLayoutSize.wrap;
    self.expressageIDLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:self.expressageIDLy];
    
    UILabel *expressageIDLable = [BaseLabel CreateBaseLabelStr:@"快递单号" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    expressageIDLable.weight = 1;
    expressageIDLable.myHeight = MyLayoutSize.wrap;
    [self.expressageIDLy addSubview:expressageIDLable];
    
    self.expressageID = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.expressageID.myWidth = self.expressageID.myHeight = MyLayoutSize.wrap;
    [self.expressageIDLy addSubview:self.expressageID];
    
    //固定时间Ly
    MyLinearLayout *timeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    timeLy.myHorzMargin = 0;
    timeLy.myHeight = MyLayoutSize.wrap;
    timeLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:timeLy];
    
    UILabel *timeLable = [BaseLabel CreateBaseLabelStr:@"申请时间" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    timeLable.weight = 1;
    timeLable.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:timeLable];
    
    self.time = [BaseLabel CreateBaseLabelStr:@"2022-04-29" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.time.myWidth = self.time.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:self.time];
    
    //固定申请编号Ly
    MyLinearLayout *applyIDLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    applyIDLy.myHorzMargin = 0;
    applyIDLy.myHeight = MyLayoutSize.wrap;
    applyIDLy.gravity = MyGravity_Vert_Center;
    [contentLy addSubview:applyIDLy];
    
    UILabel *applyIDLable = [BaseLabel CreateBaseLabelStr:@"申请编号" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    applyIDLable.weight = 1;
    applyIDLable.myHeight = MyLayoutSize.wrap;
    [applyIDLy addSubview:applyIDLable];
    
    self.applyID = [BaseLabel CreateBaseLabelStr:@"123312123321" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.applyID.myWidth = self.applyID.myHeight = MyLayoutSize.wrap;
    [applyIDLy addSubview:self.applyID];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
