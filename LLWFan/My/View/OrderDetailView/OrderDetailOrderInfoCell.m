//
//  OrderDetailOrderInfoCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/26.
//

#import "OrderDetailOrderInfoCell.h"

@interface OrderDetailOrderInfoCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy, *payLy, *fahuoLy, *successLy;
@property (strong, nonatomic) UILabel        *orderID, *createTime, *payTime, *fahuoTime, *successTime, *yunfei, *youhui, *totalPayNum;
@property (strong, nonatomic) UILabel        *payTimeLable;//取消时间/付款时间

@end

@implementation OrderDetailOrderInfoCell
- (void)setCellWithModel:(OrderModel *)model{
    
    //订单状态（0上门定制、1待支付默认，2待发货、3待收货，9完成，-1客户取消、-2管理员取消、-3待退货、-4已部分退货、-5已全部退货）
    self.orderID.text = model.orderNo;
    self.createTime.text = model.orderTime;
    self.yunfei.text = NSStringFormat(@"¥%@",model.expressFee);
    self.youhui.text = NSStringFormat(@"¥%.2f",model.totalMoneysub);
    self.totalPayNum.text = NSStringFormat(@"实付款：¥%@",model.totalMoneyPayed);
    switch (model.orderState) {
        case 1:
        {
            self.payLy.visibility = MyVisibility_Gone;
            self.fahuoLy.visibility = MyVisibility_Gone;
            self.successLy.visibility = MyVisibility_Gone;
        }
            break;
        case 2:
        {
            self.payTime.text = model.payTime;
            self.fahuoLy.visibility = MyVisibility_Gone;
            self.successLy.visibility = MyVisibility_Gone;
        }
            break;
        case 3:
        {
            self.payTime.text = model.payTime;
            self.fahuoTime.text = model.deliveryDate;
            self.successLy.visibility = MyVisibility_Gone;
        }
            break;
        case 9:
        {
            self.payTime.text = model.payTime;
            self.fahuoTime.text = model.deliveryDate;
            self.successTime.text = model.updateTime;
        }
            break;
        case -1:
        {
            self.payTimeLable.text = @"取消时间";
            self.payTime.text = model.payTime;
            self.fahuoLy.visibility = MyVisibility_Gone;
            self.successLy.visibility = MyVisibility_Gone;
        }
            break;
        case -2:
        {
            self.payTimeLable.text = @"取消时间";
            self.payTime.text = model.payTime;
            self.successLy.visibility = MyVisibility_Gone;
            self.successLy.visibility = MyVisibility_Gone;
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
    self.contentLy.subviewVSpace = 12;
    [self.rootLy addSubview:self.contentLy];
    
    MyLinearLayout *orderIDLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    orderIDLy.myHorzMargin = 0;
    orderIDLy.myHeight = MyLayoutSize.wrap;
    orderIDLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:orderIDLy];
    
    UILabel *idLable = [BaseLabel CreateBaseLabelStr:@"订单编号：" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    idLable.myWidth = idLable.myHeight = MyLayoutSize.wrap;
    [orderIDLy addSubview:idLable];
    
    self.orderID = [BaseLabel CreateBaseLabelStr:@"232977024042" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.orderID.myWidth = self.orderID.myHeight = MyLayoutSize.wrap;
    [orderIDLy addSubview:self.orderID];
    
    UIButton *idCopyBtn = [BaseButton CreateBaseButtonTitle:@"复制" Target:self Action:@selector(copyOrderID) Font:[UIFont systemFontOfSize:12] BackgroundColor:[UIColor colorWithHexString:@"#EDEDED"] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    idCopyBtn.myWidth = 40;
    idCopyBtn.myHeight = 20;
    idCopyBtn.myLeft = 12;
    ViewBorderRadius(idCopyBtn, 10, 1, UIColor.whiteColor);
    [orderIDLy addSubview:idCopyBtn];
    //
    MyLinearLayout *creatLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    creatLy.myHorzMargin = 0;
    creatLy.myHeight = MyLayoutSize.wrap;
    creatLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:creatLy];
    
    UILabel *createTimeLable = [BaseLabel CreateBaseLabelStr:@"创建时间：" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    createTimeLable.myWidth = createTimeLable.myHeight = MyLayoutSize.wrap;
    [creatLy addSubview:createTimeLable];
    
    self.createTime = [BaseLabel CreateBaseLabelStr:@"2021-11-24 18:02:52" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.createTime.myWidth = self.createTime.myHeight = MyLayoutSize.wrap;
    [creatLy addSubview:self.createTime];
    //
    self.payLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.payLy.myHorzMargin = 0;
    self.payLy.myHeight = MyLayoutSize.wrap;
    self.payLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:self.payLy];
    
    self.payTimeLable = [BaseLabel CreateBaseLabelStr:@"付款时间：" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.payTimeLable.myWidth = self.payTimeLable.myHeight = MyLayoutSize.wrap;
    [self.payLy addSubview:self.payTimeLable];
    
    self.payTime = [BaseLabel CreateBaseLabelStr:@"2021-11-24 18:02:52" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.payTime.myWidth = self.payTime.myHeight = MyLayoutSize.wrap;
    [self.payLy addSubview:self.payTime];
    //
    self.fahuoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.fahuoLy.myHorzMargin = 0;
    self.fahuoLy.myHeight = MyLayoutSize.wrap;
    self.fahuoLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:self.fahuoLy];
    
    UILabel *fahuoLable = [BaseLabel CreateBaseLabelStr:@"发货时间：" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    fahuoLable.myWidth = fahuoLable.myHeight = MyLayoutSize.wrap;
    [self.fahuoLy addSubview:fahuoLable];
    
    self.fahuoTime = [BaseLabel CreateBaseLabelStr:@"2021-11-24 18:02:52" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.fahuoTime.myWidth = self.fahuoTime.myHeight = MyLayoutSize.wrap;
    [self.fahuoLy addSubview:self.fahuoTime];
    //
    self.successLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.successLy.myHorzMargin = 0;
    self.successLy.myHeight = MyLayoutSize.wrap;
    self.successLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:self.successLy];
    
    UILabel *successLable = [BaseLabel CreateBaseLabelStr:@"成交时间：" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    successLable.myWidth = successLable.myHeight = MyLayoutSize.wrap;
    [self.successLy addSubview:successLable];
    
    self.successTime = [BaseLabel CreateBaseLabelStr:@"2021-11-24 18:02:52" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.successTime.myWidth = self.successTime.myHeight = MyLayoutSize.wrap;
    [self.successLy addSubview:self.successTime];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectZero];
    line.myHorzMargin = 0;
    line.myHeight = 0.5;
    line.backgroundColor = [UIColor colorWithHexString:@"#EEEEEE"];
    line.myTop = -4;
    [self.contentLy addSubview:line];
    //
    MyLinearLayout *yunfeiLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    yunfeiLy.myHorzMargin = 0;
    yunfeiLy.myHeight = MyLayoutSize.wrap;
    yunfeiLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:yunfeiLy];
    
    UILabel *yunfeiLable = [BaseLabel CreateBaseLabelStr:@"运费(快递)" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    yunfeiLable.myWidth = yunfeiLable.myHeight = MyLayoutSize.wrap;
    [yunfeiLy addSubview:yunfeiLable];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    nilView.backgroundColor = UIColor.whiteColor;
    [yunfeiLy addSubview:nilView];
    
    self.yunfei = [BaseLabel CreateBaseLabelStr:@"¥50.00" Font:[UIFont fontWithName:@"DIN-Medium" size:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.yunfei.myWidth = self.yunfei.myHeight = MyLayoutSize.wrap;
    [yunfeiLy addSubview:self.yunfei];
    //
    MyLinearLayout *youhuiLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    youhuiLy.myHorzMargin = 0;
    youhuiLy.myHeight = MyLayoutSize.wrap;
    youhuiLy.gravity = MyGravity_Vert_Center;
    [self.contentLy addSubview:youhuiLy];
    
    UILabel *youhuiLable = [BaseLabel CreateBaseLabelStr:@"店铺优惠" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    youhuiLable.myWidth = youhuiLable.myHeight = MyLayoutSize.wrap;
    [youhuiLy addSubview:youhuiLable];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 1;
    nilView1.backgroundColor = UIColor.whiteColor;
    [youhuiLy addSubview:nilView1];
    
    self.youhui = [BaseLabel CreateBaseLabelStr:@"-¥10.00" Font:[UIFont fontWithName:@"DIN-Medium" size:15] Color:[UIColor colorWithHexString:@"#FF3B30"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.youhui.myWidth = self.youhui.myHeight = MyLayoutSize.wrap;
    [youhuiLy addSubview:self.youhui];
    
    self.totalPayNum = [BaseLabel CreateBaseLabelStr:@"实付款：¥32289.74" Font:[UIFont fontWithName:@"DIN-Medium" size:17] Color:[UIColor colorWithHexString:@"#FF3B30"] Frame:CGRectZero Alignment:NSTextAlignmentRight Tag:0];
    self.totalPayNum.myHorzMargin = 0;
    self.totalPayNum.myHeight = MyLayoutSize.wrap;
    self.totalPayNum.myTop = 13;
    [self.contentLy addSubview:self.totalPayNum];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
