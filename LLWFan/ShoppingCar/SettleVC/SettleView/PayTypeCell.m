//
//  PayTypeCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "PayTypeCell.h"

@interface PayTypeCell()

@property (strong, nonatomic) MyLinearLayout  *rootLy, *contentLy;
@property (strong, nonatomic) UIButton        *zPayBtn, *wxPayBtn, *curBtn;
@property (strong, nonatomic) UnionOrderModel *model;

@end

@implementation PayTypeCell
- (void)choosePayType:(UIButton *)sender{
    
    if (self.curBtn) {
        
        [sender setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
        [self.curBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    }else{
        
        self.curBtn = sender;
        [self.curBtn setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
    }
    self.curBtn = sender;
    self.model.payType = sender.tag;
    if (self.returnUnionModelBlock) {
        
        self.returnUnionModelBlock(self.model);
    }
}
- (void)setCellWithModel:(UnionOrderModel *)model{
    
    self.model = model;
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
    self.rootLy.padding = UIEdgeInsetsMake(12, 12, 75, 12);
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
    
//    UITapGestureRecognizer *zTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayType:)];
    
    MyLinearLayout *zPayLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    zPayLy.myHorzMargin = 0;
    zPayLy.myHeight = MyLayoutSize.wrap;
    zPayLy.paddingBottom = 12;
    zPayLy.gravity = MyGravity_Vert_Center;
    zPayLy.subviewHSpace = 12;
    zPayLy.tag = 0;
//    [zPayLy addGestureRecognizer:zTap];
    [self.contentLy addSubview:zPayLy];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:0 tailIndent:0];
    zPayLy.bottomBorderline = line;
    
    UIImageView *zImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"zPay")];
    zImg.myWidth = zImg.myHeight = 20;
    [zPayLy addSubview:zImg];
    
    UILabel *zTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    zTitle.font = [UIFont systemFontOfSize:17];
    zTitle.textColor = color_3;
    zTitle.text = @"支付宝支付";
    zTitle.weight = 1;
    zTitle.myHeight = MyLayoutSize.wrap;
    [zPayLy addSubview:zTitle];
    
    self.zPayBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(choosePayType:) Font:[UIFont systemFontOfSize:12] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.zPayBtn.myWidth = self.zPayBtn.myHeight = MyLayoutSize.wrap;
    [zPayLy addSubview:self.zPayBtn];
    
//    UITapGestureRecognizer *wxTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choosePayType:)];
    
    MyLinearLayout *wxLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    wxLy.myHorzMargin = 0;
    wxLy.myHeight = MyLayoutSize.wrap;
    wxLy.gravity = MyGravity_Vert_Center;
    wxLy.subviewHSpace = 12;
    wxLy.tag = 1;
//    [wxLy addGestureRecognizer:wxTap];
    [self.contentLy addSubview:wxLy];
    
    UIImageView *wxImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"wxPay")];
    wxImg.myWidth = wxImg.myHeight = 20;
    [wxLy addSubview:wxImg];
    
    UILabel *wxTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    wxTitle.font = [UIFont systemFontOfSize:17];
    wxTitle.textColor = color_3;
    wxTitle.text = @"微信支付";
    wxTitle.weight = 1;
    wxTitle.myHeight = MyLayoutSize.wrap;
    [wxLy addSubview:wxTitle];
    
    self.wxPayBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(choosePayType:) Font:[UIFont systemFontOfSize:12] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.wxPayBtn.myWidth = self.wxPayBtn.myHeight = MyLayoutSize.wrap;
    [wxLy addSubview:self.wxPayBtn];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];;
}
@end
