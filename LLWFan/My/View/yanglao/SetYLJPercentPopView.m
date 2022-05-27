//
//  SetYLJPercentPopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/21.
//

#import "SetYLJPercentPopView.h"
#import "AllPopNoticeView.h"

@interface SetYLJPercentPopView()<UITextFieldDelegate,AllPopNoticeViewDelegate>

@property (strong, nonatomic) MyLinearLayout *rootLy, *topLy, *categoryLy;
@property (strong, nonatomic) UITextField    *percentTF;
@property (strong, nonatomic) UIButton       *sureSavePercent;
@property (weak,   nonatomic) LSTPopView      *pop;

@end

@implementation SetYLJPercentPopView
- (void)popNotice{
    
    AllPopNoticeView *view = [[AllPopNoticeView alloc] initWithFrame:CGRectZero AndTitle:@"划拨比例是指平台从每日转换的抵用金中，划拨到您的养老金账户中的比例。" AndContent:@""];
    view.delegate = self;
    view.frame = CGRectMake(0, 0, ScreenWidth - 100, [view.backView sizeThatFits:CGSizeMake(ScreenWidth - 100, 0)].height);
    LSTPopView *popView = [LSTPopView initWithCustomView:view
                                                popStyle:LSTPopStyleSmoothFromTop
                                            dismissStyle:LSTDismissStyleSmoothToTop];
    LSTPopViewWK(popView)
    popView.popDuration = 0.25;
    popView.dismissDuration = 0.25;
    popView.isClickFeedback = YES;
    popView.cornerRadius = 8;
    popView.bgClickBlock = ^{
        
        [wk_popView dismiss];
    };
    self.pop = popView;
    [popView pop];
}
- (void)clickRightBtn{
    
    [self.pop dismiss];
}
- (void)sureSave{
    
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCusView];
    }
    return self;
}
- (void)initCusView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = 285;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.rootLy];
    
    self.topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.topLy.myHorzMargin = 0;
    self.topLy.myHeight = MyLayoutSize.wrap;
    self.topLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:self.topLy];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    backBtn.myWidth = backBtn.myHeight = 24;
    backBtn.myLeft = ScreenWidth - 33;
    backBtn.myTop = 9;
    [self.topLy addSubview:backBtn];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.text = @"设置划拨比例";
    title.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    title.textColor = color_3;
    title.myHorzMargin = 0;
    title.myHeight = MyLayoutSize.wrap;
    title.myTop = -5;
    title.textAlignment = NSTextAlignmentCenter;
    [self.topLy addSubview:title];
    
    MyLinearLayout *noticeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    noticeLy.myHorzMargin = 25;
    noticeLy.myHeight = MyLayoutSize.wrap;
    noticeLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:noticeLy];
    
    UILabel *percentLable = [BaseLabel CreateBaseLabelStr:@"划拨比例(%)" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    percentLable.myWidth = percentLable.myHeight = MyLayoutSize.wrap;
    [noticeLy addSubview:percentLable];
    
    UIButton *noticeBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(popNotice) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"notice" HeightLightBackgroundImage:@"notice"];
    noticeBtn.myWidth = noticeBtn.myHeight = 15;
    noticeBtn.myLeft = 4;
    [noticeLy addSubview:noticeBtn];
    
    self.percentTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.percentTF.placeholder = @"5";
    self.percentTF.font = [UIFont fontWithName:@"DIN Alternate Bold" size:32];
    self.percentTF.textColor = [UIColor colorWithHexString:@"222222"];
    self.percentTF.myHorzMargin = 25;
    self.percentTF.myHeight = 40;
    self.percentTF.myTop = 12;
    self.percentTF.delegate = self;
    self.percentTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.percentTF addTarget:self action:@selector(changePercent:) forControlEvents:UIControlEventEditingChanged];
    [self.rootLy addSubview:self.percentTF];
    
    UIButton *button = [self.percentTF valueForKey:@"_clearButton"];
    [button setImage:IMAGE_NAMED(@"clearBtn") forState:UIControlStateNormal];
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectZero];
    line.myHorzMargin = 25;
    line.myHeight = 0.5;
    line.backgroundColor = [UIColor colorWithHexString:@"#E5E5E5"];
    line.myTop = 4;
    [self.rootLy addSubview:line];
    
    UILabel *noticeLable = [BaseLabel CreateBaseLabelStr:@"划拨比例需在5%～30%之间" Font:[UIFont systemFontOfSize:12] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    noticeLable.myWidth = noticeLable.myHeight = MyLayoutSize.wrap;
    noticeLable.myTop = 8;
    noticeLable.myLeft = 25;
    [self.rootLy addSubview:noticeLable];
    
    self.sureSavePercent = [BaseButton CreateBaseButtonTitle:@"确认保存" Target:self Action:@selector(sureSave) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.sureSavePercent.myHorzMargin = 12;
    self.sureSavePercent.myHeight = 50;
    self.sureSavePercent.layer.cornerRadius = 25;
    self.sureSavePercent.layer.masksToBounds = YES;
    self.sureSavePercent.myTop = 48;
    [self.rootLy addSubview:self.sureSavePercent];
    [UIButton setNewVesionBtnEnabeld:self.sureSavePercent status:NO];
}
- (void)changePercent:(UITextField *)textField{
    
    if (textField.text.length > 0) {
        [UIButton setNewVesionBtnEnabeld:self.sureSavePercent status:YES];
    }else{
        [UIButton setNewVesionBtnEnabeld:self.sureSavePercent status:NO];
    }
}
@end
