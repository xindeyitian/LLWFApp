//
//  CerViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/22.
//

#import "CerViewController.h"

@interface CerViewController ()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UITextField    *nameTF, *idCardTF, *phoneTF, *smsTF;
@property (strong, nonatomic) UIButton       *conmitCerBtn;

@end

@implementation CerViewController
- (void)getSms:(UIButton *)sender{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"实名认证"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHorzMargin = 12;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myTop = 12;
    self.rootLy.layer.cornerRadius = 8;
    self.rootLy.layer.masksToBounds = YES;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.padding = UIEdgeInsetsMake(22, 12, 12, 12);
    self.rootLy.subviewVSpace = 22;
    [self.view addSubview:self.rootLy];
    //
    MyLinearLayout *nameLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    nameLy.myHorzMargin = 0;
    nameLy.myHeight = MyLayoutSize.wrap;
    nameLy.subviewVSpace = 8;
    nameLy.paddingBottom = 8;
    [self.rootLy addSubview:nameLy];
    
    MyLinearLayout *nameTopLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    nameTopLy.myHorzMargin = 0;
    nameTopLy.myHeight = MyLayoutSize.wrap;
    nameTopLy.subviewHSpace = 4;
    nameTopLy.gravity = MyGravity_Vert_Center;
    [nameLy addSubview:nameTopLy];
    
    UIImageView *nameImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"name")];
    nameImg.myWidth = nameImg.myHeight = 18;
    [nameTopLy addSubview:nameImg];
    
    UILabel *nameTitle = [BaseLabel CreateBaseLabelStr:@"姓名" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    nameTitle.myWidth = nameTitle.myHeight = MyLayoutSize.wrap;
    [nameTopLy addSubview:nameTitle];
    
    self.nameTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.nameTF.myLeft = 22;
    self.nameTF.myWidth = ScreenWidth - 70;
    self.nameTF.myHeight = MyLayoutSize.wrap;
    self.nameTF.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.nameTF.textColor = color_3;
    self.nameTF.placeholder = @"请输入姓名";
    [nameLy addSubview:self.nameTF];
    
    MyBorderline *nameLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:22 tailIndent:12];
    nameLy.bottomBorderline = nameLine;
    //
    MyLinearLayout *idLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    idLy.myHorzMargin = 0;
    idLy.myHeight = MyLayoutSize.wrap;
    idLy.subviewVSpace = 8;
    idLy.paddingBottom = 8;
    [self.rootLy addSubview:idLy];
    
    MyLinearLayout *idTopLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    idTopLy.myHorzMargin = 0;
    idTopLy.myHeight = MyLayoutSize.wrap;
    idTopLy.subviewHSpace = 4;
    idTopLy.gravity = MyGravity_Vert_Center;
    [idLy addSubview:idTopLy];
    
    UIImageView *idImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"idcard")];
    idImg.myWidth = idImg.myHeight = 18;
    [idTopLy addSubview:idImg];
    
    UILabel *idTitle = [BaseLabel CreateBaseLabelStr:@"身份证号" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    idTitle.myWidth = idTitle.myHeight = MyLayoutSize.wrap;
    [idTopLy addSubview:idTitle];
    
    self.idCardTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.idCardTF.myLeft = 22;
    self.idCardTF.myWidth = ScreenWidth - 70;
    self.idCardTF.myHeight = MyLayoutSize.wrap;
    self.idCardTF.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.idCardTF.textColor = color_3;
    self.idCardTF.placeholder = @"请输入身份证号";
    [idLy addSubview:self.idCardTF];
    
    MyBorderline *idLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:22 tailIndent:12];
    idLy.bottomBorderline = idLine;
    
    //
    MyLinearLayout *phoneLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    phoneLy.myHorzMargin = 0;
    phoneLy.myHeight = MyLayoutSize.wrap;
    phoneLy.subviewVSpace = 8;
    phoneLy.paddingBottom = 8;
    [self.rootLy addSubview:phoneLy];
    
    MyLinearLayout *phoneTopLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    phoneTopLy.myHorzMargin = 0;
    phoneTopLy.myHeight = MyLayoutSize.wrap;
    phoneTopLy.subviewHSpace = 4;
    phoneTopLy.gravity = MyGravity_Vert_Center;
    [phoneLy addSubview:phoneTopLy];
    
    UIImageView *phoneImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"phone")];
    phoneImg.myWidth = phoneImg.myHeight = 18;
    [phoneTopLy addSubview:phoneImg];
    
    UILabel *phoneTitle = [BaseLabel CreateBaseLabelStr:@"手机号码" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    phoneTitle.myWidth = phoneTitle.myHeight = MyLayoutSize.wrap;
    [phoneTopLy addSubview:phoneTitle];
    
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.phoneTF.myLeft = 22;
    self.phoneTF.myWidth = ScreenWidth - 70;
    self.phoneTF.myHeight = MyLayoutSize.wrap;
    self.phoneTF.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.phoneTF.textColor = color_3;
    self.phoneTF.placeholder = @"请输入手机号";
    [phoneLy addSubview:self.phoneTF];
    
    MyBorderline *phoneLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:22 tailIndent:12];
    phoneLy.bottomBorderline = phoneLine;
    
    //
    MyLinearLayout *smsLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    smsLy.myHorzMargin = 0;
    smsLy.myHeight = MyLayoutSize.wrap;
    smsLy.subviewVSpace = 8;
    smsLy.paddingBottom = 8;
    [self.rootLy addSubview:smsLy];
    
    MyLinearLayout *smsTopLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    smsTopLy.myHorzMargin = 0;
    smsTopLy.myHeight = MyLayoutSize.wrap;
    smsTopLy.subviewHSpace = 4;
    smsTopLy.gravity = MyGravity_Vert_Center;
    [smsLy addSubview:smsTopLy];
    
    UIImageView *smsImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"sms")];
    smsImg.myWidth = smsImg.myHeight = 18;
    [smsTopLy addSubview:smsImg];
    
    UILabel *smsTitle = [BaseLabel CreateBaseLabelStr:@"验证码" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    smsTitle.myWidth = smsTitle.myHeight = MyLayoutSize.wrap;
    [smsTopLy addSubview:smsTitle];
    
    MyLinearLayout *smsBottomLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    smsBottomLy.myHorzMargin = 0;
    smsBottomLy.myHeight = MyLayoutSize.wrap;
    smsBottomLy.gravity = MyGravity_Vert_Center;
    [smsLy addSubview:smsBottomLy];
    
    self.smsTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.smsTF.myLeft = 22;
    self.smsTF.weight = 1;
    self.smsTF.myHeight = MyLayoutSize.wrap;
    self.smsTF.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.smsTF.textColor = color_3;
    self.smsTF.placeholder = @"请输入验证码";
    [smsBottomLy addSubview:self.smsTF];
    
    LCountdownButton *sendSmsBtn = [[LCountdownButton alloc] initWithFrame:CGRectZero];
//    [sendSmsBtn buttonWithCountdown:60 normalTitle:@"再次获取验证码" animationTitle:@"s后"];
    [sendSmsBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [sendSmsBtn setBackgroundColor:[UIColor colorNamed:@"color-red"]];
    [sendSmsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    sendSmsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    sendSmsBtn.myWidth = 90;
    sendSmsBtn.myHeight = 30;
    sendSmsBtn.layer.cornerRadius = 15;
    sendSmsBtn.layer.masksToBounds = YES;
    [smsBottomLy addSubview:sendSmsBtn];
    
    MyBorderline *smsLine = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:22 tailIndent:12];
    smsLy.bottomBorderline = smsLine;
    
    UIButton *yinsiBtn = [BaseButton CreateBaseButtonTitle:@"已阅读并同意《供应链用户服务协议》" Target:self Action:@selector(agree:) Font:[UIFont systemFontOfSize:13] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"rightChoose" HeightLightBackgroundImage:@"rightChoose"];
    [yinsiBtn setTitleColor:color_3 forState:UIControlStateNormal];
    yinsiBtn.myWidth = MyLayoutSize.wrap;
    yinsiBtn.myHeight = 30;
    yinsiBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
    [self.rootLy addSubview:yinsiBtn];
    
    self.conmitCerBtn = [BaseButton CreateBaseButtonTitle:@"提交实名认证" Target:self Action:@selector(conmitCer) Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.conmitCerBtn.myHorzMargin = 80;
    self.conmitCerBtn.myHeight = 44;
    self.conmitCerBtn.layer.cornerRadius = 22;
    self.conmitCerBtn.layer.masksToBounds = YES;
    [self.rootLy addSubview:self.conmitCerBtn];
    [UIButton setNewVesionBtnEnabeld:self.conmitCerBtn status:NO];
    
}
- (void)agree:(UIButton *)sender{
    
    if (sender.selected) {
        
        [sender setImage:IMAGE_NAMED(@"rightChoose") forState:UIControlStateNormal];
    }else{
        [sender setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
    }
    [UIButton setNewVesionBtnEnabeld:self.conmitCerBtn status:!sender.selected];
    sender.selected = !sender.isSelected;
}
- (void)conmitCer{
    
    
}
@end
