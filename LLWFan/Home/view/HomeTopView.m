//
//  HomeTopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/29.
//

#import "HomeTopView.h"
#import "ProductListViewController.h"
#import "ProductDetailViewController.h"

@interface HomeTopView()<SDCycleScrollViewDelegate,JXCategoryViewDelegate>

@property (strong, nonatomic) SDCycleScrollView *bannerCycle, *itemCycle;
@property (strong, nonatomic) UIImageView *image;
@property (strong, nonatomic) UIButton *item1, *item2;
@property (strong, nonatomic) MyLinearLayout *nineProductLy, *miaoshaLy;
@property (nonatomic, strong) JXCategoryTimelineView *myCategoryView;
@property (nonatomic, strong) MyFlowLayout *btnLy;
@property (nonatomic, strong) NSMutableArray *times, *status, *nineProductArr;
@end

@implementation HomeTopView
#pragma mark - init --
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        self.backgroundColor = UIColor.clearColor;
    }
    return self;
}
#pragma mark - action -
- (void)xinren{
    
    
}
- (void)rankList{
    
    
}
- (void)tenKongKingBtnclicked:(UIButton *)sender{
    
    switch (sender.tag) {
            
        case 0:
        {
            ProductListViewController *vc = [[ProductListViewController alloc] init];
            
            [self.currentViewController.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            
        }
            break;
            
        default:
            break;
    }
}
#pragma mark - set -
- (void)setCellWithModel:(KongKimModel *)model{
    
    if (model) {
        
        //金刚区按钮赋值
        [self.btnLy removeAllSubviews];
        NSMutableArray *titleArr = [[NSMutableArray alloc] init];
        NSArray *imgArr = @[@"changhuo",@"9.9",@"shequ",@"shequ",@"zhanggui",@"chongzhi",@"youka",@"jiudian",@"jipiao",@"jipiao"];
        for (KongKinItemModel *itemModel in model.blockDefine) {
            
            [titleArr addObject:itemModel.blockName];
        }
        for (int i = 0; i < titleArr.count; i++) {

            DKSButton *btn = [[DKSButton alloc] initWithFrame:CGRectZero];
            btn.tag = i;
            btn.buttonStyle = DKSButtonImageTop;
            btn.padding = 10;
            btn.myWidth = (ScreenWidth - 24) / 5;
            btn.myHeight = 65;
            [btn setTitle:titleArr[i] forState:UIControlStateNormal];
            [btn setImage:IMAGE_NAMED(imgArr[i]) forState:UIControlStateNormal];
            [btn setTitleColor:color_3 forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:13 weight:UIFontWeightRegular];
            btn.backgroundColor = UIColor.clearColor;
            [btn addTarget:self action:@selector(tenKongKingBtnclicked:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnLy addSubview:btn];
        }
        
        //首页上部banner赋值
        NSArray *bannerImgArr = model.bannerInfos;
        NSMutableArray *banner = [[NSMutableArray alloc] init];
        for (BannerModel *model in bannerImgArr) {
            
            [banner addObject:model.ossImgPath];
        }
        self.bannerCycle.imageURLStringsGroup = banner;
        
        KongKinItemModel *itemModel0 = model.blockDefineCentre[0];
        //首页中部三个金刚区赋值
        self.itemCycle.imageURLStringsGroup = @[itemModel0.logoImgPath];
        KongKinItemModel *itemModel1 = model.blockDefineCentreRight[0];
        [self.item1 setImage:IMAGE_NAMED(NSStringFormat(@"%@",itemModel1.logoImgPath)) forState:UIControlStateNormal];
        KongKinItemModel *itemModel2 = model.blockDefineCentreRight[1];
        [self.item2 setImage:IMAGE_NAMED(NSStringFormat(@"%@",itemModel2.logoImgPath)) forState:UIControlStateNormal];
        
        //底部推荐商品赋值
        self.status = [[NSMutableArray alloc] init];
        self.times = [[NSMutableArray alloc] init];
        for (KongKinItemModel *itemModel in model.blockDefineGoods) {
            
            [self.status addObject:itemModel.blockName];
            [self.times addObject:itemModel.blockDesc];
        }
        
        self.myCategoryView.titles = self.times;
        self.myCategoryView.timeTitles = self.status;
        [self.myCategoryView reloadData];
        
        //中部banner图赋值
        BannerModel *bannerModel = model.bannerAdv[0];
        [self.image sd_setImageWithURL:[NSURL URLWithString:bannerModel.ossImgPath] placeholderImage:IMAGE_NAMED(@"")];
        
        //9.9商品板块赋值
        [self.nineProductLy removeAllSubviews];
        KongKinItemModel *nineNineItemModel = model.blockDefine[1];
        [THHttpManager getBlockGoodsIdsWithBlockId:nineNineItemModel.djlsh AndPageNo:@"1" AndPageSize:@"4" AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            self.nineProductArr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            for (int i = 0; i < self.nineProductArr.count; i++) {
                ProductModel *model = self.nineProductArr[i];
                [self addNineProductWithModel:model AndTag:i];
            }
            [self.rootLy reloadInputViews];
            [self.rootLy setNeedsLayout];
            [self.rootLy layoutIfNeeded];
        }];
    }
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index{
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(chooseWhichKongkingType:)]) {
        [self.delegate chooseWhichKongkingType:index];
    }
}
#pragma mark - initView -
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.subviewVSpace = 10;
    self.rootLy.backgroundColor = UIColor.clearColor;
    self.rootLy.cacheEstimatedRect = YES;
    self.rootLy.gravity = MyGravity_Vert_Center;
    [self.contentView addSubview:self.rootLy];
    
    self.bannerCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:IMAGE_NAMED(@"")];
    self.bannerCycle.autoScroll = YES;
    self.bannerCycle.myHorzMargin = 0;
    self.bannerCycle.myHeight = 140;
    self.bannerCycle.backgroundColor = UIColor.clearColor;
    self.bannerCycle.myTop = 10;
    self.bannerCycle.showPageControl = NO;
    self.bannerCycle.layer.cornerRadius = 8;
    self.bannerCycle.layer.masksToBounds = YES;
    [self.rootLy addSubview:self.bannerCycle];
    
    //创建pageControl
