//
//  RegistOrForgetViewController.m
//  SeaEgret
//
//  Created by MAC on 2021/4/14.
//

#import "RegistOrForgetViewController.h"
#import "YinsiFuwuViewController.h"
#import "MainTabarViewController.h"

@interface RegistOrForgetViewController (){
    
    NSString *_location, *_provinceCode, *_cityCode, *_AreaCode;
    NSInteger i;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLable;

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;

@property (weak, nonatomic) IBOutlet UITextField *smsTF;

@property (weak, nonatomic) IBOutlet LCountdownButton *smsBtn;

@property (weak, nonatomic) IBOutlet UITextField *invitationTF;

@property (weak, nonatomic) IBOutlet UIButton *locationBtn;

@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UIButton *agreeBtn;

@end

@implementation RegistOrForgetViewController
- (IBAction)back:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewDidLoad {
    [super viewDidLoad];

    i=0;
    self.titleLable.text = @"注册";
    
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:@"请输手机号" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style}];
    self.phoneTF.attributedPlaceholder = attributedString;
    self.phoneTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.phoneTF addTarget:self action:@selector(textFieldDidEditing:) forControlEvents:UIControlEventEditingChanged];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldChange:) name:@"UITextFieldTextDidChangeNotification" object:self.phoneTF];
    
    NSMutableParagraphStyle *style1 = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString1 = [[NSAttributedString alloc] initWithString:@"请输入验证码" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style1}];
    self.smsTF.attributedPlaceholder = attributedString1;
    
    NSMutableParagraphStyle *style2 = [[NSMutableParagraphStyle alloc] init];
    NSAttributedString *attributedString2 = [[NSAttributedString alloc] initWithString:@"请输入推荐码(非必填)" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14], NSParagraphStyleAttributeName : style2}];
    self.invitationTF.attributedPlaceholder = attributedString2;

    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:@"已同意并阅读《留莲忘返商户入驻协议》" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],NSForegroundColorAttributeName : color_9}];
    [text setAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14],
                          NSForegroundColorAttributeName : [UIColor colorWithHexString:@"#FA172D"]} range:NSMakeRange(6, 12)];
    self.agreeBtn.titleLabel.attributedText = text;
    [self.agreeBtn setAttributedTitle:text forState:UIControlStateNormal];
    
    [self.agreeBtn.titleLabel yb_addAttributeTapActionWithRanges:@[NSStringFromRange(NSMakeRange(6, 12))] tapClicked:^(UILabel *label, NSString *string, NSRange range, NSInteger index) {
        YinsiFuwuViewController * pvc = [[YinsiFuwuViewController alloc] init];
        
        [self presentViewController:pvc animated:YES completion:nil];
    }];
}
- (void)textFieldDidEditing:(UITextField *)textField{
    
    if (textField == self.phoneTF) {
        if (textField.text.length > i) {
            if (textField.text.length == 4 || textField.text.length == 9 ) {
                //输入
                NSMutableString * str = [[NSMutableString alloc] initWithString:textField.text];
                [str insertString:@" " atIndex:(textField.text.length-1)];
                textField.text = str;
            }if (textField.text.length >= 13 ) {
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
- (void)textFieldChange:(NSNotification *)not{
    
    UITextField *tf = not.object;
    if (self.phoneTF == tf) {
        
        if (tf.text.length >= 13){
            
            tf.text = [tf.text substringToIndex:13];
            [self.smsBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:1.0]];
            self.smsBtn.enabled = YES;
        }else{
            
            [self.smsBtn setBackgroundColor:[UIColor colorWithHexString:@"FA776D" alpha:0.45]];
            self.smsBtn.enabled = NO;
        }
    }else if (self.smsTF == tf){
        
        
    }else if (self.invitationTF == tf){
        
        
    }
}
- (IBAction)getSmsCode:(LCountdownButton *)sender {
    
    if ([DHCCToolsMethod amountToRemoveSpace:self.phoneTF.text].length == 11) {
        
        [self.smsTF becomeFirstResponder];
        [THHttpHelper sendCheckCodeWithPhoneNum:[DHCCToolsMethod amountToRemoveSpace:self.phoneTF.text] AndMsgType:@"Register" block:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [sender buttonWithCountdown:60 normalTitle:@"重新获取" animationTitle:@"s后"];
            }
        }];
    }else{
        
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入手机号" AndType:warning IsHideBg:YES AnddataBlock:nil];
        shakeView(self.phoneTF.layer);
    }
}
- (IBAction)chooseLocation:(UIButton *)sender {

    BRAddressPickerView *pickView = [[BRAddressPickerView alloc] initWithPickerMode:BRAddressPickerModeArea];
    pickView.resultBlock = ^(BRProvinceModel * _Nullable province, BRCityModel * _Nullable city, BRAreaModel * _Nullable area) {
        
        [self.locationBtn setTitle:NSStringFormat(@"%@-%@-%@",province.name,city.name,area.name) forState:UIControlStateNormal];
        self->_location = self.locationBtn.titleLabel.text;
        self->_provinceCode = province.code;
        self->_cityCode = city.code;
        self->_AreaCode = area.code;
    };
    [pickView show];
}
- (IBAction)registOrChangePassword:(id)sender {
    
    //注册
    if ([DHCCToolsMethod amountToRemoveSpace:self.phoneTF.text].length != 11) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入手机号" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (self.smsTF.text.length == 0) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请输入验证码" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    if (!_AreaCode.length || !_cityCode.length || !_provinceCode.length) {
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请选择您的所在区域" AndType:warning IsHideBg:YES AnddataBlock:nil];
        return;
    }
    [THHttpHelper registerWithAreaCode:_AreaCode AndSmsCode:self.smsTF.text AndCityCode:_cityCode AndCommunityCode:@"" AndInviteCode:self.invitationTF.text AndPassword:@"" AndPhoneNum:[DHCCToolsMethod amountToRemoveSpace:self.phoneTF.text] AndprovinceCode:_provinceCode block:^(NSInteger returnCode, THRequestStatus status, THUserModel *model) {
        
        if (returnCode == 200) {
            
            //保存用户数据
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"注册成功" AndType:success IsHideBg:YES AnddataBlock:^{
                
                dispatch_async(dispatch_get_main_queue(), ^{
                        
                    model.userAccount = [DHCCToolsMethod amountToRemoveSpace:self.phoneTF.text];
                    [[THUserManager shareTHUserManager] archiverUserModel:model];
                    [THUserManagerShareTHUserManager setUserModel:model];
                    NSLog(@"+_+_+_+_+_+_+%@",THUserManagerShareTHUserManager.userModel);
                    MainTabarViewController *tabBarVC = [MainTabarViewController new];
                    [UIApplication sharedApplication].delegate.window.rootViewController = tabBarVC;
                });
            }];
        }
    }];
}
- (IBAction)agreeProtocol:(id)sender {
    
    [self.agreeBtn setImage:IMAGE_NAMED(@"choosed") forState:UIControlStateNormal];
    [UserDefaults setObject:@"1" forKey:@"isAgree"];
    [UIButton setNewVesionBtnEnabeld:self.sureBtn status:YES];
}

@end
