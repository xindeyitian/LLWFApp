//
//  YangLaoTopCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/21.
//

@class YLItemView;

#import "YangLaoTopCell.h"
#import "SetYLJPercentPopView.h"

@interface YangLaoTopCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UILabel        *yljNum, *idCardLable;
@property (strong, nonatomic) UIButton       *percentBtn;
@property (strong, nonatomic) LSTPopView     *popView;

@end

@implementation YangLaoTopCell
- (void)popChoosePercent{
    
    SetYLJPercentPopView *pop = [[SetYLJPercentPopView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 285)];
    
    self.popView = [LSTPopView initWithCustomView:pop popStyle:LSTPopStyleSmoothFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
    self.popView.hemStyle = LSTHemStyleBottom;
    self.popView.popDuration = 0.25;
    self.popView.dismissDuration = 0.25;
    self.popView.isClickFeedback = YES;
    self.popView.bgColor = [UIColor colorWithHexString:@"#000000" alpha:0.55];
    weakSelf(self.popView)
    self.popView.bgClickBlock = ^{
        
        [weakSelf dismiss];
    };
    
    [self.popView pop];
}
- (void)checkOrGetYLJ{
    
    
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
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.gravity = MyGravity_Horz_Center;
    self.rootLy.padding = UIEdgeInsetsMake(0, 12, 48, 12);
    [self.contentView addSubview:self.rootLy];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 0;
    contentLy.myHeight = MyLayoutSize.wrap;
    [self.rootLy addSubview:contentLy];
    
    MyLinearLayout *ylInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    ylInfoLy.myHorzMargin = 0;
    ylInfoLy.myHeight = MyLayoutSize.wrap;
    ylInfoLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    ylInfoLy.backgroundColor = [UIColor colorNamed:@"color-orange"];
    ylInfoLy.layer.cornerRadius = 8;
    ylInfoLy.layer.masksToBounds = YES;
    [contentLy addSubview:ylInfoLy];
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.gravity = MyGravity_Vert_Center;
    [ylInfoLy addSubview:topLy];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"平台总拨划养老金（元）" Font:[UIFont systemFontOfSize:12 weight:UIFontWeightMedium] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    title.weight = 1;
    title.myHeight = MyLayoutSize.wrap;
    [topLy addSubview:title];
    
    self.percentBtn = [BaseButton CreateBaseButtonTitle:@"划拨比例5%" Target:self Action:@selector(popChoosePercent) Font:[UIFont systemFontOfSize:12] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"" HeightLightBackgroundImage:@""];
    [self.percentBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    self.percentBtn.myHeight = self.percentBtn.myWidth = MyLayoutSize.wrap;
    [topLy addSubview:self.percentBtn];
    
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"right")];
    right.myWidth = right.myHeight = 15;
    [topLy addSubview:right];
    
    self.yljNum = [BaseLabel CreateBaseLabelStr:@"¥189.8490" Font:[UIFont fontWithName:@"DIN-Medium" size:20] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.yljNum.myWidth = self.yljNum.myHeight = MyLayoutSize.wrap;
    self.yljNum.myTop = 12;
    [ylInfoLy addSubview:self.yljNum];
    
    MyLinearLayout *bottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    bottomLy.myHorzMargin = 0;
    bottomLy.myTop = 24;
    bottomLy.myHeight = MyLayoutSize.wrap;
    bottomLy.gravity = MyGravity_Vert_Center;
    [ylInfoLy addSubview:bottomLy];
    
    UIImageView *cardImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"Group 3")];
    cardImg.myWidth = cardImg.myHeight = 15;
    [bottomLy addSubview:cardImg];
    
    self.idCardLable = [BaseLabel CreateBaseLabelStr:@"公证处消费养老账户 42************4226" Font:[UIFont systemFontOfSize:12] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.idCardLable.myWidth = self.idCardLable.myHeight = MyLayoutSize.wrap;
    [bottomLy addSubview:self.idCardLable];
    
    MyLinearLayout *line1 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    line1.myHorzMargin = 0;
    line1.myHeight = MyLayoutSize.wrap;
    line1.subviewHSpace = 1;
    line1.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    line1.myTop = 24;
    [contentLy addSubview:line1];
    
    YLItemView *shopAllEarning = [[YLItemView alloc] initWithFrame:CGRectZero AndLayoutType:MyGravity_Horz_Center];
    shopAllEarning.myWidth = (ScreenWidth - 25) / 2;
    shopAllEarning.myHeight = 69;
    [line1 addSubview:shopAllEarning];
    
    YLItemView *daijiesuanLy = [[YLItemView alloc] initWithFrame:CGRectZero AndLayoutType:MyGravity_Horz_Center];
    daijiesuanLy.myWidth = (ScreenWidth - 25) / 2;
    daijiesuanLy.myHeight =  69;
    [line1 addSubview:daijiesuanLy];
    
    MyLinearLayout *line2 = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    line2.myHorzMargin = 0;
    line2.myHeight = MyLayoutSize.wrap;
    line2.subviewHSpace = 1;
    line2.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    [contentLy addSubview:line2];
    
    YLItemView *shopAllEarning1 = [[YLItemView alloc] initWithFrame:CGRectZero AndLayoutType:MyGravity_Horz_Center];
    shopAllEarning1.myWidth = (ScreenWidth - 25) / 2;
    shopAllEarning1.myHeight =  69;
    [line2 addSubview:shopAllEarning1];
    
    YLItemView *daijiesuanLy1 = [[YLItemView alloc] initWithFrame:CGRectZero AndLayoutType:MyGravity_Horz_Center];
    daijiesuanLy1.myWidth = (ScreenWidth - 25) / 2;
    daijiesuanLy1.myHeight =  69;
    [line2 addSubview:daijiesuanLy1];
    
    UIButton *checkYLJ = [BaseButton CreateBaseButtonTitle:@"查询/提取养老金" Target:self Action:@selector(checkOrGetYLJ) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    checkYLJ.myHorzMargin = 75;
    checkYLJ.myHeight = 50;
    checkYLJ.layer.cornerRadius = 25;
    checkYLJ.layer.masksToBounds = YES;
    checkYLJ.myTop = 12;
    [contentLy addSubview:checkYLJ];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end

@interface YLItemView()

@property (strong, nonatomic) MyLinearLayout *backLy;
@property (strong, nonatomic) UILabel *num, *title;

@end

@implementation YLItemView

- (instancetype)initWithFrame:(CGRect)frame AndLayoutType:(MyGravity )gravity
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCusViewWithGravity:gravity];
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}
- (void)initCusViewWithGravity:(MyGravity )gravity{
    
    self.backLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.backLy.myHorzMargin = 0;
    self.backLy.myHeight = MyLayoutSize.wrap;
    self.backLy.gravity = gravity;
    self.backLy.subviewVSpace = 8;
    self.backLy.paddingTop = self.backLy.paddingBottom = 12;
    [self addSubview:self.backLy];
    
    self.num = [BaseLabel CreateBaseLabelStr:@"8888.8888" Font:[UIFont fontWithName:@"DIN-Medium" size:18] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.num.myWidth = self.num.myHeight = MyLayoutSize.wrap;
    [self.backLy addSubview:self.num];
    
    self.title = [BaseLabel CreateBaseLabelStr:@"店铺累计收益" Font:[UIFont systemFontOfSize:12] Color:[UIColor colorWithHexString:@"12"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.title.myWidth = self.title.myHeight = MyLayoutSize.wrap;
    [self.backLy addSubview:self.title];
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.backLy sizeThatFits:targetSize];
}
@end
