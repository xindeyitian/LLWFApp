//
//  LLWFPayCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "LLWFPayCell.h"

@interface LLWFPayCell()
{
    NSString *_Yue, *_LLWF;
}
@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *accountYuE, *LLWFYuE;
@property (strong, nonatomic) UIButton       *yueChooseBtn, *llwfChooseBtn;
@property (strong, nonatomic) UnionOrderModel *unionModel;

@end

@implementation LLWFPayCell
- (void)chooseLLWFPay:(UIButton *)sender{
    
    //0:选择余额抵扣 1:选择llwf抵扣
    
    if (sender.selected) {
        
        [sender setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    }else{
        [sender setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
    }
    sender.selected = !sender.isSelected;
    
    [MBProgressHUD showHUDAddedTo:self.currentViewController.view animated:YES];
    [THHttpManager changeBalanceVoucherWithBalanceSelected:self.yueChooseBtn.isSelected AndVoucherSelected:self.llwfChooseBtn.isSelected AndUnionOrderId:self.unionModel.unionOrderId AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
            if (self.chooseLLWFPayBlock) {
                
                self.chooseLLWFPayBlock([UnionOrderModel mj_objectWithKeyValues:data]);
            }
        }else{
            if (sender.selected) {
                
                [sender setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
            }else{
                [sender setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
            }
            sender.selected = !sender.isSelected;
            [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
        }
    }];
}
- (void)popNotice:(UIButton *)sender{
    
    //0：弹出余额抵扣说明 1:选择llwf抵扣说明
    
}
- (void)setCellWithModel:(UnionOrderModel *)model{
    
    self.unionModel = model;
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
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    self.contentLy.layer.cornerRadius = 8;
    self.contentLy.layer.masksToBounds = YES;
    self.contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [self.rootLy addSubview:self.contentLy];
    
    MyLinearLayout *yueLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    yueLy.myHorzMargin = 0;
    yueLy.myHeight = 55;
    yueLy.gravity = MyGravity_Vert_Center;
    yueLy.subviewHSpace = 12;
    yueLy.paddingBottom = 12;
    [self.contentLy addSubview:yueLy];
    
    MyBorderline *yueLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#F5F5F5"] thick:0.5 headIndent:0 tailIndent:0];
    yueLy.bottomBorderline = yueLine;
    
    UIImageView *yueImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"yuePay")];
    yueImg.myHeight = yueImg.myWidth = 20;
    [yueLy addSubview:yueImg];
    
    MyLinearLayout *yueInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    yueInfoLy.weight = 1;
    yueInfoLy.myHeight = MyLayoutSize.wrap;
    yueInfoLy.subviewVSpace = 5;
    [yueLy addSubview:yueInfoLy];
    
    MyLinearLayout *yueTopLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    yueTopLy.myHorzMargin = 0;
    yueTopLy.myHeight = MyLayoutSize.wrap;
    yueTopLy.subviewHSpace = 4;
    yueTopLy.gravity = MyGravity_Vert_Center;
    [yueInfoLy addSubview:yueTopLy];
    
    UILabel *yueTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    yueTitle.text = @"余额抵扣";
    yueTitle.font = [UIFont systemFontOfSize:17];
    yueTitle.textColor = color_3;
    yueTitle.myWidth = yueTitle.myHeight = MyLayoutSize.wrap;
    [yueTopLy addSubview:yueTitle];
    
    UIButton *yueNoticeBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(popNotice:) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"order-notice" HeightLightBackgroundImage:@"order-notice"];
    yueNoticeBtn.myWidth = yueNoticeBtn.myHeight = MyLayoutSize.wrap;
    [yueTopLy addSubview:yueNoticeBtn];
    
    self.accountYuE = [[UILabel alloc] initWithFrame:CGRectZero];
    self.accountYuE.font = [UIFont systemFontOfSize:13];
    self.accountYuE.textColor = color_9;
    self.accountYuE.myHorzMargin = 0;
    self.accountYuE.myHeight = MyLayoutSize.wrap;
    [yueInfoLy addSubview:self.accountYuE];
    
    [THHttpManager queryUserBalanceWithBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            self->_Yue = NSStringFormat(@"%@",data);
            self.accountYuE.text = NSStringFormat(@"账户余额:%@",data);
        }
    }];
    
    self.yueChooseBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(chooseLLWFPay:) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.yueChooseBtn.myWidth = 24;
    self.yueChooseBtn.myVertMargin = 0;
    [yueLy addSubview:self.yueChooseBtn];
    
    MyLinearLayout *LLWFLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    LLWFLy.myHorzMargin = 0;
    LLWFLy.myHeight = 55;
    LLWFLy.gravity = MyGravity_Vert_Center;
    LLWFLy.subviewHSpace = 12;
    LLWFLy.paddingTop = 12;
    [self.contentLy addSubview:LLWFLy];
    
    UIImageView *llwfImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"yuePay")];
    llwfImg.myHeight = llwfImg.myWidth = 20;
    [LLWFLy addSubview:llwfImg];
    
    MyLinearLayout *llwfInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    llwfInfoLy.weight = 1;
    llwfInfoLy.myHeight = MyLayoutSize.wrap;
    llwfInfoLy.subviewVSpace = 5;
    [LLWFLy addSubview:llwfInfoLy];
    
    MyLinearLayout *llwfTopLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    llwfTopLy.myHorzMargin = 0;
    llwfTopLy.myHeight = MyLayoutSize.wrap;
    llwfTopLy.subviewHSpace = 4;
    llwfTopLy.gravity = MyGravity_Vert_Center;
    [llwfInfoLy addSubview:llwfTopLy];
    
    UILabel *llwfTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    llwfTitle.text = @"LLWF抵扣金";
    llwfTitle.font = [UIFont systemFontOfSize:17];
    llwfTitle.textColor = color_3;
    llwfTitle.myWidth = llwfTitle.myHeight = MyLayoutSize.wrap;
    [llwfTopLy addSubview:llwfTitle];
    
    UIButton *llwfNoticeBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(popNotice:) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"order-notice" HeightLightBackgroundImage:@"order-notice"];
    llwfNoticeBtn.myWidth = llwfNoticeBtn.myHeight = MyLayoutSize.wrap;
    [llwfTopLy addSubview:llwfNoticeBtn];
    
    self.LLWFYuE = [[UILabel alloc] initWithFrame:CGRectZero];
    self.LLWFYuE.font = [UIFont systemFontOfSize:13];
    self.LLWFYuE.textColor = color_9;
    self.LLWFYuE.text = @"LLWF抵用金：10.00";
    self.LLWFYuE.myHorzMargin = 0;
    self.LLWFYuE.myHeight = MyLayoutSize.wrap;
    [llwfInfoLy addSubview:self.LLWFYuE];
    
    [THHttpManager queryUserDeducteWithBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            self->_LLWF = NSStringFormat(@"%@",data);
            self.LLWFYuE.text = NSStringFormat(@"LLWF抵用金:%@",data);
        }
    }];
    
    self.llwfChooseBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(chooseLLWFPay:) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.llwfChooseBtn.myWidth = 24;
    self.llwfChooseBtn.myVertMargin = 0;
    [LLWFLy addSubview:self.llwfChooseBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
