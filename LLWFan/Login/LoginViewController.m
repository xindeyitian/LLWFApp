//
//  LoginViewController.m
//  SeaEgret
//
//  Created by MAC on 2021/4/14.
//

#import "LoginViewController.h"
#import "RegistOrForgetViewController.h"
#import "MainTabarViewController.h"
#import "YinsiFuwuViewController.h"
#import "LSTPopViewqqtopView.h"
#import "SMSCodeViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>{
    NSInteger i;
}
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UIButton    *loginBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@end

@implementation LoginViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
    [super viewWillDisappear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    i = 0;
    [UserDefaults setObject:@"0" forKey:@"isAgree"];
    self.userNameTF.delegate = self;
    self.userNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.userNameTF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textfieldEditChange:) name:@"UITextFieldTextDidChangeNotification" object:self.userNameTF];
}
- (void)initView{
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输手机号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style}];
    self.userNameTF.attributedPlaceholder = attributedString;
    
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"已同意并阅读《留莲忘返商户入驻协议》" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : color_9}];
    
    [text setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#FA172D"]} range:NSMakeRange(6, 12)];
    [self.agreeBtn.titleLabel setAttributedText:text];
    [self.agreeBtn setAttributedTitle:text forState:UIControlStateNormal];
    
    [self.agreeBtn.titleLabel yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(6, 12))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        [self presentViewController:pvc animated:YES completion:nil];
    }];
}
- (void)textFieldDidEditing:(UITextField *)textField{
    
    if (textField == self.userNameTF) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {
                //输入
                NSMutableString * str = [[NSMutableString alloc] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }
            if (textField.text.length >= 13 ) {
                //输入完成
                textField.text = [textField.text substringToIndex:13];
                [textField resignFirstResponder];
            }
                i = textField.text.length;
        }else if (textField.text.length < i){
            //删除
            if (textField.text.length == 4 || textField.text.length == 9) {
                textField.text = [NSString stringWithFormat:@"%@",textField.text];
                textField.text = [textField.text substringToIndex:(textField.text.length-1)];
            }
            i = textField.text.length;
        }
    }
}
- (void)textfieldEditChange:(NSNotification *)not{
    
    UITextField *textField = not.object;
        
    if (textField.text.length >= 13){
        
        textField.text = [textField.text substringToIndex:13];
        [self changeBtnType:YES];
    }else{
        
        [self changeBtnType:NO];
    }
}
- (void)changeBtnType:(BOOL )type{
    
    [UIButton setNewVesionBtnEnabeld:self.loginBtn status:type];
}
- (IBAction)wechatLogin:(UIButton *)sender {
    
    
}
- (IBAction)zPayLogin:(UIButton *)sender {
    
    
}
- (IBAction)agreeDelegate:(id)sender {
    
    [self.agreeBtn setImage:IMAGE_NAMED(@"choosed") forState:UIControlStateNormal];
    [UserDefaults setObject:@"1" forKey:@"isAgree"];
}
- (IBAction)login:(id)sender {
    
//    MainTabarViewController *tabBarVC = [MainTabarViewController new];
//    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarVC;
    
    if ([[UserDefaults valueForKey:@"isAgree"] isEqualToString:@"0"]) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请先同意用户协议" AndType:warning IsHideBg:YES AnddataBlock:nil];
        shakeView(self.agreeBtn.layer);
    }else{
        
        if ([DHCCToolsMethod amountToRemoveSpace:self.userNameTF.text].length != 11) {
            
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入正确的手机号" AndType:warning IsHideBg:YES AnddataBlock:nil];
            shakeView(self.userNameTF.layer);
        }else{
            
            [THHttpHelper checkPhoneNumWithPhoneNum:[DHCCToolsMethod amountToRemoveSpace:self.userNameTF.text] block:^(NSInteger returnCode, THRequestStatus status, id data) {
                
                if (![DHCCToolsMethod isEmpty:data] && [[data allKeys] containsObject:@"txt"]) {
                    
                    if ([[data objectForKey:@"txt"] isEqualToString:@"0"]) {
                        
                        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"未注册过的用户请先注册" AndType:warning IsHideBg:NO AnddataBlock:^{
                            
                            RegistOrForgetViewController *vc = [[RegistOrForgetViewController alloc] init];
                            vc.modalPresentationStyle = UIModalPresentationFullScreen;
                            [self presentViewController:vc animated:YES completion:nil];
                        }];
                    }else{
                        //在这切换密码登录和验证码登录
                        SMSCodeViewController *vc = [[SMSCodeViewController alloc] init];
                        vc.userPhone = [DHCCToolsMethod amountToRemoveSpace:self.userNameTF.text];
                        vc.modalPresentationStyle = UIModalPresentationFullScreen;
                        [self presentViewController:vc animated:YES completion:nil];
                    }
                }
            }];
        }
    }
}
- (IBAction)regist:(id)sender {
    
    RegistOrForgetViewController *vc = [[RegistOrForgetViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}
@end
