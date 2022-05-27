//
//  ProductTopView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "ProductTopView.h"

@interface ProductTopView()<JXCategoryViewDelegate,SDCycleScrollViewDelegate>
{
    NSInteger type, way;
}
@property (strong, nonatomic) SDCycleScrollView *cycleView;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;

@end

@implementation ProductTopView
- (void)setModel:(ShopModel *)model{
    
    _model = model;
    NSMutableArray *urlArr = @[].mutableCopy;
    for (AdvertisingModel *advModel in model.imgUrls) {
        
        [urlArr addObject:advModel.imgUrl];
    }
    if (urlArr.count) {
        
        self.cycleView.imageURLStringsGroup = urlArr;
    }else{
        
        self.cycleView.visibility = MyVisibility_Gone;
    }
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
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.gravity = MyGravity_Horz_Center;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.subviewVSpace = 12;
    [self addSubview:self.rootLy];
    
    self.cycleView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:IMAGE_NAMED(@"")];
    self.cycleView.myHorzMargin = 12;
    self.cycleView.myHeight = 140;
    self.cycleView.myTop = 12;
    self.cycleView.showPageControl = NO;
    self.cycleView.layer.cornerRadius = 12;
    self.cycleView.layer.masksToBounds = YES;
    [self.rootLy addSubview:self.cycleView];
    
    self.titles = @[@"综合", @"价格", @"销量"].mutableCopy;
    self.categoryView = [[JXCategoryTitleSortView alloc] init];
    self.categoryView.myHorzMargin = 0;
    self.categoryView.myHeight = 40;
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Up),
                                          @(2) : @(JXCategoryTitleSortArrowDirection_Up)
    }.mutableCopy;
    [self.rootLy addSubview:self.categoryView];
    
    JXCategoryIndicatorAlignmentLineView *line = [[JXCategoryIndicatorAlignmentLineView alloc] init];
    line.indicatorColor = UIColor.redColor;
    line.indicatorHeight = 2;
    line.indicatorWidth = 32;
    self.categoryView.indicators = @[line];
    
}
#pragma mark - JXCategoryViewDelegate

- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    JXCategoryTitleSortArrowDirection currentPriceDirection = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(1)].integerValue);
    JXCategoryTitleSortArrowDirection currentPriceDirection1 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);

    if (index == 1) {
        
        if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Down);
            way = 2;
        }else{
            way = 1;
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }else if (index == 2){
        if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Up){
            
            way = 2;
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            way = 1;
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
    }
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(chooseSortType:AndSortWay:)]) {
        
        [self.delegate chooseSortType:index AndSortWay:way];
    }
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
