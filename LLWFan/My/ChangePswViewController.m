//
//  ChangePswViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/26.
//

#import "ChangePswViewController.h"
#import "LCountdownButton.h"

@interface ChangePswViewController ()

@property (strong, nonatomic) UITextField *phoneTF, *smsTF, *pswTF, *nextPswTF;
@property (strong, nonatomic) UIButton *sureBtn;
@property (strong, nonatomic) LCountdownButton *sendSmsBtn;

@end

@implementation ChangePswViewController
- (void)sureChangePsw{
    
    if (!self.phoneTF.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入手机号" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (!self.smsTF.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入验证码" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (!self.pswTF.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入新的密码" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (!self.nextPswTF.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请再次输入密码" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (![self.nextPswTF.text isEqualToString:self.pswTF.text]) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"两次输入密码不一致" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    
    if (self.type) {
        
        
    }else{
        
        [THHttpManager changePwdWithCheckCode:self.smsTF.text AndNewPwd:self.nextPswTF.text AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"修改密码成功，请牢记密码!" AndType:success IsHideBg:YES AnddataBlock:^{
                    
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }];
    }
}
- (void)getSmsCode:(LCountdownButton *)sender{
    
    if (!self.phoneTF.text.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入手机号" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    [THHttpHelper sendCheckCodeWithPhoneNum:self.nextPswTF.text AndMsgType:@"1" block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [self.sendSmsBtn buttonWithCountdown:60 normalTitle:@"" animationTitle:@"s后"];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (self.type) {
        
        [self setTitle:@"修改提现密码"];
    }else{
        
        [self setTitle:@"修改登录密码"];
    }
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myHorzMargin = 12;
    rootLy.myHeight = MyLayoutSize.wrap;
    rootLy.padding = UIEdgeInsetsMake(24, 0, 12, 0);
    rootLy.subviewVSpace = 8;
    [self.view addSubview:rootLy];
    
    MyLinearLayout *phoneLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    phoneLy.myWidth = ScreenWidth - 24;
    phoneLy.myHeight = 52;
    phoneLy.backgroundColor = color_f5;
    phoneLy.layer.cornerRadius = 12;
    phoneLy.layer.masksToBounds = YES;
    phoneLy.gravity = MyGravity_Vert_Center;
    phoneLy.padding = UIEdgeInsetsMake(0, 20, 0, 20);
    [rootLy addSubview:phoneLy];
    
    UILabel *area = [BaseLabel CreateBaseLabelStr:@"+86" Font:[UIFont fontWithName:@"DIN-Medium" size:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    area.myWidth = 30;
    area.myHeight = 20;
    [phoneLy addSubview:area];
    
    UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"xiajiantou")];
    img.myWidth = img.myHeight = 10;
    img.myLeft = 2;
    [phoneLy addSubview:img];
    
    self.phoneTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.phoneTF.placeholder = @"请输入手机号";
    self.phoneTF.font = [UIFont systemFontOfSize:15];
    self.phoneTF.myWidth = ScreenWidth - 24 - 42;
    self.phoneTF.myHeight = MyLayoutSize.wrap;
    self.phoneTF.myLeft = 6;
    [phoneLy addSubview:self.phoneTF];
    
    MyLinearLayout *smsLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    smsLy.myHorzMargin = 0;
    smsLy.myHeight = 52;
    smsLy.subviewHSpace = 8;
    [rootLy addSubview:smsLy];
    
    MyLinearLayout *smsTextLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    smsTextLy.weight = 1;
    smsTextLy.myHeight = 52;
    smsTextLy.layer.cornerRadius = 12;
    smsTextLy.layer.masksToBounds = YES;
    smsTextLy.backgroundColor = color_f5;
    smsTextLy.gravity = MyGravity_Vert_Center;
    smsTextLy.padding = UIEdgeInsetsMake(0, 20, 0, 20);
    [smsLy addSubview:smsTextLy];
    
    UILabel *smsLable = [BaseLabel CreateBaseLabelStr:@"验证码" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    smsLable.myWidth = 60;
    smsLable.myHeight = MyLayoutSize.wrap;
    [smsTextLy addSubview:smsLable];
    
    self.smsTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.smsTF.placeholder = @"请输入验证码";
    self.smsTF.font = [UIFont systemFontOfSize:15];
    self.smsTF.weight = 1;
    self.smsTF.myHeight = MyLayoutSize.wrap;
    self.smsTF.myLeft = 6;
    [smsTextLy addSubview:self.smsTF];
    
    self.sendSmsBtn = [[LCountdownButton alloc] initWithFrame:CGRectZero];
    [self.sendSmsBtn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    [self.sendSmsBtn setBackgroundColor:[UIColor colorNamed:@"color-red"]];
    [self.sendSmsBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.sendSmsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.sendSmsBtn addTarget:self action:@selector(getSmsCode:) forControlEvents:UIControlEventTouchUpInside];
    self.sendSmsBtn.myWidth = 117;
    self.sendSmsBtn.myHeight = 52;
    self.sendSmsBtn.layer.cornerRadius = 12;
    self.sendSmsBtn.layer.masksToBounds = YES;
    [smsLy addSubview:self.sendSmsBtn];
    
    MyLinearLayout *pswLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    pswLy.myWidth = ScreenWidth - 24;
    pswLy.myHeight = 52;
    pswLy.padding = UIEdgeInsetsMake(0, 20, 0, 20);
    pswLy.backgroundColor = color_f5;
    pswLy.layer.cornerRadius = 12;
    pswLy.layer.masksToBounds = YES;
    pswLy.gravity = MyGravity_Vert_Center;
    [rootLy addSubview:pswLy];
    
    self.pswTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.pswTF.placeholder = @"请输入新的密码";
    self.pswTF.font = [UIFont systemFontOfSize:15];
    self.pswTF.myWidth = ScreenWidth - 88;
    self.pswTF.myHeight = MyLayoutSize.wrap;
    [pswLy addSubview:self.pswTF];
    
    MyLinearLayout *nextPswLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    nextPswLy.myWidth = ScreenWidth - 24;
    nextPswLy.myHeight = 52;
    nextPswLy.padding = UIEdgeInsetsMake(0, 20, 0, 20);
    nextPswLy.backgroundColor = color_f5;
    nextPswLy.layer.cornerRadius = 12;
    nextPswLy.layer.masksToBounds = YES;
    nextPswLy.gravity = MyGravity_Vert_Center;
    [rootLy addSubview:nextPswLy];
    
    self.nextPswTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.nextPswTF.placeholder = @"再次输入密码";
    self.nextPswTF.font = [UIFont systemFontOfSize:15];
    self.nextPswTF.myWidth = ScreenWidth - 88;
    self.nextPswTF.myHeight = MyLayoutSize.wrap;
    [nextPswLy addSubview:self.nextPswTF];
    
    self.sureBtn = [BaseButton CreateBaseButtonTitle:@"确认" Target:self Action:@selector(sureChangePsw) Font:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.sureBtn.myHorzMargin = 0;
    self.sureBtn.myHeight = 50;
    self.sureBtn.layer.cornerRadius  = 25;
    self.sureBtn.layer.masksToBounds = YES;
    self.sureBtn.myTop = 24;
    [rootLy addSubview:self.sureBtn];
    
    
}
@end
