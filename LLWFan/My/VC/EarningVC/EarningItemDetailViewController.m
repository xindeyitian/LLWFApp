//
//  EarningItemDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/20.
//

#import "EarningItemDetailViewController.h"

@interface EarningItemDetailViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) UILabel *navTitleLable, *fromTitle, *numLable, *time, *orderID, *oldLable, *oldNum, *remark;
@property (strong, nonatomic) MyLinearLayout *oldLy;

@end

@implementation EarningItemDetailViewController
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
    
    switch (self.navType) {
        case 0:
        {
            //总抵用金
            self.navTitleLable.text = @"抵用金详情";
            self.oldLable.text = @"抵用金";
            self.remark.text = @"注：“抵用金”是本次操作之前的总数";
            self.fromTitle.text = @"平台转换收益";
        }
            break;
        case 2:
        {
            //总贡献值
            self.navTitleLable.text = @"我的贡献值";
            self.oldLable.text = @"当前总贡献值";
            self.remark.text = @"注：“贡献值”是本次操作之前的总数";
            self.fromTitle.text = @"平台转换收益";
        }
            break;
        case 3:
        {
            //总留莲值
            self.navTitleLable.text = @"我的留莲值";
            self.oldLable.text = @"当前总留莲值";
            self.remark.text = @"注：“留莲值”是本次操作之前的总数";
            self.fromTitle.text = @"平台转换收益";
        }
            break;
        case 4:
        {
            //总留莲值
            self.navTitleLable.text = @"预估收益详情";
//            self.oldLable.text = @"model赋值";
            self.fromTitle.text = @"model赋值";//这个传model赋值
//            self.remark.text = @"注：“留莲值”是本次操作之前的总数";
            self.remark.visibility = MyVisibility_Gone;
            self.oldLy.visibility = MyVisibility_Gone;
        }
            break;
            
        default:
            break;
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
    
    self.navTitleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.navTitleLable.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.navTitleLable.textColor = UIColor.whiteColor;
    self.navTitleLable.weight = 1;
    self.navTitleLable.myHeight = MyLayoutSize.wrap;
    self.navTitleLable.textAlignment = NSTextAlignmentCenter;
    self.navTitleLable.myLeft = -24;
    [navView addSubview:self.navTitleLable];
    
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    numLy.myHorzMargin = 12;
    numLy.myHeight = MyLayoutSize.wrap;
    numLy.myTop = 9;
    numLy.layer.cornerRadius = 8;
    numLy.layer.masksToBounds = YES;
    numLy.gravity = MyGravity_Horz_Center;
    numLy.backgroundColor = UIColor.whiteColor;
    numLy.paddingBottom = 16;
    [rootLy addSubview:numLy];
    
    self.fromTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    self.fromTitle.font = [UIFont systemFontOfSize:13];
    self.fromTitle.textColor = color_3;
    self.fromTitle.myWidth = self.fromTitle.myHeight = MyLayoutSize.wrap;
    self.fromTitle.myTop = 24;
    [numLy addSubview:self.fromTitle];
    
    self.numLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.numLable.font = [UIFont fontWithName:@"DIN-Medium" size:26];
    self.numLable.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.numLable.text = @"+4.5900";
    self.numLable.myWidth = self.numLable.myHeight = MyLayoutSize.wrap;
    self.numLable.myTop = 12;
    [numLy addSubview:self.numLable];
    
    MyLinearLayout *detailLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    detailLy.myHorzMargin = 12;
    detailLy.myHeight = MyLayoutSize.wrap;
    detailLy.myTop = 12;
    detailLy.layer.cornerRadius = 8;
    detailLy.layer.masksToBounds = YES;
    detailLy.backgroundColor = UIColor.whiteColor;
    detailLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    [rootLy addSubview:detailLy];
    
    MyLinearLayout *timeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    timeLy.myHorzMargin = 0;
    timeLy.myHeight = MyLayoutSize.wrap;
    [detailLy addSubview:timeLy];
    
    UILabel *timeLable = [BaseLabel CreateBaseLabelStr:@"创建时间" Font:[UIFont systemFontOfSize:17] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    timeLable.weight = 1;
    timeLable.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:timeLable];
    
    self.time = [BaseLabel CreateBaseLabelStr:@"2022-03-12 12:30" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.time.myWidth = self.time.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:self.time];
    
    MyLinearLayout *orderLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    orderLy.myHorzMargin = 0;
    orderLy.myHeight = MyLayoutSize.wrap;
    orderLy.myTop = 24;
    [detailLy addSubview:orderLy];
    
    UILabel *orderLable = [BaseLabel CreateBaseLabelStr:@"订单编号" Font:[UIFont systemFontOfSize:17] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    orderLable.weight = 1;
    orderLable.myHeight = MyLayoutSize.wrap;
    [orderLy addSubview:orderLable];
    
    self.orderID = [BaseLabel CreateBaseLabelStr:@"SF89087680087797" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.orderID.myWidth = self.orderID.myHeight = MyLayoutSize.wrap;
    [orderLy addSubview:self.orderID];
    
    self.oldLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.oldLy.myHorzMargin = 0;
    self.oldLy.myHeight = MyLayoutSize.wrap;
    self.oldLy.myTop = 24;
    [detailLy addSubview:self.oldLy];
    
    self.oldLable = [BaseLabel CreateBaseLabelStr:@"贡献值" Font:[UIFont systemFontOfSize:17] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    self.oldLable.weight = 1;
    self.oldLable.myHeight = MyLayoutSize.wrap;
    [self.oldLy addSubview:self.oldLable];
    
    self.oldNum = [BaseLabel CreateBaseLabelStr:@"1398.0000" Font:[UIFont systemFontOfSize:15] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.oldNum.myWidth = self.oldNum.myHeight = MyLayoutSize.wrap;
    [self.oldLy addSubview:self.oldNum];
    
    self.remark = [BaseLabel CreateBaseLabelStr:@"注：“抵用金”是本次操作之前的总数" Font:[UIFont systemFontOfSize:13] Color:color_9 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.remark.myWidth = self.remark.myHeight = MyLayoutSize.wrap;
    self.remark.myTop = 4;
    [detailLy addSubview:self.remark];
    
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
