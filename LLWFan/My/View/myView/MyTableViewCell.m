//
//  MyTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/18.
//

#import "MyTableViewCell.h"
#import "MoneyView.h"
#import "SettingViewController.h"
#import "CerViewController.h"
#import "CollectionBaseViewController.h"
#import "MyEarningViewController.h"
#import "FootprintViewController.h"
#import "OrderBaseViewController.h"
#import "FeedBackViewController.h"
#import "AddressListViewController.h"
#import "MyFansViewController.h"
#import "UpgradeViewController.h"

@interface MyTableViewCell()<AllPopNoticeViewDelegate>

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView *userHeaderImg;
@property (strong, nonatomic) UILabel     *userName, *userMakeMoney, *upgradeLable;
@property (strong, nonatomic) MoneyView *moneyView;
@property (weak,   nonatomic) LSTPopView      *pop;
@property (strong, nonatomic) NSMutableArray *btnArr;

@end

@implementation MyTableViewCell
- (void)setCellWithModel:(THUserWithDrawModel *)model{
    
    self.userMakeMoney.text = NSStringFormat(@"已经在留莲忘返赚了%ld元",model.totalIncome);
    self.moneyView.model = model;
    [self.userHeaderImg sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:IMAGE_NAMED(@"")];
    DKSButton *dfkBtn = self.btnArr[0];
    [dfkBtn reloadPointWithNum:model.orderCountWaitPay];
    DKSButton *dfhBtn = self.btnArr[1];
    [dfhBtn reloadPointWithNum:model.orderCountWaitSend];
    DKSButton *dshBtn = self.btnArr[2];
    [dshBtn reloadPointWithNum:model.orderCountWaitRecv];
}
- (void)fourBtnClicked:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
        {
            //预估收益
            MyEarningViewController *vc = [[MyEarningViewController alloc] init];
            vc.navType = 4;
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            //收藏
            CollectionBaseViewController *vc = [[CollectionBaseViewController alloc] init];
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
            //足迹
            FootprintViewController *vc = [[FootprintViewController alloc] init];
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 6:
        {
            //消息
            
        }
            break;
            
        default:
            break;
    }
}
- (void)goToUpgrade{
    
    UpgradeViewController *vc = [[UpgradeViewController alloc]init];
    
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}
- (void)serviceBtnClicked:(UIButton *)sender{
    
    switch (sender.tag) {
        case 0:
        {
            AddressListViewController *vc = [[AddressListViewController alloc] init];
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:
        {
            MyFansViewController *vc = [[MyFansViewController alloc] init];
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 2:
        {
            SettingViewController *vc = [[SettingViewController alloc] init];
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            AllPopNoticeView *view = [[AllPopNoticeView alloc] initWithFrame:CGRectZero AndrightBtnTitle:@"致电" AndTitle:@"客服电话" AndContent:@"客服服务热线：18970897898"];
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
            break;
        case 4:
        {
            
            FeedBackViewController *vc = [[FeedBackViewController alloc] init];
            
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 5:
        {
            
        }
            break;
        case 6:
        {
            
            CerViewController *vc = [[CerViewController alloc] init];
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 7:
        {
            
        }
            break;
            
        default:
            break;
    }
}
- (void)clickRightBtn {
    [self.pop dismiss];
}
- (void)orderBtnClicked:(DKSButton *)sender{

    OrderBaseViewController *vc = [[OrderBaseViewController alloc] init];
    if (sender.tag != 4) {
        
        vc.orderType = sender.tag + 1;
    }else{
        vc.orderType = -100;
    }
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}
- (void)otherOrderClicked{
    
    OrderBaseViewController *vc = [[OrderBaseViewController alloc] init];
    vc.orderType = -100;
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = UIColor.clearColor;
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.padding = UIEdgeInsetsMake(12 + RootStatusBarHeight, 0, 0, 0);
    [self.contentView addSubview:self.rootLy];
    //内容布局
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.backgroundColor = UIColor.clearColor;
    [self.rootLy addSubview:contentLy];
    
    MyLinearLayout *userInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    userInfoLy.myHorzMargin = 12;
    userInfoLy.myHeight = MyLayoutSize.wrap;
    userInfoLy.backgroundColor = UIColor.clearColor;
    userInfoLy.subviewHSpace = 12;
    [contentLy addSubview:userInfoLy];
    
    self.userHeaderImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"")];;
    self.userHeaderImg.layer.cornerRadius = 28;
    self.userHeaderImg.layer.masksToBounds = YES;
    self.userHeaderImg.myWidth = self.userHeaderImg.myHeight = 56;
    [self.userHeaderImg sd_setImageWithURL:[NSURL URLWithString:THUserManagerShareTHUserManager.userModel.avatar] placeholderImage:IMAGE_NAMED(@"")];
    [userInfoLy addSubview:self.userHeaderImg];
    
    MyLinearLayout *userRightLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    userRightLy.weight = 1;
    userRightLy.myHeight = MyLayoutSize.wrap;
    userRightLy.backgroundColor = UIColor.clearColor;
    userRightLy.subviewVSpace = 4;
    [userInfoLy addSubview:userRightLy];
    
    MyLinearLayout *userTitleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    userTitleLy.myHorzMargin = 0;
    userTitleLy.myHeight = MyLayoutSize.wrap;
    userInfoLy.backgroundColor = UIColor.clearColor;
    [userRightLy addSubview:userTitleLy];
    
    self.userName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.userName.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    self.userName.textColor = [UIColor colorWithHexString:@"222222"];
    self.userName.text = THUserManagerShareTHUserManager.userModel.realName;
    self.userName.myWidth = self.userName.myHeight = MyLayoutSize.wrap;
    [userTitleLy addSubview:self.userName];
    
    //预留等级图标位置
    
    ////////////////////////////
    self.userMakeMoney = [[UILabel alloc] initWithFrame:CGRectZero];
    self.userMakeMoney.font = [UIFont systemFontOfSize:12];
    self.userMakeMoney.textColor = color_9;
    self.userMakeMoney.text = @"已经在留莲忘返赚了389元";
    self.userMakeMoney.myWidth = self.userMakeMoney.myHeight = MyLayoutSize.wrap;
    [userRightLy addSubview:self.userMakeMoney];
    
    MyLinearLayout *btnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    btnLy.gravity = MyGravity_Vert_Center;
    btnLy.padding = UIEdgeInsetsMake(10, 15, 0, 15);
    btnLy.myHorzMargin = 0;
    btnLy.myHeight = MyLayoutSize.wrap;
    [contentLy addSubview:btnLy];
    
    NSArray *titleArr = @[@"预估收益",@"",@"收藏",@"",@"足迹", @"", @"消息"];
    NSArray *imageArr = @[@"",@"",@""];
    for (int i = 0; i < 7; i++) {
        
        if (i % 2 == 0) {
            
            DKSButton *btn = [DKSButton buttonWithType:UIButtonTypeCustom withSpace:10];
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setTitleColor:color_6 forState:UIControlStateNormal];
            [btn setImage:IMAGE_NAMED(@"daihuo") forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(fourBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            btn.buttonStyle = DKSButtonImageTop;
            btn.padding = 4;
            btn.myHeight = 100;
            btn.myWidth = 60;
            btn.tag = i;
            [btnLy addSubview:btn];
            
        }else{
            
            UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
            nilView.weight = 1;
            nilView.myHeight = 1;
            [btnLy addSubview:nilView];
        }
    }
    
    UITapGestureRecognizer *upgradeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToUpgrade)];
    
    MyLinearLayout *upgradeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    upgradeLy.myHorzMargin = 0;
    upgradeLy.myHeight = 44;
    upgradeLy.padding = UIEdgeInsetsMake(10, 23, 10, 12);
    upgradeLy.gravity = MyGravity_Vert_Center;
    upgradeLy.backgroundColor = UIColor.blackColor;
    [upgradeLy addGestureRecognizer:upgradeTap];
    [contentLy addSubview:upgradeLy];
    //    添加刷新标记
    [self setNeedsLayout];
    [self layoutIfNeeded];
    UIBezierPath *maskPath1 = [UIBezierPath bezierPathWithRoundedRect:upgradeLy.bounds   byRoundingCorners:UIRectCornerTopLeft   |   UIRectCornerTopRight    cornerRadii:CGSizeMake(8, 8)];
    CAShapeLayer *maskLayer1 = [[CAShapeLayer alloc] init];
    maskLayer1.frame = upgradeLy.bounds;
    maskLayer1.path = maskPath1.CGPath;
    upgradeLy.layer.mask = maskLayer1;
    
    self.upgradeLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.upgradeLable.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.upgradeLable.textColor = [UIColor colorWithHexString:@"f9d58c"];
    self.upgradeLable.text = @"升级服务商，收益涨不停";
    self.upgradeLable.myWidth  = self.upgradeLable.myHeight = MyLayoutSize.wrap;
    [upgradeLy addSubview:self.upgradeLable];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    nilView.backgroundColor = UIColor.clearColor;
    [upgradeLy addSubview:nilView];
    
    UILabel *kaitong = [[UILabel alloc] initWithFrame:CGRectZero];
    kaitong.font = [UIFont systemFontOfSize:12];
    kaitong.textColor = [UIColor colorWithHexString:@"404040"];
    kaitong.text = @"立即开通";
    kaitong.myWidth = 72;
    kaitong.myHeight = 25;
    kaitong.layer.cornerRadius = 12.5;
    kaitong.layer.masksToBounds = YES;
    kaitong.textAlignment = NSTextAlignmentCenter;
    kaitong.backgroundColor = [UIColor bm_colorGradientChangeWithSize:CGSizeMake(72, 25) direction:IHGradientChangeDirectionLevel startColor:[UIColor colorWithHexString:@"#FFDFA2"] endColor:[UIColor colorWithHexString:@"#FFCF6F"]];
    [upgradeLy addSubview:kaitong];
    
    self.moneyView = [[[NSBundle mainBundle] loadNibNamed:@"MoneyView" owner:self options:nil] lastObject];
    self.moneyView.myHorzMargin = 0;
    self.moneyView.myHeight = 222;
    self.moneyView.layer.cornerRadius = 8;
    self.moneyView.layer.masksToBounds = YES;
    self.moneyView.myTop = 12;
    [contentLy addSubview:self.moneyView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(otherOrderClicked)];
    
    MyLinearLayout *orderLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    orderLy.myHorzMargin = 0;
    orderLy.myHeight = MyLayoutSize.wrap;
    orderLy.padding = UIEdgeInsetsMake(12, 0, 12, 0);
    orderLy.layer.cornerRadius = 8;
    orderLy.layer.masksToBounds = YES;
    orderLy.backgroundColor = UIColor.whiteColor;
    orderLy.myTop = 12;
    [orderLy addGestureRecognizer:tap];
    [contentLy addSubview:orderLy];
    
    MyLinearLayout *orderTitleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    orderTitleLy.myHorzMargin = 12;
    orderTitleLy.myWidth = MyLayoutSize.wrap;
    orderTitleLy.gravity = MyGravity_Vert_Center;
    orderTitleLy.myTop = 12;
    [orderLy addSubview:orderTitleLy];
    
    UILabel *shopOrder = [[UILabel alloc] initWithFrame:CGRectZero];
    shopOrder.text = @"商城订单";
    shopOrder.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    shopOrder.textColor = color_3;
    shopOrder.myWidth = 70;
    shopOrder.myHeight = MyLayoutSize.wrap;
    [orderTitleLy addSubview:shopOrder];
    
    UIView *nilView1 = [[UIView alloc] initWithFrame:CGRectZero];
    nilView1.weight = 1;
    nilView1.myHeight = 1;
    nilView1.backgroundColor = UIColor.clearColor;
    [orderTitleLy addSubview:nilView1];
    
    UIButton *otherOrder = [BaseButton CreateBaseButtonTitle:@"其他订单" Target:self Action:@selector(otherOrderClicked) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    otherOrder.myWidth = otherOrder.myHeight = MyLayoutSize.wrap;
    [orderTitleLy addSubview:otherOrder];
    
    MyLinearLayout *orderBtnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    orderBtnLy.myHeight = MyLayoutSize.wrap;
    orderBtnLy.myHorzMargin = 0;
    orderBtnLy.myTop = 16;
    [orderLy addSubview:orderBtnLy];
    
    self.btnArr = @[].mutableCopy;
    NSArray *btnTitleArr = @[@"待付款",@"待发货",@"待收货",@"待售后",@"已完成"];
    
    for (int i = 0; i < 5; i++) {
        
        DKSButton *btn = [[DKSButton alloc] initWithFrame:CGRectZero];
        btn.tag = i;
        btn.buttonStyle = DKSButtonImageTop;
        btn.padding = 4;
        btn.myWidth = (ScreenWidth - 24) / 5;
        btn.myHeight = 60;
        [btn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        [btn setTitleColor:color_3 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(orderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setImage:IMAGE_NAMED(@"fensi") forState:UIControlStateNormal];
        [orderBtnLy addSubview:btn];
        [self.btnArr addObject:btn];
    }
    
    MyLinearLayout *myServiceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    myServiceLy.myHorzMargin = 0;
    myServiceLy.myHeight = MyLayoutSize.wrap;
    myServiceLy.myTop = 12;
    myServiceLy.padding = UIEdgeInsetsMake(12, 0, 12, 0);
    myServiceLy.backgroundColor = UIColor.whiteColor;
    myServiceLy.layer.cornerRadius = 8;
    myServiceLy.layer.masksToBounds = YES;
    [contentLy addSubview:myServiceLy];
    
    UILabel *serviceLable = [[UILabel alloc] initWithFrame:CGRectZero];
    serviceLable.font = [UIFont systemFontOfSize:17 weight:UIFontWeightMedium];
    serviceLable.textColor = color_3;
    serviceLable.text = @"我的服务";
    serviceLable.myLeft = 12;
    serviceLable.myWidth = serviceLable.myHeight = MyLayoutSize.wrap;
    [myServiceLy addSubview:serviceLable];
    
    MyFlowLayout *serviceBtnLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:4];
    serviceBtnLy.myHorzMargin = 0;
    serviceBtnLy.myHeight = MyLayoutSize.wrap;
    serviceBtnLy.subviewHSpace = 0;
    serviceBtnLy.subviewVSpace = 16;
    serviceBtnLy.myTop = 16;
    [myServiceLy addSubview:serviceBtnLy];
    
    NSArray *serviceTitle = @[@"收货地址",@"我的粉丝",@"设置",@"客服帮助",@"反馈建议",@"商学院",@"实名认证",@"开通商户"];
    NSArray *serviceImage = @[@"shouhuo",@"fensi",@"shezhi",@"kefu",@"fankui",@"shangxueyuan",@"shiming",@"kaitong"];
    for (int i = 0; i < 8; i++) {
        
        DKSButton *btn = [[DKSButton alloc] initWithFrame:CGRectZero];
        btn.buttonStyle = DKSButtonImageTop;
        btn.padding = 10;
        btn.myWidth = (ScreenWidth - 24) / 4;
        btn.myHeight = 60;
        btn.tag = i;
        [btn setTitle:serviceTitle[i] forState:UIControlStateNormal];
        [btn setImage:IMAGE_NAMED(serviceImage[i]) forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        [btn setTitleColor:color_3 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(serviceBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [serviceBtnLy addSubview:btn];
    }
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