//    XHPageControl *_pageControl = [[XHPageControl alloc] initWithFrame:CGRectZero];
//    _pageControl.myHorzMargin = 0;
//    _pageControl.myHeight = 10;
//    _pageControl.myTop = -20;
//    //设置点的总个数
//    _pageControl.numberOfPages = 3;
//    //设置非选中点的宽度是高度的倍数(设置长条形状)
//    _pageControl.otherMultiple = 1;
//    //设置选中点的宽度是高度的倍数(设置长条形状)
//    _pageControl.currentMultiple = 2;
//    //设置样式.默认居中显示
//    _pageControl.type = PageControlMiddle;
//    //非选中点的颜色
//    _pageControl.otherColor=[UIColor grayColor];
//    //选中点的颜色
//    _pageControl.currentColor=[UIColor bm_colorGradientChangeWithSize:CGSizeMake(12, 5) direction:IHGradientChangeDirectionVertical startColor:[UIColor colorWithHexString:@"#FF6010"] endColor:[UIColor colorNamed:@"color-red"]];
//    //代理
//    _pageControl.delegate = self;
//    [self.rootLy addSubview:_pageControl];
    
//    NSString *className = self.classNames[indexPath.row]; //classNames 字符串数组集
//    Class class = NSClassFromString(className);
//    if (class) {
//        UIViewController *ctrl = class.new;
//        ctrl.title = _titles[indexPath.row]; //_titles 标题数组集
//        [self.navigationController pushViewController:ctrl animated:YES];
//    }
//    <70,65>
    
    MyLinearLayout *btnBackLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    btnBackLy.myHorzMargin = 0;
    btnBackLy.myHeight = MyLayoutSize.wrap;
    [self.rootLy addSubview:btnBackLy];
    
    self.btnLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:5];
    self.btnLy.weight = 1;
    self.btnLy.myHeight = 145;
    self.btnLy.subviewVSpace = 15;
    self.btnLy.subviewHSpace = 0;
    self.btnLy.myTop = 15;
    self.btnLy.backgroundColor = UIColor.clearColor;
    [btnBackLy addSubview:self.btnLy];
    
    MyLinearLayout *utilityLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    utilityLy.myWidth = ScreenWidth - 24;
    utilityLy.myHeight = ScreenWidth * 0.38 + 20;
    utilityLy.subviewHSpace = 10;
    utilityLy.backgroundColor = UIColor.clearColor;
    [self.rootLy addSubview:utilityLy];

    self.itemCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:IMAGE_NAMED(@"")];
    self.itemCycle.autoScroll = YES;
    self.itemCycle.showPageControl = YES;
    self.itemCycle.currentPageDotImage = IMAGE_NAMED(@"");
    self.itemCycle.pageDotImage = IMAGE_NAMED(@"");
    self.itemCycle.myWidth = ScreenWidth * 0.38;
    self.itemCycle.myHeight = ScreenWidth * 0.38 + 20;
    [utilityLy addSubview:self.itemCycle];

    MyLinearLayout *twoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    twoLy.weight = 1;
    twoLy.myHeight = MyLayoutSize.wrap;
    twoLy.subviewVSpace = 10;
    twoLy.backgroundColor = UIColor.clearColor;
    [utilityLy addSubview:twoLy];

    self.item1 = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(xinren) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"" HeightLightBackgroundImage:@""];
    self.item1.myHorzMargin = 0;
    self.item1.myHeight = (ScreenWidth * 0.38 + 10) / 2;
    self.item1.layer.cornerRadius = 5;
    self.item1.layer.masksToBounds = YES;
    [twoLy addSubview:self.item1];

    self.item2 = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(rankList) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"" HeightLightBackgroundImage:@""];
    self.item2.myHorzMargin = 0;
    self.item2.myHeight = (ScreenWidth * 0.38 + 10) / 2;
    self.item2.layer.cornerRadius = 5;
    self.item2.layer.masksToBounds = YES;
    [twoLy addSubview:self.item2];

    self.image = [[UIImageView alloc] initWithFrame:CGRectZero];
    self.image.myHorzMargin = 0;
    self.image.myHeight = 90;
    self.image.myTop = 15;
    self.image.layer.cornerRadius = 8;
    self.image.layer.masksToBounds = YES;
    self.image.backgroundColor = UIColor.clearColor;
    [self.image setImage:IMAGE_NAMED(@"img")];
    [self.rootLy addSubview:self.image];

    MyLinearLayout *nineLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    nineLy.myHorzMargin = 0;
    nineLy.myHeight = MyLayoutSize.wrap;
    nineLy.layer.cornerRadius = 5;
    nineLy.backgroundColor = UIColor.whiteColor;
    nineLy.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    nineLy.layer.cornerRadius = 8;
    nineLy.layer.masksToBounds = YES;
    [self.rootLy addSubview:nineLy];

    MyLinearLayout *nineTitleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    nineTitleLy.myHorzMargin = 0;
    nineTitleLy.myHeight = 30;
    nineTitleLy.gravity = MyGravity_Vert_Center;
    nineTitleLy.backgroundColor = UIColor.clearColor;
    [nineLy addSubview:nineTitleLy];

    //9.9包邮
    UILabel *nineTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    [nineTitle setText:@"9.9包邮"];
    nineTitle.font = [UIFont systemFontOfSize:15];
    nineTitle.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    nineTitle.weight = 1;
    nineTitle.myHeight = 20;
    [nineTitleLy addSubview:nineTitle];

    //右箭头
    UIImageView *right = [[UIImageView alloc] initWithFrame:CGRectZero];
    [right setImage:IMAGE_NAMED(@"youjiantou")];
    right.myWidth = 18;
    right.myHeight = 18;
    [nineTitleLy addSubview:right];

    //9.9 Layout
    self.nineProductLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.nineProductLy.myHorzMargin = 0;
    self.nineProductLy.myHeight = MyLayoutSize.wrap;
    self.nineProductLy.gravity = MyGravity_Vert_Center;
    self.nineProductLy.backgroundColor = UIColor.clearColor;
    self.nineProductLy.subviewHSpace = 8;
    self.nineProductLy.myTop = 4;
    [nineLy addSubview:self.nineProductLy];

    MyLinearLayout *miaoShaBackLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    miaoShaBackLy.myHorzMargin = 0;
    miaoShaBackLy.myHeight = MyLayoutSize.wrap;
    miaoShaBackLy.layer.cornerRadius = 5;
    miaoShaBackLy.backgroundColor = UIColor.whiteColor;
    miaoShaBackLy.padding = UIEdgeInsetsMake(10, 10, 10, 10);
    miaoShaBackLy.layer.cornerRadius = 8;
    miaoShaBackLy.layer.masksToBounds = YES;
    miaoShaBackLy.subviewVSpace = 8;
    [self.rootLy addSubview:miaoShaBackLy];

    MyLinearLayout *miaoshaTitleLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    miaoshaTitleLy.myHorzMargin = 0;
    miaoshaTitleLy.myHeight = 30;
    miaoshaTitleLy.gravity = MyGravity_Vert_Center;
    miaoshaTitleLy.backgroundColor = UIColor.clearColor;
    [miaoShaBackLy addSubview:miaoshaTitleLy];

    //今日秒杀
    UILabel *miaoshaTitle = [[UILabel alloc] initWithFrame:CGRectZero];
    [miaoshaTitle setText:@"今日秒杀"];
    miaoshaTitle.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    miaoshaTitle.textColor = UIColor.redColor;
    miaoshaTitle.weight = 1;
    miaoshaTitle.myHeight = 20;
    [miaoshaTitleLy addSubview:miaoshaTitle];

    self.miaoshaLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.miaoshaLy.myHorzMargin = 0;
    self.miaoshaLy.myHeight = MyLayoutSize.wrap;
    self.miaoshaLy.gravity = MyGravity_Vert_Center;
    self.miaoshaLy.backgroundColor = UIColor.clearColor;
    self.miaoshaLy.subviewHSpace = 8;
    [miaoShaBackLy addSubview:self.miaoshaLy];
    
    for (int i = 0; i < 4; i++) {
        [self addMiaoShaProductWith];
    }
    
    self.myCategoryView = [[JXCategoryTimelineView alloc] init];
    self.myCategoryView.myHorzMargin = 0;
    self.myCategoryView.myHeight = 66;
    self.myCategoryView.backgroundColor = [UIColor clearColor];
    self.myCategoryView.titleFont = [UIFont boldSystemFontOfSize:13];
    self.myCategoryView.titleSelectedFont = [UIFont boldSystemFontOfSize:13];
    self.myCategoryView.titleColor = color_9;
    self.myCategoryView.titleSelectedColor = [UIColor whiteColor];
    self.myCategoryView.titleLabelAnchorPointStyle = JXCategoryTitleLabelAnchorPointStyleBottom;
    self.myCategoryView.titleLabelVerticalOffset = 15;
    //设置顶部时间
    self.myCategoryView.timeTitleFont = [UIFont boldSystemFontOfSize:17];
    self.myCategoryView.timeTitleSelectedFont = [UIFont boldSystemFontOfSize:17];
    self.myCategoryView.timeTitleNormalColor = UIColor.blackColor;
    self.myCategoryView.timeTitleSelectedColor = [UIColor redColor];
    self.myCategoryView.delegate = self;
    [self.rootLy addSubview:self.myCategoryView];

    JXCategoryIndicatorBackgroundView *backgroundView = [[JXCategoryIndicatorBackgroundView alloc] init];
    backgroundView.indicatorHeight = 18;
    backgroundView.indicatorCornerRadius = 9;
    backgroundView.indicatorColor = [UIColor colorNamed:@"color-red"];
    backgroundView.verticalMargin = -15;
    self.myCategoryView.indicators = @[backgroundView];
    
}
- (void)goToProductDetail:(UITapGestureRecognizer *)tap{
    
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.goods = self.nineProductArr[tap.view.tag];
    [self.currentViewController.navigationController pushViewController:vc animated:YES];
}
- (void)addNineProductWithModel:(ProductModel *)model AndTag:(NSInteger )tag{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goToProductDetail:)];
    MyLinearLayout *productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    productLy.myWidth = (ScreenWidth - 64) / 4;
    productLy.myHeight = MyLayoutSize.wrap;
    productLy.subviewVSpace = 10;
    productLy.tag = tag;
    [productLy addGestureRecognizer:tap];
    [self.nineProductLy addSubview:productLy];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectZero];
    img.myWidth = img.myHeight = (ScreenWidth - 64) / 4;
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    [img sd_setImageWithURL:[NSURL URLWithString:model.goodsThumb] placeholderImage:IMAGE_NAMED(@"")];
    [productLy addSubview:img];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectZero];
    title.font = [UIFont systemFontOfSize:12];
    title.textColor = UIColor.blackColor;
    title.myHorzMargin = 0;
    title.myHeight = 20;
    title.text = model.goodsName;
    [productLy addSubview:title];
}
- (void)addMiaoShaProductWith{
    
    MyLinearLayout *productLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    productLy.myWidth = (ScreenWidth - 64) / 4;
    productLy.myHeight = MyLayoutSize.wrap;
    productLy.subviewVSpace = 4;
    [self.miaoshaLy addSubview:productLy];
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectZero];
    img.myWidth = img.myHeight = (ScreenWidth - 64) / 4;
    img.layer.cornerRadius = 5;
    img.layer.masksToBounds = YES;
    [img setImage:IMAGE_NAMED(@"img")];
    [productLy addSubview:img];
    
    UILabel *nowPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    nowPrice.font = [UIFont fontWithName:@"DIN-Medium" size:12];
    nowPrice.textColor = UIColor.redColor;
    nowPrice.myHorzMargin = 0;
    nowPrice.myHeight = MyLayoutSize.wrap;
    nowPrice.text = @"¥99.99";
    [productLy addSubview:nowPrice];
    
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:nowPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Bold" size:14] range:NSMakeRange(1, [nowPrice.text rangeOfString:@"."].location - 1)];
    nowPrice.attributedText = attr;
    
    UILabel *oldprice = [[UILabel alloc] initWithFrame:CGRectZero];
    oldprice.font = [UIFont fontWithName:@"DIN-Regular" size:11];
    oldprice.textColor = color_9;
    oldprice.myHorzMargin = 0;
    oldprice.myHeight = MyLayoutSize.wrap;
    oldprice.text = @"¥99.99";
    [productLy addSubview:oldprice];
    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldprice.text attributes:attribtDic];
    // 赋值
    oldprice.attributedText = attribtStr;
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
