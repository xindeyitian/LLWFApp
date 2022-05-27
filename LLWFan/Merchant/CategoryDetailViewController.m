//
//  CategoryDetailViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "CategoryDetailViewController.h"
#import "CategoryPopView.h"
#import "HomeCollectionViewCell.h"

@interface CategoryDetailViewController ()<JXCategoryViewDelegate,THFlowLayoutDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSInteger way, type;
}
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;//菜单标题view
@property (nonatomic, strong) NSArray <NSString *> *titles;
@property (strong, nonatomic) UICollectionView *homeCollection;

@end

@implementation CategoryDetailViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    SetIOS13
}
- (void)getDataWithIsNew:(BOOL )isNew{
    /// 店铺商品分页列表
    /// @param categoryID 分类编号
    /// @param keyWord 搜索关键字
    /// @param pageNo 页码
    /// @param pageSize 每页条数
    /// @param shopId 店铺编号
    /// @param sortType 排序类型 1价格 ,2销量
    /// @param sortWay 排序排序方式1升序,2降序
    /// @param block block description

    if (isNew) {
        self.page = 1;
    }else{
        self.page += 1;
    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [THHttpManager queryShopGoodsPageWithCategoryID:self.shopCategoryId AndKeyWord:@"" AndPageNo:self.page AndPageSize:@"10" AndShopID:self.shopId AndSortType:NSStringFormat(@"%ld",type) AndSortWay:NSStringFormat(@"%ld",way) AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200 && ![DHCCToolsMethod isEmpty:data]) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.homeCollection.mj_header endRefreshing];
            [self.homeCollection.mj_footer endRefreshing];

            NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            
            if (isNew) {
                self.dataSorce = arr.mutableCopy;
            }else{
                [self.dataSorce addObjectsFromArray:arr];
            }
            
            [self.homeCollection reloadData];
            if (arr.count < 10) {

                [self.homeCollection.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.homeCollection.mj_footer endRefreshingWithNoMoreData];
            [self.homeCollection.mj_header endRefreshing];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"产品分类"];
    way = 0;
    type = 0;
    self.titles = @[@"综合", @"价格", @"销量"].mutableCopy;
    self.categoryView = [[JXCategoryTitleSortView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 42)];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Up),
                                          @(2) : @(JXCategoryTitleSortArrowDirection_Up)
    }.mutableCopy;
    self.categoryView.contentEdgeInsetLeft = self.categoryView.contentEdgeInsetRight = 16;
    self.categoryView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.categoryView];
    
    JXCategoryIndicatorAlignmentLineView *line = [[JXCategoryIndicatorAlignmentLineView alloc] init];
    line.indicatorColor = UIColor.redColor;
    line.indicatorHeight = 2;
    line.indicatorWidth = JXCategoryViewAutomaticDimension;
    self.categoryView.indicators = @[line];
    
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
    layout.isHeaderStick = YES;

    self.homeCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(12, 42, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 42) collectionViewLayout:layout];
     self.homeCollection.prefetchingEnabled = NO;
    self.homeCollection.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.homeCollection.scrollEnabled = YES;
    self.homeCollection.dataSource = self;
    self.homeCollection.delegate = self;
    self.homeCollection.showsVerticalScrollIndicator = NO;
    self.homeCollection.showsHorizontalScrollIndicator = NO;
    self.homeCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.homeCollection];
    [self.homeCollection reloadData];
    [self.homeCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    
    self.homeCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    self.homeCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    [self.homeCollection.mj_header beginRefreshing];
}
#pragma mark - collectionViewDelegate datasorce--------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSorce.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    [cell initCellWithModel:self.dataSorce[indexPath.item]];
    return cell;
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = self.dataSorce[indexPath.item];
    return model.height;
}
#pragma mark - JXCategoryViewDelegate
- (void)categoryView:(JXCategoryBaseView *)categoryView didSelectedItemAtIndex:(NSInteger)index {
    
    type = index;
    JXCategoryTitleSortArrowDirection currentPriceDirection = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(1)].integerValue);
    JXCategoryTitleSortArrowDirection currentPriceDirection1 = (JXCategoryTitleSortArrowDirection)(self.categoryView.arrowDirections[@(2)].integerValue);

    if (index == 1) {
        
        if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Down);
            way = 2;
        }else{
            
            self.categoryView.arrowDirections[@(1)] = @(JXCategoryTitleSortArrowDirection_Up);
            way = 1;
        }
        [self.categoryView reloadData];
    }else if (index == 2){
        if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection1 == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Down);
            way = 2;
        }else{
            
            self.categoryView.arrowDirections[@(2)] = @(JXCategoryTitleSortArrowDirection_Up);
            way = 1;
        }
        [self.categoryView reloadData];
    }else{
        
        [self.categoryView reloadData];
    }
    [self.homeCollection.mj_header beginRefreshing];
}
@end
