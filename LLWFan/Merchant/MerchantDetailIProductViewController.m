//
//  MerchantDetailIProductViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/11.
//

#import "MerchantDetailIProductViewController.h"
#import "HomeCollectionViewCell.h"
#import "ProductTopView.h"
#import "ProductDetailViewController.h"

@interface MerchantDetailIProductViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate,ProductTopViewDelegate>
{
    NSInteger _type, _way;
}
@property (copy,   nonatomic) void(^scrollCallback)(UIScrollView *scrollView);
@property (strong, nonatomic) UICollectionView *merchantCollection;
@property (strong, nonatomic) ProductTopView *topView;
@property (strong, nonatomic) THFlowLayout *layout;

@end

@implementation MerchantDetailIProductViewController
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
    [THHttpManager queryShopGoodsPageWithCategoryID:@"" AndKeyWord:@"" AndPageNo:self.page AndPageSize:@"10" AndShopID:NSStringFormat(@"%ld",self.model.shopId) AndSortType:NSStringFormat(@"%ld",_type) AndSortWay:NSStringFormat(@"%ld",_way) AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200 && ![DHCCToolsMethod isEmpty:data]) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.merchantCollection.mj_header endRefreshing];
            [self.merchantCollection.mj_footer endRefreshing];

            NSArray *arr = [ProductModel mj_objectArrayWithKeyValuesArray:[data objectForKey:@"data"]];
            
            if (isNew) {
                self.dataSorce = arr.mutableCopy;
            }else{
                [self.dataSorce addObjectsFromArray:arr];
            }
            
            [self.merchantCollection reloadData];
            if (arr.count < 10) {

                [self.merchantCollection.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            [self.merchantCollection.mj_footer endRefreshingWithNoMoreData];
            [self.merchantCollection.mj_header endRefreshing];
        }
    }];
}
- (void)chooseSortType:(NSInteger)type AndSortWay:(NSInteger)way{
    
    _type = type;
    _way = way;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _type = 0;
    _way = 0;
    self.layout = [[THFlowLayout alloc] init];
    self.layout.delegate = self;
    self.layout.columnMargin = 8;
    self.layout.rowMargin = 8;
    self.layout.columnsCount = 2;
    if (self.model.imgUrls.count) {
        
        self.layout.headerReferenceSize = CGSizeMake(ScreenWidth, 208);
    }else{
        
        self.layout.headerReferenceSize = CGSizeMake(ScreenWidth, 40);
    }
    self.layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    self.layout.isHeaderStick = YES;
    self.layout.stickHight = 40;

    self.merchantCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - 210) collectionViewLayout:self.layout];
    self.merchantCollection.prefetchingEnabled = NO;
    self.merchantCollection.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.merchantCollection.scrollEnabled = YES;
    self.merchantCollection.dataSource = self;
    self.merchantCollection.delegate = self;
    self.merchantCollection.showsVerticalScrollIndicator = NO;
    self.merchantCollection.showsHorizontalScrollIndicator = NO;
    self.merchantCollection.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    self.merchantCollection.backgroundColor = color_f5;
    [self.view addSubview:self.merchantCollection];
    [self.merchantCollection reloadData];
    [self.merchantCollection registerClass:[HomeCollectionViewCell class] forCellWithReuseIdentifier:@"HomeCollectionViewCell"];
    [self.merchantCollection registerClass:[ProductTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ProductTopView"];
    
    self.merchantCollection.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    self.merchantCollection.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [self getDataWithIsNew:YES];
    }];
    [self.merchantCollection.mj_header beginRefreshing];
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
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    vc.goods = self.dataSorce[indexPath.item];
    [self.navigationController pushViewController:vc animated:YES];
}
//  返回头视图
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView =nil;
    //返回段头段尾视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        self.topView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ProductTopView" forIndexPath:indexPath];
//        self.topView.frame = CGRectMake(0, 0, ScreenWidth, 208);
        //添加头视图的内容
        self.topView.delegate = self;
        self.topView.model = self.model;
        reusableView = self.topView;
        return reusableView;
    }
    return reusableView;
}
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size = CGSizeMake(ScreenWidth, [self.topView.rootLy sizeThatFits:CGSizeMake(ScreenWidth, MAXFLOAT)].height);
    return size;
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    ProductModel *model = self.dataSorce[indexPath.item];
    return model.height;
}
#pragma mark - JXCategoryListContentViewDelegate -
- (UIScrollView *)listScrollView {
    return self.merchantCollection;
}

- (void)listViewDidScrollCallback:(void (^)(UIScrollView *))callback {
    self.scrollCallback = callback;
}

- (UIView *)listView {
    return self.view;
}
@end
