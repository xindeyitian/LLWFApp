//
//  BindAccountViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/27.
//

#import "BindAccountViewController.h"

@interface BindAccountViewController ()

@property (strong, nonatomic) UIButton *bindZpayBtn, *bindWXPayBtn;

@property (strong, nonatomic) UILabel  *remark;

@end

@implementation BindAccountViewController
- (void)bindAccount:(UIButton *)sender{
    
    //
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self setTitle:@"第三方账户提现绑定"];
    self.view.backgroundColor = color_f5;
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootLy.myWidth = ScreenWidth;
    rootLy.myHeight = MyLayoutSize.wrap;
    rootLy.subviewVSpace = 12;
    rootLy.backgroundColor = color_f5;
    [self.view addSubview:rootLy];
    
    MyLinearLayout *backLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    backLy.myHorzMargin = 12;
    backLy.myHeight = MyLayoutSize.wrap;
    backLy.padding = UIEdgeInsetsMake(20, 12, 10, 12);
    backLy.myTop = 12;
    backLy.layer.cornerRadius = 12;
    backLy.layer.masksToBounds = YES;
    backLy.gravity = MyGravity_Horz_Center;
    backLy.backgroundColor = UIColor.whiteColor;
    [rootLy addSubview:backLy];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"请选择绑定的第三方" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [backLy addSubview:title];
    
    MyLinearLayout *zPAyLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    zPAyLy.myHorzMargin = 0;
    zPAyLy.myHeight = 40;
    zPAyLy.gravity = MyGravity_Vert_Center;
    zPAyLy.myTop = 20;
    zPAyLy.subviewHSpace = 12;
    [backLy addSubview:zPAyLy];
    
    UIImageView *zImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"zPay")];
    zImg.myWidth = zImg.myHeight = 18;
    [zPAyLy addSubview:zImg];
    
    UILabel *zlabl = [BaseLabel CreateBaseLabelStr:@"支付宝支付" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    zlabl.myWidth = zlabl.myHeight = MyLayoutSize.wrap;
    [zPAyLy addSubview:zlabl];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [zPAyLy addSubview:nilView];
    
    self.bindZpayBtn = [BaseButton CreateBaseButtonTitle:@"去绑定" Target:self Action:@selector(bindAccount:) Font:[UIFont systemFontOfSize:13] BackgroundColor:UIColor.whiteColor Color:[UIColor colorNamed:@"color-red"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.bindZpayBtn.myWidth = self.bindZpayBtn.myHeight = MyLayoutSize.wrap;
    [zPAyLy addSubview:self.bindZpayBtn];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:0 tailIndent:0];
    zPAyLy.bottomBorderline = line;
    
    MyLinearLayout *wxPAyLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    wxPAyLy.myHorzMargin = 0;
    wxPAyLy.myHeight = 40;
    wxPAyLy.gravity = MyGravity_Vert_Center;
    wxPAyLy.subviewHSpace = 12;
    [backLy addSubview:wxPAyLy];
    
    UIImageView *wxImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"wxPay")];
    wxImg.myWidth = wxImg.myHeight = 18;
    [wxPAyLy addSubview:wxImg];
    
    UILabel *wxlabl = [BaseLabel CreateBaseLabelStr:@"微信支付" Font:[UIFont systemFontOfSize:15] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    wxlabl.myWidth = wxlabl.myHeight = MyLayoutSize.wrap;
    [wxPAyLy addSubview:wxlabl];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 1;
    [wxPAyLy addSubview:nilView1];
    
    self.bindWXPayBtn = [BaseButton CreateBaseButtonTitle:@"去绑定" Target:self Action:@selector(bindAccount:) Font:[UIFont systemFontOfSize:13] BackgroundColor:UIColor.whiteColor Color:[UIColor colorNamed:@"color-red"] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.bindWXPayBtn.myWidth = self.bindWXPayBtn.myHeight = MyLayoutSize.wrap;
    [wxPAyLy addSubview:self.bindWXPayBtn];
    
    MyLinearLayout *remarkLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    remarkLy.myHorzMargin = 12;
    remarkLy.myHeight = MyLayoutSize.wrap;
    remarkLy.backgroundColor = UIColor.whiteColor;
    remarkLy.layer.cornerRadius = 12;
    remarkLy.layer.masksToBounds = YES;
    remarkLy.gravity = MyGravity_Horz_Center;
    remarkLy.padding = UIEdgeInsetsMake(20, 12, 10, 12);
    [rootLy addSubview:remarkLy];
    
    UILabel *remarkLable = [BaseLabel CreateBaseLabelStr:@"提现绑定说明" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightMedium] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    remarkLable.myWidth = remarkLable.myHeight = MyLayoutSize.wrap;
    [remarkLy addSubview:remarkLable];
    
//    self.remark = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont sys] Color:<#(UIColor *)#> Frame:<#(CGRect)#> Alignment:<#(NSTextAlignment)#> Tag:<#(NSInteger)#>]
    
}
@end
