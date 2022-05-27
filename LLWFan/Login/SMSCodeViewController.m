//
//  SMSCodeViewController.m
//  ObjectiveCTools
//
//  Created by aidong on 2020/10/13.
//  Copyright © 2020 姬友大人. All rights reserved.
//

#import "SMSCodeViewController.h"
#import "SMSCodeInputView.h"
#import "MainTabarViewController.h"

@interface SMSCodeViewController ()<SMSCodeInputViewDelegate>

@property (strong, nonatomic) SMSCodeInputView *inputView;
@property (strong, nonatomic) UILabel          *phoneLable, *regainLable;
@property (strong, nonatomic) LCountdownButton *getSmsBtn;

@end

@implementation SMSCodeViewController
- (void)back{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"back" HeightLightBackgroundImage:@"back"];
    [self.view addSubview:backBtn];
    
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(RootStatusBarHeight + 20);
        make.left.mas_offset(20);
        make.width.height.mas_offset(24);
    }];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"输入验证码" Font:[UIFont systemFontOfSize:24 weight:UIFontWeightSemibold] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    [self.view addSubview:title];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(backBtn).mas_offset(75);
        make.left.mas_equalTo(self.view).mas_offset(50);
        make.height.mas_offset(35);
    }];
    
    self.phoneLable = [BaseLabel CreateBaseLabelStr:NSStringFormat(@"验证码已经发送至 +86 %@",[self.userPhone formatedNumberWithArrNumber:@[@(3),@(4)] isDelete:NO]) Font:[UIFont systemFontOfSize:12] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    [self.view addSubview:self.phoneLable];
    
    [self.phoneLable mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.mas_equalTo(self.view).mas_offset(50);
        make.top.mas_equalTo(title.mas_bottom).mas_offset(5);
    }];
    
    self.inputView = [[SMSCodeInputView alloc] initWithFrame:CGRectZero];
    self.inputView.delegate = self;
    [self.view addSubview:self.inputView];
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.mas_equalTo(self.phoneLable.mas_bottom).mas_offset(30);
        make.left.mas_equalTo(self.view).mas_equalTo(50);
        make.height.mas_offset(57);
        make.width.mas_equalTo(ScreenWidth - 100);
    }];
    
    self.getSmsBtn = [[LCountdownButton alloc] initWithFrame:CGRectZero];
    self.getSmsBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.getSmsBtn setTitleColor:[UIColor colorNamed:@"color-red"] forState:UIControlStateNormal];
    [self.getSmsBtn buttonWithCountdown:60 normalTitle:@"重新获取" animationTitle:@"s秒后重新获取验证码"];
    [self.getSmsBtn addTarget:self action:@selector(getSmsCode:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.getSmsBtn];
    
    [self.getSmsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
        make.left.mas_equalTo(self.view).mas_offset(50);
        make.top.mas_equalTo(self.inputView.mas_bottom).mas_offset(40);
        make.height.mas_offset(17);
    }];
    
    [THHttpHelper sendCheckCodeWithPhoneNum:self.userPhone AndMsgType:@"Login" block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"发送验证码成功" AndType:success IsHideBg:YES AnddataBlock:nil];
        }
    }];
    
    self.view.userInteractionEnabled = YES;
}
- (void)getSmsCode:(LCountdownButton *)sender{
    
    [THHttpHelper sendCheckCodeWithPhoneNum:self.userPhone AndMsgType:@"Login" block:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [sender buttonWithCountdown:60 normalTitle:@"重新获取" animationTitle:@"s秒后重新获取验证码"];
        }
    }];
}
- (void)successInputWithText:(NSString *)smsCode{
    
    [self.inputView resignFirstResponder];
    [THHttpHelper requestLoginWithPhone:self.userPhone SmsCode:smsCode block:^(NSInteger returnCode, THRequestStatus status, THUserModel *user) {
        
        if (returnCode == 200) {
            
            //保存用户数据
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"登录成功" AndType:success IsHideBg:YES AnddataBlock:^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                        
                    user.userAccount = self.userPhone;
                    [[THUserManager shareTHUserManager] archiverUserModel:user];
                    [THUserManagerShareTHUserManager setUserModel:user];
                    NSLog(@"+_+_+_+_+_+_+%@",THUserManagerShareTHUserManager.userModel);
                    MainTabarViewController *tabBarVC = [MainTabarViewController new];
                    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarVC;
                });
            }];
        }
    }];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.inputView becomeFirstResponder];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputView resignFirstResponder];
    NSLog(@"获取到输入: %@", self.inputView.codeText);
}

- (void)backClcik{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
