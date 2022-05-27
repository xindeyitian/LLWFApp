//
//  UpgradeViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/5.
//

#import "UpgradeViewController.h"
#import "UpGradeView.h"

@interface UpgradeViewController ()<UINavigationControllerDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) UpGradeView   *upgradeCardView;
@property (strong, nonatomic) UIScrollView  *topScroll;
@property (strong, nonatomic) XHPageControl *pageCtrl;
@property (strong, nonatomic) UIButton      *upgradeBtn;

@end

@implementation UpgradeViewController
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)agree:(UIButton *)sender{
    
    
}
- (void)upgradeLevel{
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    self.view.clipsToBounds = YES;
    
    UIImageView *topBackImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"upgradeTop")];
    topBackImg.frame = CGRectMake(0, -1, ScreenWidth, 210);
    [self.view addSubview:topBackImg];
    
    [self initNavView];
    
    UIScrollView *infoScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, KNavBarHeight, ScreenWidth, ScreenHeight - KNavBarHeight)];
    infoScroll.showsVerticalScrollIndicator = NO;
    [self.view addSubview:infoScroll];
    
    self.topScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(40, 0, ScreenWidth - 60, 220)];
    self.topScroll.contentSize = CGSizeMake((ScreenWidth - 80) * 3 + 40, 0);
    self.topScroll.showsHorizontalScrollIndicator = NO;
    self.topScroll.clipsToBounds = NO;
    self.topScroll.pagingEnabled = YES;
    self.topScroll.delegate = self;
    [infoScroll addSubview:self.topScroll];
    
    MyFlowLayout *cardLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:3];
    cardLy.myHeight = 220;
    cardLy.myWidth = (ScreenWidth - 80) * 3 + 40;
    cardLy.subviewHSpace = 20;
    cardLy.gravity = MyGravity_Vert_Center;
    [self.topScroll addSubview:cardLy];
    
    for (int i = 0; i < 3; i++) {
        
        UpGradeView *card = [[UpGradeView alloc] initWithFrame:CGRectZero];
        card.myWidth = ScreenWidth - 80;
        card.myHeight = 220;
        [cardLy addSubview:card];
    }
    
    self.pageCtrl = [[XHPageControl alloc] initWithFrame:CGRectMake(ScreenWidth / 2 - 20, 190, 40, 10)];
    self.pageCtrl.numberOfPages = 3;
    self.pageCtrl.currentPage = 0;
    self.pageCtrl.currentColor = [UIColor colorNamed:@"color-red"];
    self.pageCtrl.otherColor = [UIColor colorWithHexString:@"#000000" alpha:0.2];
    [infoScroll addSubview:self.pageCtrl];
    
    MyLinearLayout *imgLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    imgLy.myHorzMargin = 0;
    imgLy.myHeight = MyLayoutSize.wrap;
    imgLy.subviewVSpace = 16;
    imgLy.myTop = 220;
    [infoScroll addSubview:imgLy];
    
    for (int i = 1; i < 4; i++) {
        
        UIImageView *img = [[UIImageView alloc] initWithImage:IMAGE_NAMED(NSStringFormat(@"%d",i))];
        img.myHorzMargin = 9;
        img.myHeight = MyLayoutSize.wrap;
        [imgLy addSubview:img];
    }
    
    MyLinearLayout *bottomView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    bottomView.myHorzMargin = 0;
    bottomView.myHeight = 125;
    bottomView.backgroundColor = UIColor.whiteColor;
    bottomView.padding = UIEdgeInsetsMake(12, 10, 16, 10);
    bottomView.subviewVSpace = 12;
    [imgLy addSubview:bottomView];
    
    UIButton *yinsiBtn = [BaseButton CreateBaseButtonTitle:@"特别提醒：请仔细阅读《系统服务商协议》如您同意协议内容并打“✓”证明您同意签订以上协议" Target:self Action:@selector(agree:) Font:[UIFont systemFontOfSize:13] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"rightChoose" HeightLightBackgroundImage:@"rightChoose"];
    [yinsiBtn setTitleColor:color_3 forState:UIControlStateNormal];
    yinsiBtn.myHorzMargin = 0;
    yinsiBtn.myHeight = 30;
    yinsiBtn.imageEdgeInsets = UIEdgeInsetsMake(-5, 0, 0, 0);
    yinsiBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    [bottomView addSubview:yinsiBtn];
    
    self.upgradeBtn = [BaseButton CreateBaseButtonTitle:@"立即开通 ¥9999" Target:self Action:@selector(upgradeLevel) Font:[UIFont systemFontOfSize:18 weight:UIFontWeightSemibold] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.upgradeBtn.myHorzMargin = 0;
    self.upgradeBtn.myHeight = 50;
    self.upgradeBtn.layer.cornerRadius = 25;
    self.upgradeBtn.layer.masksToBounds = YES;
    [bottomView addSubview:self.upgradeBtn];
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.topScroll) {
        
        NSInteger page = scrollView.contentOffset.x / (ScreenWidth - 80);
        self.pageCtrl.currentPage = page;
    }
}
- (void)initNavView{
    
    MyLinearLayout *topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    topLy.myHorzMargin = 0;
    topLy.myHeight = MyLayoutSize.wrap;
    topLy.backgroundColor = UIColor.clearColor;
    [self.view addSubview:topLy];
    
    MyLinearLayout *navView = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    navView.backgroundColor = UIColor.clearColor;
    navView.myHorzMargin = 12;
    navView.myHeight = 44;
    navView.myTop = RootStatusBarHeight;
    navView.gravity = MyGravity_Vert_Center;
    [topLy addSubview:navView];
    
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
    navTitleLable.myLeft = -24;
    navTitleLable.text = @"权益中心";
    [navView addSubview:navTitleLable];
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
