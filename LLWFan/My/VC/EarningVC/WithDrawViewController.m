//
//  WithDrawViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/20.
//

#import "WithDrawViewController.h"
#import "WithDrawRecordViewController.h"

@interface WithDrawViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) UILabel *withDrawLable;
@property (strong, nonatomic) UITextField *withDrawTF;
@property (strong, nonatomic) MyLinearLayout *withDrawTypeLy;
@property (strong, nonatomic) UIButton   *withDrawBtn;

@end

@implementation WithDrawViewController

- (void)checkRecord{
    //查看提现记录
    WithDrawRecordViewController *vc = [[WithDrawRecordViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)sureWithDraw{
    //确认提现
    
}
- (void)bindZPay{
    //绑定支付宝
    
}
- (void)bindWXPay{
    //绑定微信
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    UIImageView *topView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 310)];
    topView.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(ScreenWidth, 310) direction:IHGradientChangeDirectionVertical startColor:[UIColor colorNamed:@"color-red"] endColor:[UIColor colorWithHexString:@"#F5F5F5"]];
    [self.view addSubview:topView];
    
    [self initCusView];
    
    if (self.withDrawType == 0) {
        //贡献值提余额
        self.withDrawTypeLy.visibility = MyVisibility_Gone;
        self.withDrawLable.text = @"提现到余额";
    }else{
        //余额提现
        self.withDrawTypeLy.visibility = MyVisibility_Visible;
        self.withDrawLable.text = @"提现金额";
    }
}
- (void)initCusView{
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myHorzMargin = 0;
    rootLy.myHeight = MyLayoutSize.wrap;
    rootLy.backgroundColor = UIColor.clearColor;
    [self.view addSubview:rootLy];
    
    MyLinearLayout *navView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    navView.backgroundColor = UIColor.clearColor;
    navView.myHorzMargin = 12;
    navView.myHeight = 44;
    navView.myTop = RootStatusBarHeight;
    navView.gravity = MyGravity_Vert_Center;
    [rootLy addSubview:navView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:IMAGE_NAMED(@"return-white") forState:UIControlStateNormal];
    backBtn.myWidth = backBtn.myHeight = 24;
    [navView addSubview:backBtn];
    
    UILabel *navTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    navTitleLable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    navTitleLable.textColor = UIColor.whiteColor;
    navTitleLable.weight = 1;
    navTitleLable.myHeight = MyLayoutSize.wrap;
    navTitleLable.textAlignment = NSTextAlignmentCenter;
    navTitleLable.myLeft = 24;
    navTitleLable.text = @"我要提现";
    [navView addSubview:navTitleLable];
    
    UIButton *withDrawRecord = [BaseButton CreateBaseButtonTitle:@"提现记录" Target:self Action:@selector(checkRecord) Font:[UIFont systemFontOfSize:13] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    withDrawRecord.myWidth = withDrawRecord.myHeight = MyLayoutSize.wrap;
    [navView addSubview:withDrawRecord];
    
    MyLinearLayout *withDrawLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    withDrawLy.myHorzMargin = 12;
    withDrawLy.myHeight = MyLayoutSize.wrap;
    withDrawLy.padding = UIEdgeInsetsMake(22, 12, 12, 12);
    withDrawLy.myTop = 9;
    withDrawLy.layer.cornerRadius = 8;
    withDrawLy.layer.masksToBounds = YES;
    withDrawLy.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:withDrawLy];
    
    self.withDrawLable = [BaseLabel CreateBaseLabelStr:@"提现到余额" Font:[UIFont systemFontOfSize:15] Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.withDrawLable.myWidth = self.withDrawLable.myHeight = MyLayoutSize.wrap;
    [withDrawLy addSubview:self.withDrawLable];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 0;
    numLy.myHeight = MyLayoutSize.wrap;
    numLy.subviewHSpace = 8;
    numLy.gravity = MyGravity_Vert_Center;
    numLy.myTop = 12;
    numLy.paddingBottom = 6;
    [withDrawLy addSubview:numLy];
    
    UILabel *rmb = [BaseLabel CreateBaseLabelStr:@"¥" Font:[UIFont systemFontOfSize:24] Color:[UIColor colorWithHexString:@"222222"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    rmb.myWidth = rmb.myHeight = MyLayoutSize.wrap;
    [numLy addSubview:rmb];
    
    self.withDrawTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.withDrawTF.font = [UIFont fontWithName:@"DIN Alternate Bold" size:32];
    self.withDrawTF.textColor = [UIColor colorWithHexString:@"222222"];
    self.withDrawTF.weight = 1;
    self.withDrawTF.myHeight = MyLayoutSize.wrap;
    self.withDrawTF.placeholder = @"0.00";
    self.withDrawTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.withDrawTF.keyboardType = UIKeyboardTypeNumberPad;
    [self.withDrawTF addTarget:self action:@selector(withDraw:) forControlEvents:UIControlEventEditingChanged];
    [numLy addSubview:self.withDrawTF];
    
    UIButton *button =[self.withDrawTF valueForKey:@"_clearButton"];
    [button setImage:IMAGE_NAMED(@"clearBtn") forState:UIControlStateNormal];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#E5E5E5"] thick:0.5];
    numLy.bottomBorderline = line;
    
    self.withDrawBtn = [BaseButton CreateBaseButtonTitle:@"确认提现" Target:self Action:@selector(sureWithDraw) Font:[UIFont systemFontOfSize:18] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.withDrawBtn.myHorzMargin = 0;
    self.withDrawBtn.myHeight = 50;
    self.withDrawBtn.layer.cornerRadius = 25;
    self.withDrawBtn.layer.masksToBounds = YES;
    self.withDrawBtn.myTop = 12;
    [withDrawLy addSubview:self.withDrawBtn];
    
    [UIButton setNewVesionBtnEnabeld:self.withDrawBtn status:NO];
    
    self.withDrawTypeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.withDrawTypeLy.myHorzMargin = 12;
    self.withDrawTypeLy.myHeight = MyLayoutSize.wrap;
    self.withDrawTypeLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    self.withDrawTypeLy.subviewVSpace = 8;
    self.withDrawTypeLy.backgroundColor = UIColor.whiteColor;
    self.withDrawTypeLy.layer.cornerRadius = 8;
    self.withDrawTypeLy.layer.masksToBounds = YES;
    self.withDrawTypeLy.myTop = 12;
    [rootLy addSubview:self.withDrawTypeLy];
    
    MyLinearLayout *wxLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    wxLy.myHorzMargin = 0;
    wxLy.myHeight = MyLayoutSize.wrap;
    wxLy.gravity = MyGravity_Vert_Center;
    wxLy.subviewHSpace = 8;
    wxLy.paddingBottom = 12;
    [self.withDrawTypeLy addSubview:wxLy];
    
    MyBorderline *line1 = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#E6E6E6"] thick:0.5];
    wxLy.bottomBorderline = line1;
    
    UIImageView *wxImage = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"wxPay")];
    wxImage.myWidth = wxImage.myHeight = 24;
    [wxLy addSubview:wxImage];
    
    UILabel *wxLable = [BaseLabel CreateBaseLabelStr:@"微 信" Font:[UIFont systemFontOfSize:14] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    wxLable.myWidth = wxLable.myHeight = MyLayoutSize.wrap;
    [wxLy addSubview:wxLable];
    
    UIButton *bindWXBtn = [BaseButton CreateBaseButtonTitle:@"未绑定" Target:self Action:@selector(bindWXPay) Font:[UIFont systemFontOfSize:14] BackgroundColor:UIColor.clearColor Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    bindWXBtn.myWidth = MyLayoutSize.wrap;
    bindWXBtn.myHeight = 30;
    [wxLy addSubview:bindWXBtn];
    
    UIView *wxNilView = [[UIView alloc] initWithFrame:CGRectZero];
    wxNilView.weight = 1;
    wxNilView.myHeight = 1;
    [wxLy addSubview:wxNilView];
    
    UIImageView *chooseWXImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"choose")];
    chooseWXImg.myWidth = chooseWXImg.myHeight = 18;
    [wxLy addSubview:chooseWXImg];
    
    MyLinearLayout *zPayLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    zPayLy.myHorzMargin = 0;
    zPayLy.myHeight = MyLayoutSize.wrap;
    zPayLy.gravity = MyGravity_Vert_Center;
    zPayLy.subviewHSpace = 8;
    [self.withDrawTypeLy addSubview:zPayLy];
    
    UIImageView *zImage = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"zPay")];
    zImage.myWidth = zImage.myHeight = 24;
    [zPayLy addSubview:zImage];
    
    UILabel *zLable = [BaseLabel CreateBaseLabelStr:@"支付宝" Font:[UIFont systemFontOfSize:14] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    zLable.myWidth = zLable.myHeight = MyLayoutSize.wrap;
    [zPayLy addSubview:zLable];
    
    UIButton *bindZBtn = [BaseButton CreateBaseButtonTitle:@"未绑定" Target:self Action:@selector(bindZPay) Font:[UIFont systemFontOfSize:14] BackgroundColor:UIColor.clearColor Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    bindZBtn.myWidth = MyLayoutSize.wrap;
    bindZBtn.myHeight = 30;
    [zPayLy addSubview:bindZBtn];
    
    UIView *zNilView = [[UIView alloc] initWithFrame:CGRectZero];
    zNilView.weight = 1;
    zNilView.myHeight = 1;
    [zPayLy addSubview:zNilView];
    
    UIImageView *chooseZImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"choose")];
    chooseZImg.myWidth = chooseZImg.myHeight = 18;
    [zPayLy addSubview:chooseZImg];
    
    UILabel *noticeLable = [BaseLabel CreateBaseLabelStr:@"小莲提示：\n1、提现金额应为¥100的整数倍；\n2、单日提现最高额度为¥500，超过¥500则T+1日到账，如遇节假日顺延到工作日；(T为交易日)\n3、支付宝/微信的实名与平台实名认证需一致；\n4、每日可提现一次。" Font:[UIFont systemFontOfSize:12] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    noticeLable.myHorzMargin = 12;
    noticeLable.myHeight = MyLayoutSize.wrap;
    noticeLable.numberOfLines = 0;
    noticeLable.myTop = 12;
    [noticeLable changeLineSpace:4];
    [rootLy addSubview:noticeLable];
    
}
- (void)withDraw:(UITextField *)textField{
    
    if (textField.text.length > 0) {
        [UIButton setNewVesionBtnEnabeld:self.withDrawBtn status:YES];
    }else{
        [UIButton setNewVesionBtnEnabeld:self.withDrawBtn status:NO];
    }
}
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}
@end
