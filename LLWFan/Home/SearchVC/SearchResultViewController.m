//
//  SearchResultViewController.m
//  SmallB
//
//  Created by 张昊男 on 2022/4/7.
//

#import "SearchResultViewController.h"
#import "HomeTableViewCell.h"
#import "HomeCollectionViewCell.h"
#import "ProductDetailViewController.h"

@interface SearchResultViewController ()<JXCategoryViewDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate>
{
    NSInteger _index;
    NSInteger _layerType;//0:主页排布方式为tableview 1:主页排布方式为collection
    NSInteger _sort;//排序字段:0->按相关度；1->按新品；2->按销量；3->价格从低到高；4->价格从高到低
}
@property (strong, nonatomic) UITableView *homeTable;
@property (strong, nonatomic) UICollectionView *homeCollection;
@property (strong, nonatomic) UIView *topUtilityView;
@property (strong, nonatomic) UIButton *changeLayerBtn;
@property (nonatomic, strong) NSMutableArray<NSString *> *titles;
@property (nonatomic, strong) JXCategoryTitleSortView *categoryView;
@property (strong, nonatomic) NSMutableArray *collectionDataSorce;
@property (assign, nonatomic) NSInteger collectionPage;

@end

@implementation SearchResultViewController
- (void)setSearchResultArr:(NSArray *)searchResultArr{
    _searchResultArr = searchResultArr;
    self.dataSorce = [ProductModel mj_objectArrayWithKeyValuesArray:self.searchResultArr];
    self.collectionDataSorce = [ProductModel mj_objectArrayWithKeyValuesArray:self.searchResultArr];
    [self.homeTable reloadData];
    [self.homeCollection reloadData];
}
#pragma mark - 切换tableview和collectionView
- (void)changeLayer:(UIButton *)sender{
    
    if (sender.selected) {
        
        _layerType = 0;
        self.homeCollection.hidden = YES;
        self.homeTable.hidden = NO;
    }else{
        
        _layerType = 1;
        self.homeCollection.hidden = NO;
        self.homeTable.hidden = YES;
    }
    sender.selected = !sender.isSelected;
    [self.homeTable reloadData];
    [self.homeCollection reloadData];
}
- (void)getDataWithIsNew:(BOOL )isNew{
    
    if (isNew) {
        self.page = 1;
    }else{
        self.page += 1;
    }
    [THHttpManager searchWithKeyword:self.searchText AndPageNum:NSStringFormat(@"%d",self.page) AndPageSize:@"10" AndProductCategoryId:@"" AndShopId:@"" AndSort:NSStringFormat(@"%ld",_sort) AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [self.homeTable.mj_header endRefreshing];
            [self.homeTable.mj_footer endRefreshing];
            
            NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            if (isNew) {
                self.dataSorce = arr.mutableCopy;
            }else{
                [self.dataSorce addObjectsFromArray:arr];
            }
            [self.homeTable reloadData];
            [self.homeTable layoutIfNeeded];
            if (arr.count < 10) {
                
                [self.homeTable.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.homeTable.mj_header endRefreshing];
            [self.homeTable.mj_footer endRefreshing];
        }
    }];
}
- (void)collectionGetDataWithIsNew:(BOOL )isNew{
    
    if (isNew) {
        self.collectionPage = 1;
    }else{
        self.collectionPage += 1;
    }
    [THHttpManager searchWithKeyword:self.searchText AndPageNum:NSStringFormat(@"%ld",self.collectionPage) AndPageSize:@"10" AndProductCategoryId:@"" AndShopId:@"" AndSort:NSStringFormat(@"%ld",_sort) AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [self.homeCollection.mj_header endRefreshing];
            [self.homeCollection.mj_footer endRefreshing];
            
            NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            if (isNew) {
                self.collectionDataSorce = arr.mutableCopy;
            }else{
                [self.collectionDataSorce addObjectsFromArray:arr];
            }
            [self.homeCollection reloadData];
            [self.homeCollection layoutIfNeeded];
            if (arr.count < 10) {
                
                [self.homeCollection.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.homeCollection.mj_header endRefreshing];
            [self.homeCollection.mj_footer endRefreshing];
        }
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //0:主页排布方式为tableview 1:主页排布方式为collection
    _layerType = 0;
    _sort = 0;
    self.collectionPage = 1;
    self.collectionDataSorce = [[NSMutableArray alloc] init];
    [self initTopView];
    
    self.homeTable = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.homeTable.delegate = self;
    self.homeTable.dataSource = self;
    self.homeTable.showsVerticalScrollIndicator = NO;
    self.homeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.homeTable.backgroundColor = UIColor.clearColor;
    self.homeTable.layer.cornerRadius = 8;
    self.homeTable.layer.masksToBounds = YES;
    [self.view addSubview:self.homeTable];
    [self.homeTable registerClass:[HomeTableViewCell class] forCellReuseIdentifier:@"HomeTableViewCell"];
    self.homeTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    self.homeTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:NO];
    }];
    
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);

    self.homeCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        self.homeCollection.prefetchingEnabled = NO;

    self.homeCollection.hidden = YES;
    self.homeCollection.backgroundColor = UIColor.clearColor;
    self.homeCollection.scrollEnabled = YES;
    self.homeCollection.dataSource = self;
    self.homeCollection.delegate = self;
    self.homeCollection.showsVerticalScrollIndicator = NO;
    self.homeCollection.showsHorizontalScrollIndicator = NO;
    self.homeCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.view addSubview:self.homeCollection];
    [self.homeCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    self.homeCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self collectionGetDataWithIsNew:YES];
    }];
    self.homeCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self collectionGetDataWithIsNew:NO];
    }];
    [self.homeCollection.mj_header beginRefreshing];
}
- (void)initTopView{
    
    self.topUtilityView = [[UIView alloc] init];
    self.topUtilityView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:self.topUtilityView];
    
    self.titles = @[@"综合", @"销量", @"价格"].mutableCopy;
    self.categoryView = [[JXCategoryTitleSortView alloc] init];
    self.categoryView.delegate = self;
    self.categoryView.titles = self.titles;
    
    self.categoryView.uiTypes = @{@(0) : @(JXCategoryTitleSortUIType_ArrowNone),
                                  @(1) : @(JXCategoryTitleSortUIType_ArrowBoth),
                                    @(2) : @(JXCategoryTitleSortUIType_ArrowBoth)}.mutableCopy;
    self.categoryView.arrowDirections = @{@(1) : @(JXCategoryTitleSortArrowDirection_Up),
                                          @(2) : @(JXCategoryTitleSortArrowDirection_Up)}.mutableCopy;
    [self.topUtilityView addSubview:self.categoryView];
    
    self.changeLayerBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(changeLayer:) Font:[UIFont systemFontOfSize:10] BackgroundColor:UIColor.whiteColor Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2];
    [self.changeLayerBtn setImage:IMAGE_NAMED(@"changeLayer") forState:UIControlStateNormal];
    self.changeLayerBtn.imageView.hidden = NO;
    self.changeLayerBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    [self.topUtilityView addSubview:self.changeLayerBtn];
}
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    self.topUtilityView.frame = CGRectMake(0, KNavBarHeight, ScreenWidth, 50);
    self.categoryView.frame = CGRectMake(0, 0, ScreenWidth - 60, 50);
    self.changeLayerBtn.frame = CGRectMake(ScreenWidth - 50, 0, 50, 50);
    self.homeTable.frame = CGRectMake(12, KNavBarHeight + 50 + 12, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 50 - 24);
    self.homeCollection.frame = CGRectMake(12,KNavBarHeight + 50, ScreenWidth - 24, ScreenHeight - KNavBarHeight - 50);
}
#pragma mark - tableviewDelegate  dataSorce----------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSorce.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HomeTableViewCell"];
    [cell initCellWithModel:self.dataSorce[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    ProductModel *model = self.dataSorce[indexPath.row];
    vc.goods = model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewAutomaticDimension;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UIView new];
}
#pragma mark - collectionViewDelegate datasorce--------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.collectionDataSorce.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCollectionViewCell" forIndexPath:indexPath];
    [cell initCellWithModel:self.collectionDataSorce[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    ProductModel *model = self.dataSorce[indexPath.item];
    vc.goods = model;
    [self.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = self.collectionDataSorce[indexPath.item];
    return model.height;
}
#pragma mark - JXCategoryViewDelegate

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
        [self.homeTable reloadData];
        [self.homeCollection reloadData];
    }else if (index == 2){
        
        if (currentPriceDirection3 == JXCategoryTitleSortArrowDirection_Both) {
            
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Up);
        }else if (currentPriceDirection3 == JXCategoryTitleSortArrowDirection_Up){
            
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Down);
        }else{
            
            self.categoryView.arrowDirections[@(3)] = @(JXCategoryTitleSortArrowDirection_Up);
        }
        [self.categoryView reloadData];
        [self.homeTable reloadData];
        [self.homeCollection reloadData];
    }else{
        
        [self.categoryView reloadData];
        [self.homeTable reloadData];
        [self.homeCollection reloadData];
    }
}
@end
