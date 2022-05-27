//
//  ProductListHeaderReusableView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/13.
//

#import "ProductListHeaderReusableView.h"

@interface ProductListHeaderReusableView()<JXCategoryViewDelegate>
{
    NSInteger _index;
}
@property (strong, nonatomic) MyLinearLayout          *rootly;
@property (strong, nonatomic) JXCategoryTitleSortView *categoryView;
@property (strong, nonatomic) UITextField             *searchTF;

@end

@implementation ProductListHeaderReusableView
-(void)searchProduct{
    
    
}
- (void)back{
    
    [[THAPPService shareAppService].currentViewController.navigationController popViewControllerAnimated:YES];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootly = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootly.myWidth = ScreenWidth;
    self.rootly.myHeight = MyLayoutSize.wrap;
    self.rootly.backgroundImage = IMAGE_NAMED(@"header");
    [self addSubview:self.rootly];
    
    MyLinearLayout *navLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    navLy.myHorzMargin = 12;
    navLy.myHeight = 44;
    navLy.gravity = MyGravity_Vert_Center;
    navLy.subviewHSpace = 12;
    navLy.myTop = RootStatusBarHeight;
    [self.rootly addSubview:navLy];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    backBtn.myWidth = backBtn.myHeight = 24;
    [backBtn setImage:IMAGE_NAMED(@"back-white") forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [navLy addSubview:backBtn];
    
    MyLinearLayout *searchLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    searchLy.weight = 1;
    searchLy.myHeight = 30;
    searchLy.layer.cornerRadius = 6;
    searchLy.layer.masksToBounds = YES;
    searchLy.backgroundColor = [UIColor colorWithHexString:@"f5f5f5" alpha:0.45];
    searchLy.gravity = MyGravity_Vert_Center;
    [navLy addSubview:searchLy];
    
    UIImageView *fangdajing = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"放大镜")];
    fangdajing.myWidth = fangdajing.myHeight = 20;
    fangdajing.myLeft = 12;
    [searchLy addSubview:fangdajing];
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectZero];
    NSMutableAttributedString *place = [[NSMutableAttributedString alloc] initWithString:@"可搜索本店商品"];
    [place addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"ffffff"] range:NSMakeRange(0, place.length)];
    self.searchTF.attributedPlaceholder = place;
    self.searchTF.weight = 1;
    self.searchTF.myHeight = 44;
    self.searchTF.font = [UIFont systemFontOfSize:12];
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.myLeft = 4;
    [searchLy addSubview:self.searchTF];
    
    UIButton *searchBtn = [BaseButton CreateBaseButtonTitle:@"搜索" Target:self Action:@selector(searchProduct) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.clearColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    searchBtn.myWidth = 50;
    searchBtn.myHeight = 30;
    [navLy addSubview:searchBtn];
    
    
    self.categoryView = [[JXCategoryTitleSortView alloc] init];
    self.categoryView.myWidth = ScreenWidth;
    self.categoryView.myHeight = 42;
    self.categoryView.myTop = 144;
    self.categoryView.delegate = self;
    self.categoryView.titles = @[@"综合",@"销量",@"价格",@"店铺"];
    self.categoryView.titleSelectedColor = [UIColor colorNamed:@"color-red"];
    self.categoryView.titleColor = color_9;
    self.categoryView.titleColorGradientEnabled = YES;
    self.categoryView.backgroundColor = UIColor.whiteColor;
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(3) : @(JXCategoryTitleSortUIType_ArrowNone)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Up),
                                          @(2) : @(JXCategoryTitleSortArrowDirection_Up)}.mutableCopy;
    [self.rootly addSubview:self.categoryView];
    
    JXCategoryIndicatorLineView *lineView = [[JXCategoryIndicatorLineView alloc] init];
    lineView.indicatorColor = UIColor.whiteColor;
    lineView.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[lineView];
    
}
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    _index = index;
    
    JXCategoryTitleSortArrowDirection currentPriceDirection1 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(1)].integerValue);
    JXCategoryTitleSortArrowDirection currentPriceDirection2 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);
    JXCategoryTitleSortArrowDirection currentPriceDirection3 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(3)].integerValue);
    if (index == 1) {
        
        if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else if (index == 2){
        
        if (currentPriceDirection2 == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection2 == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else if (index == 3){
        
        if (currentPriceDirection3 == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection3 == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else{
        
        [self.categoryView reloadData];
    }
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootly sizeThatFits:targetSize];
}
@end
