//
//  MerchantDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/12.
//

#import "MerchantDetailViewController.h"

@interface MerchantDetailViewController ()<UINavigationControllerDelegate>

@property (strong, nonatomic) MyLinearLayout      *topLy;
@property (strong, nonatomic) UITextField         *searchTF;
@property (strong, nonatomic) UIImageView         *merchantImg;
@property (strong, nonatomic) UILabel             *merchantName;
@property (strong, nonatomic) UIButton            *attentionBtn;
@property (strong, nonatomic) UILabel             *pingjia, *wuliu, *shouhou;
@property (strong, nonatomic) UILabel             *pingjiaLevel, *wuliuLevel, *shouhouLevel;
@property (strong, nonatomic) UILabel             *area, *time;

@end

@implementation MerchantDetailViewController
- (void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)attentionBtnClicked:(UIButton *)sender{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager saveShopCollectWithShopId:NSStringFormat(@"%ld",self.model.shopId) AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (sender.isSelected) {
                //未收藏
                [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
                [self.attentionBtn setImage:IMAGE_NAMED(@"aixin") forState:UIControlStateNormal];
                [self.attentionBtn setBackgroundColor:[UIColor colorNamed:@"color-red"]];
                self.attentionBtn.layer.borderColor = [UIColor colorNamed:@"color-red"].CGColor;
                self.attentionBtn.layer.borderWidth = 1;
            }else{
                //已收藏
                [self.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
                [self.attentionBtn setImage:IMAGE_NAMED(@"") forState:UIControlStateNormal];
                [self.attentionBtn setBackgroundColor:UIColor.clearColor];
                self.attentionBtn.layer.borderColor = UIColor.whiteColor.CGColor;
                self.attentionBtn.layer.borderWidth = 1;
            }
            sender.selected = !sender.isSelected;
        }else{
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    }];
}
- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.delegate = self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    [self initTopView];
}
- (void)initTopView{
   
    MyLinearLayout *rootly = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    rootly.myWidth = ScreenWidth;
    rootly.myHeight = MyLayoutSize.wrap;
    [self.view addSubview:rootly];
    
    self.topLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.topLy.myWidth = ScreenWidth;
    self.topLy.myHeight = 210;
    self.topLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    self.topLy.subviewVSpace = 12;
    UIImageView *img = [[UIImageView alloc] init];
    [img sd_setImageWithURL:[NSURL URLWithString:self.model.bgImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    self.topLy.backgroundImage = img.image;
    [rootly addSubview:self.topLy];

    MyLinearLayout *searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    searchLy.myHorzMargin = 0;
    searchLy.myHeight = 30;
    searchLy.gravity = MyGravity_Vert_Center;
    searchLy.backgroundColor = UIColor.clearColor;
    searchLy.myTop = RootStatusBarHeight;
    [self.topLy addSubview:searchLy];

    UIButton *backBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(back) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"back-white" HeightLightBackgroundImage:@"back-white"];
    backBtn.myWidth = backBtn.myHeight = 24;
    backBtn.backgroundColor = UIColor.clearColor;
    [searchLy addSubview:backBtn];

    MyLinearLayout *textFieldLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    textFieldLy.weight = 1;
    textFieldLy.myHeight = 30;
    textFieldLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5" alpha:0.45];
    textFieldLy.layer.cornerRadius = 6;
    textFieldLy.layer.masksToBounds = YES;
    textFieldLy.gravity = MyGravity_Vert_Center;
    [searchLy addSubview:textFieldLy];

    UIImageView *imgfdj = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    imgfdj.myWidth = img.myHeight = 20;
    imgfdj.myLeft = 12;
    [textFieldLy addSubview:imgfdj];

    self.searchTF = [[UITextField alloc] initWithFrame:CGRectZero];
    self.searchTF.placeholder = @"可搜索本店商品";
    self.searchTF.weight = 1;
    self.searchTF.myHeight = 44;
    self.searchTF.font = [UIFont systemFontOfSize:12];
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textFieldLy addSubview:self.searchTF];

    MyLinearLayout *merchantLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    merchantLy.myHorzMargin = 0;
    merchantLy.myHeight = 44;
    merchantLy.gravity = MyGravity_Vert_Center;
    merchantLy.backgroundColor = UIColor.clearColor;
    [self.topLy addSubview:merchantLy];

    self.merchantImg = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.merchantImg.myWidth = self.merchantImg.myHeight = 44;
    self.merchantImg.layer.cornerRadius = 5;
    self.merchantImg.layer.masksToBounds = YES;
    [self.merchantImg sd_setImageWithURL:[NSURL URLWithString:self.model.logoImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    [merchantLy addSubview:self.merchantImg];

    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.weight = 1;
    infoLy.myHeight = 44;
    infoLy.backgroundColor = UIColor.clearColor;
    infoLy.myLeft = 12;
    infoLy.gravity = MyGravity_Fill;
    [merchantLy addSubview:infoLy];

    self.merchantName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.merchantName.font = [UIFont systemFontOfSize:15 weight:UIFontWeightMedium];
    self.merchantName.textColor = UIColor.whiteColor;
    self.merchantName.text = self.model.shopName;
    self.merchantName.myHorzMargin = 0;
    self.merchantName.myHeight = MyLayoutSize.wrap;
    [infoLy addSubview:self.merchantName];

    MyLinearLayout *starLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    starLy.myHorzMargin = 0;
    starLy.myHeight = MyLayoutSize.wrap;
    starLy.backgroundColor = UIColor.clearColor;
    [infoLy addSubview:starLy];

    UILabel *starLable = [[UILabel alloc] initWithFrame:CGRectZero];
    starLable.text = @"店铺星级";
    starLable.font = [UIFont systemFontOfSize:12];
    starLable.textColor = [UIColor colorWithHexString:@"#FFFFFF" alpha:0.8];
    starLable.myHeight = 20;
    starLable.myWidth = MyLayoutSize.wrap;
    [starLy addSubview:starLable];

    self.attentionBtn = [BaseButton CreateBaseButtonTitle:@"关注" Target:self Action:@selector(attentionBtnClicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.attentionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.attentionBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    self.attentionBtn.myWidth = 70;
    self.attentionBtn.myHeight = 28;
    self.attentionBtn.layer.cornerRadius = 14;
    self.attentionBtn.layer.masksToBounds = YES;
    self.attentionBtn.myLeft = 12;
    self.attentionBtn.selected = self.model.isCollect;
    [self.attentionBtn setImage:IMAGE_NAMED(@"aixin") forState:UIControlStateNormal];
    [merchantLy addSubview:self.attentionBtn];
    
    if (!self.model.isCollect) {
        //未收藏
        [self.attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [self.attentionBtn setImage:IMAGE_NAMED(@"aixin") forState:UIControlStateNormal];
        [self.attentionBtn setBackgroundColor:[UIColor colorNamed:@"color-red"]];
        self.attentionBtn.layer.borderColor = [UIColor colorNamed:@"color-red"].CGColor;
        self.attentionBtn.layer.borderWidth = 1;
    }else{
        //已收藏
        [self.attentionBtn setTitle:@"已关注" forState:UIControlStateNormal];
        [self.attentionBtn setImage:IMAGE_NAMED(@"") forState:UIControlStateNormal];
        [self.attentionBtn setBackgroundColor:UIColor.clearColor];
        self.attentionBtn.layer.borderColor = UIColor.whiteColor.CGColor;
        self.attentionBtn.layer.borderWidth = 1;
    }
   
    MyLinearLayout *numLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    numLy.myHorzMargin = 12;
    numLy.myHeight = 60;
    numLy.layer.cornerRadius = 8;
    numLy.myTop = -50;
    numLy.gravity = MyGravity_Fill;
    numLy.backgroundColor = UIColor.whiteColor;
    numLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    [rootly addSubview:numLy];
    
    MyLinearLayout *pingjiaLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    pingjiaLy.myWidth = (ScreenWidth - 48) / 3;
    pingjiaLy.myHeight = MyLayoutSize.wrap;
    pingjiaLy.gravity = MyGravity_Vert_Center;
    pingjiaLy.subviewHSpace = 5;
    [numLy addSubview:pingjiaLy];
    
    UILabel *pjTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    pjTitle.text = @"评价";
    pjTitle.font = [UIFont systemFontOfSize:12];
    pjTitle.textColor = color_6;
    pjTitle.myWidth = pjTitle.myHeight = MyLayoutSize.wrap;
    [pingjiaLy addSubview:pjTitle];
    
    self.pingjia = [[UILabel alloc] initWithFrame:CGRectZero];
    self.pingjia.font = [UIFont fontWithName:@"DIN-Medium" size:18];
    self.pingjia.textColor = UIColor.blackColor;
    self.pingjia.text = self.model.appraisalValue;
    self.pingjia.myWidth = self.pingjia.myHeight = MyLayoutSize.wrap;
    [pingjiaLy addSubview:self.pingjia];
    
    self.pingjiaLevel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.pingjiaLevel.myWidth = self.pingjiaLevel.myHeight = 17;
    self.pingjiaLevel.layer.cornerRadius = 8.5;
    self.pingjiaLevel.layer.masksToBounds = YES;
    self.pingjiaLevel.textAlignment = NSTextAlignmentCenter;
    self.pingjiaLevel.text = @"高";
    self.pingjiaLevel.backgroundColor = [UIColor colorWithHexString:@"#FA172D" alpha:0.1];
    self.pingjiaLevel.font = [UIFont systemFontOfSize:10];
    [pingjiaLy addSubview:self.pingjiaLevel];
    
    MyLinearLayout *wuliuLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    wuliuLy.myWidth = (ScreenWidth - 24) / 3;
    wuliuLy.myHeight = MyLayoutSize.wrap;
    wuliuLy.gravity = MyGravity_Center;
    wuliuLy.subviewHSpace = 5;
    [numLy addSubview:wuliuLy];
    
    UILabel *wlTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    wlTitle.text = @"物流";
    wlTitle.font = [UIFont systemFontOfSize:12];
    wlTitle.textColor = color_6;
    wlTitle.myWidth = wlTitle.myHeight = MyLayoutSize.wrap;
    [wuliuLy addSubview:wlTitle];
    
    self.wuliu = [[UILabel alloc] initWithFrame:CGRectZero];
    self.wuliu.font = [UIFont fontWithName:@"DIN-Medium" size:18];
    self.wuliu.textColor = UIColor.blackColor;
    self.wuliu.text = self.model.logisticsValue;
    self.wuliu.myWidth = self.wuliu.myHeight = MyLayoutSize.wrap;
    [wuliuLy addSubview:self.wuliu];
    
    self.wuliuLevel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.wuliuLevel.myWidth = self.wuliuLevel.myHeight = 17;
    self.wuliuLevel.layer.cornerRadius = 8.5;
    self.wuliuLevel.layer.masksToBounds = YES;
    self.wuliuLevel.textAlignment = NSTextAlignmentCenter;
    self.wuliuLevel.text = @"高";
    self.wuliuLevel.backgroundColor = [UIColor colorWithHexString:@"#FA172D" alpha:0.1];
    self.wuliuLevel.font = [UIFont systemFontOfSize:10];
    [wuliuLy addSubview:self.wuliuLevel];
    
    MyLinearLayout *shouhouLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    shouhouLy.myWidth = (ScreenWidth - 24) / 3;
    shouhouLy.myHeight = MyLayoutSize.wrap;
    shouhouLy.gravity = MyGravity_Vert_Center;
    shouhouLy.subviewHSpace = 5;
    [numLy addSubview:shouhouLy];
    
    UIView *nilV = [[UIView alloc] init];
    nilV.weight = 1;
    nilV.myHeight = MyLayoutSize.wrap;
    [shouhouLy addSubview:nilV];
    
    UILabel *shTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    shTitle.text = @"售后";
    shTitle.font = [UIFont systemFontOfSize:12];
    shTitle.textColor = color_6;
    shTitle.myWidth = shTitle.myHeight = MyLayoutSize.wrap;
    [shouhouLy addSubview:shTitle];
    
    self.shouhou = [[UILabel alloc] initWithFrame:CGRectZero];
    self.shouhou.font = [UIFont fontWithName:@"DIN-Medium" size:18];
    self.shouhou.textColor = UIColor.blackColor;
    self.shouhou.text = self.model.afterSaleValue;
    self.shouhou.myWidth = self.shouhou.myHeight = MyLayoutSize.wrap;
    [shouhouLy addSubview:self.shouhou];
    
    self.shouhouLevel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.shouhouLevel.myWidth = self.shouhouLevel.myHeight = 17;
    self.shouhouLevel.layer.cornerRadius = 8.5;
    self.shouhouLevel.layer.masksToBounds = YES;
    self.shouhouLevel.textAlignment = NSTextAlignmentCenter;
    self.shouhouLevel.text = @"高";
    self.shouhouLevel.backgroundColor = [UIColor colorWithHexString:@"#FA172D" alpha:0.1];
    self.shouhouLevel.font = [UIFont systemFontOfSize:10];
    [shouhouLy addSubview:self.shouhouLevel];
    
    MyLinearLayout *detailInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    detailInfoLy.myHorzMargin = 12;
    detailInfoLy.myHeight = 104;
    detailInfoLy.padding = UIEdgeInsetsMake(0, 12, 0, 12);
    detailInfoLy.layer.cornerRadius = 8;
    detailInfoLy.layer.masksToBounds = YES;
    detailInfoLy.backgroundColor = UIColor.whiteColor;
    detailInfoLy.myTop = 12;
    [rootly addSubview:detailInfoLy];
    
    MyLinearLayout *areaLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    areaLy.myHorzMargin = 0;
    areaLy.myHeight = 52;
    areaLy.gravity = MyGravity_Vert_Center;
    [detailInfoLy addSubview:areaLy];
    
    UILabel *areaTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    areaTitle.text = @"店铺所在地";
    areaTitle.font = [UIFont systemFontOfSize:15];
    areaTitle.textColor = color_9;
    areaTitle.myWidth = areaTitle.myHeight = MyLayoutSize.wrap;
    [areaLy addSubview:areaTitle];
    
    UIView *nil1 = [[UIView alloc] initWithFrame:CGRectZero];
    nil1.weight = 1;
    nil1.myHeight = 52;
    [areaLy addSubview:nil1];
    
    self.area = [[UILabel alloc] initWithFrame:CGRectZero];
    self.area.font = [UIFont systemFontOfSize:15];
    self.area.textColor = UIColor.blackColor;
    self.area.text = NSStringFormat(@"%@-%@",self.model.provinceName,self.model.cityName);
    self.area.myWidth = self.area.myHeight = MyLayoutSize.wrap;
    [areaLy addSubview:self.area];
    
    MyBorderline *line = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#F5F5F5"] thick:1 headIndent:12 tailIndent:12];
    areaLy.bottomBorderline = line;
    
    MyLinearLayout *timeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    timeLy.myHorzMargin = 0;
    timeLy.myHeight = 52;
    timeLy.gravity = MyGravity_Vert_Center;
    [detailInfoLy addSubview:timeLy];
    
    UILabel *timeTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    timeTitle.text = @"开店时间";
    timeTitle.font = [UIFont systemFontOfSize:15];
    timeTitle.textColor = color_9;
    timeTitle.myWidth = timeTitle.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:timeTitle];
    
    UIView *nil2 = [[UIView alloc] initWithFrame:CGRectZero];
    nil2.weight = 1;
    nil2.myHeight = 52;
    [timeLy addSubview:nil2];
    
    self.time = [[UILabel alloc] initWithFrame:CGRectZero];
    self.time.font = [UIFont systemFontOfSize:15];
    self.time.textColor = UIColor.blackColor;
    self.time.text = self.model.createTime;
    self.time.myWidth = self.time.myHeight = MyLayoutSize.wrap;
    [timeLy addSubview:self.time];
}
#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if ([viewController isKindOfClass:[self class]]) {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }else {
        [navigationController setNavigationBarHidden:NO animated:YES];
    }
}
@end
