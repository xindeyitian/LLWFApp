//
//  PaySuccessViewController.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/16.
//

#import "PaySuccessViewController.h"
#import "PaySuccessTopView.h"
#import "ShopCarCollectionViewCell.h"
#import "PaySuccessTopView.h"

@interface PaySuccessViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate>

@property (strong, nonatomic) UICollectionView *recommendCollection;
@property (strong, nonatomic) NSMutableArray   *dataSorce;

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setTitle:@"订单支付"];
    self.dataSorce = @[].mutableCopy;
    self.view.backgroundColor = UIColor.whiteColor;
    
    THFlowLayout *layout = [[THFlowLayout alloc] init];
    layout.delegate = self;
    layout.columnMargin = 8;
    layout.rowMargin = 8;
    layout.columnsCount = 2;
    layout.headerReferenceSize = CGSizeMake(ScreenWidth, 205);
    layout.sectionInset = UIEdgeInsetsMake(0, 12, 0, 12);
    
    NSArray *title = @[@"日本药妆店便宜必败好物东京购物精华日东京购物精华",@"日本药物精华",@"日本药妆店便宜必败好物东京购物精华",@"日本药妆店便宜必败好物本药妆店便宜必败好物本药妆店便宜必败好物东京购物精华",@"日本药妆店便宜必败好物东京本药妆店便宜必败好物购物精华",@"店便宜必败好物东京购物精华",@"日本药妆店便宜必败好物东京购物精华",@"日本药妆店便宜必败好本药妆店便宜必败好物物东京购物精华",@"日本药妆店便宜必败好物东本药妆店便宜必败好物本药妆店便宜必败好物本药妆店便宜必败好物京购物精华",@"日本药妆店便宜必败好物东本药妆店便宜必败好物京购物精华"];
    for (int i = 0; i < 10; i++) {
        
        ShopCarItemModel *model = [[ShopCarItemModel alloc] init];
        model.goodsName = title[i];
        [self.dataSorce addObject:model];
    }
    
    self.recommendCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - KNavBarHeight) collectionViewLayout:layout];
    self.recommendCollection.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    self.recommendCollection.delegate = self;
    self.recommendCollection.dataSource = self;
    self.recommendCollection.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.recommendCollection];
    [self.recommendCollection registerClass:[ShopCarCollectionViewCell class] forCellWithReuseIdentifier:@"ShopCarCollectionViewCell"];
    [self.recommendCollection registerClass:[PaySuccessTopView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PaySuccessTopView"];
    
}
#pragma mark - UICollectionViewDelegate - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 10;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopCarCollectionViewCell" forIndexPath:indexPath];
    [cell setItemWithModel:self.dataSorce[indexPath.item]];
    return cell;
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    ShopCarItemModel *model = self.dataSorce[indexPath.item];
    return model.height;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    PaySuccessTopView *topView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PaySuccessTopView" forIndexPath:indexPath];
    
    return topView;
}
@end
