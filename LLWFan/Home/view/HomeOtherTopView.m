//
//  HomeOtherTopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/7.
//

#import "HomeOtherTopView.h"

@interface HomeOtherTopView()<JXCategoryViewDelegate,SDCycleScrollViewDelegate>


@property (strong, nonatomic) MyFlowLayout   *btnLy;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;
@property (strong, nonatomic) SDCycleScrollView *bannerCycle;

@end

@implementation HomeOtherTopView
- (void)setViewWithModel:(CategoryModel *)model{
    
    [self.btnLy removeAllSubviews];
    NSArray *subCategoryArr = model.listVos;
    for (int i = 0; i < subCategoryArr.count; i++) {
        
        CategoryModel *itemModel = subCategoryArr[i];
        DKSButton *btn = [[DKSButton alloc] init];
        btn.buttonStyle = DKSButtonImageTop;
        btn.myWidth = (ScreenWidth  - 24) / 5;
        btn.myHeight = 65;
        btn.padding = 10;
        btn.tag = i;
//        if ([itemModel.categoryName sizeWithLabelHeight:10 font:[UIFont systemFontOfSize:13]].width > (ScreenWidth  - 24) / 5) {
//
//            btn.titleLabel.font = [UIFont systemFontOfSize:10];
//        }else{
            
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
//        }
        [btn setTitle:itemModel.categoryName forState:UIControlStateNormal];
        [btn sd_setImageWithURL:[NSURL URLWithString:itemModel.categoryThumb] forState:UIControlStateNormal];
        [btn setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        [self.btnLy addSubview:btn];
    }
    
    if (model.bannerUrls.count) {
        
        self.bannerCycle.imageURLStringsGroup = model.bannerUrls;
    }else{
        
        self.bannerCycle.visibility = MyVisibility_Gone;
    }
    
    [self.topUtilityLy layoutIfNeeded];
}
#pragma mark - init --
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.topUtilityLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.topUtilityLy.myWidth = ScreenWidth;
    self.topUtilityLy.myHeight = MyLayoutSize.wrap;
    self.topUtilityLy.backgroundColor = UIColor.whiteColor;
    self.topUtilityLy.subviewVSpace = 12;
    self.topUtilityLy.padding = UIEdgeInsetsMake(12, 12, 0, 12);
    self.topUtilityLy.layer.cornerRadius = 8;
    self.topUtilityLy.layer.masksToBounds = YES;
    [self addSubview:self.topUtilityLy];
    
    self.btnLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:5];
    self.btnLy.myHorzMargin = 0;
    self.btnLy.myHeight = MyLayoutSize.wrap;
    self.btnLy.subviewHSpace = 0;
    self.btnLy.subviewVSpace = 4;
    self.btnLy.gravity = MyGravity_Vert_Center;
    [self.topUtilityLy addSubview:self.btnLy];
    
    self.bannerCycle = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:IMAGE_NAMED(@"")];
    self.bannerCycle.myHorzMargin = 0;
    self.bannerCycle.myHeight = 140;
    self.bannerCycle.layer.cornerRadius = 12;
    self.bannerCycle.layer.masksToBounds = YES;
    [self.topUtilityLy addSubview:self.bannerCycle];
    
    self.titles = @[@"综合", @"价格", @"销量", @"店铺"].mutableCopy;
    self.categoryView = [[JXCategoryTitleSortView alloc] init];
    self.categoryView.myHorzMargin = 0;
    self.categoryView.myHeight = 40;
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowNone),
                                    @(3) : @(JXCategoryTitleSortUIType_ArrowNone)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Up)}.mutableCopy;
    self.categoryView.contentEdgeInsetLeft = self.categoryView.contentEdgeInsetRight = 0;
    [self.topUtilityLy addSubview:self.categoryView];
    
    JXCategoryIndicatorAlignmentLineView *line = [[JXCategoryIndicatorAlignmentLineView alloc] init];
    line.indicatorColor = UIColor.redColor;
    line.indicatorHeight = 2;
    line.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[line];
}
#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    JXCategoryTitleSortArrowDirection currentPriceDirection = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(1)].integerValue);

    if (index == 1) {
        
        if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else{
        
        [self.categoryView reloadData];
    }
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.topUtilityLy sizeThatFits:targetSize];
}
@end
