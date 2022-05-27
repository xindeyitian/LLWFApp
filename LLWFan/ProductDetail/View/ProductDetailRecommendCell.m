//
//  ProductDetailRecommendCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailRecommendCell.h"
#import "ShopCarCollectionViewCell.h"
#import "ProductDetailViewController.h"

static NSString *identify = @"ShopCarCollectionViewCell";

@interface ProductDetailRecommendCell()<UICollectionViewDelegate,UICollectionViewDataSource,THFlowLayoutDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray   *dataArr;
@property (strong, nonatomic) THFlowLayout     *layout;
@property (strong, nonatomic) ProductDetailModel *productDetailModel;

@end

@implementation ProductDetailRecommendCell

- (void)setCellWithModel:(ProductDetailModel *)model AndRecommendproductArr:(NSArray *)arr{
    
    self.dataArr = (NSMutableArray *)arr;
    [self.collectionView reloadData];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dataArr = @[].mutableCopy;
        self.backgroundColor = UIColor.clearColor;
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).mas_offset(12);
        make.width.mas_offset(ScreenWidth - 24);
        make.top.bottom.mas_equalTo(self);
    }];
    
    [self.collectionView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
    [self.collectionView reloadData];
}
//- (void)setDataArr:(NSMutableArray *)dataArr{
//    _dataArr = dataArr;
//    [self.collectionView reloadData];
//    [self.collectionView layoutIfNeeded];
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentSize"]) {
        CGFloat height = self.collectionView.contentSize.height;
        [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self).mas_offset(12);
            make.width.mas_offset(ScreenWidth - 24);
            make.top.bottom.mas_equalTo(self);
            make.height.equalTo(@(height));
        }];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArr.count;
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ShopCarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    cell.layer.cornerRadius = 8;
    cell.layer.masksToBounds = YES;
    [cell setItemWithProductModel:self.dataArr[indexPath.item]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    ProductDetailViewController *vc = [[ProductDetailViewController alloc] init];
    
    [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
}
- (CGFloat)waterflowLayout:(THFlowLayout *)waterflowLayout heightForWidth:(CGFloat)width atIndexPath:(NSIndexPath *)indexPath{
    
    ProductModel *model = self.dataArr[indexPath.item];
    return model.height;
}
#pragma mark - getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        
        _layout = [[THFlowLayout alloc] init];
        _layout.delegate = self;
        _layout.columnMargin = 8;
        _layout.rowMargin = 8;
        _layout.columnsCount = 2;
        _layout.headerReferenceSize = CGSizeMake(ScreenWidth, 0);
        _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {

            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [_collectionView registerClass:[ShopCarCollectionViewCell class] forCellWithReuseIdentifier:identify];
    }
    return _collectionView;
}
@end
