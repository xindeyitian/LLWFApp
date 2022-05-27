//
//  ChooseSkuView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/5/17.
//

#import "ChooseSkuView.h"
#import "ORSKUDataFilter.h"
#import "SettleViewController.h"
#import "AddressListViewController.h"

@interface ChooseSkuView()<UICollectionViewDelegate,UICollectionViewDataSource,ORSKUDataFilterDataSource>

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) UIImageView *goodsImage;
@property (strong, nonatomic) UILabel *goodsName, *goodsPrice, *gxz;
@property (strong, nonatomic) UICollectionView *skuCollection;
@property (strong, nonatomic) NSMutableArray *allSkuArr, *skuDataArr;
@property (nonatomic, strong) NSMutableArray <NSIndexPath *>*selectedIndexPaths;
@property (strong, nonatomic) ProductDetailModel *detailModel;
@property (nonatomic, strong) ORSKUDataFilter *filter;
@end

@implementation ChooseSkuView
- (void)initViewWithProductDetailmodel:(ProductDetailModel *)model{
    
    self.detailModel = model;
    self.allSkuArr = (NSMutableArray *)model.goodsAttVos;
    self.skuDataArr = (NSMutableArray *)model.goodsSkuVos;
    self.filter = [[ORSKUDataFilter alloc] initWithDataSource:self];
    self.goodsName.text = model.goodsName;
    self.goodsPrice.text = NSStringFormat(@"¥%.2f",model.salePrice);
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.goodsImgs.images[0]] placeholderImage:IMAGE_NAMED(@"")];
    if (model.contributionValue.length) {
        
        self.gxz.visibility = MyVisibility_Visible;
        self.gxz.text = NSStringFormat(@"提升贡献值:%@",model.contributionValue);
    }else{
        self.gxz.visibility = MyVisibility_Gone;
    }
    
    self.filter.needDefaultValue = NO;
    [self.filter reloadData];
    [self.skuCollection reloadData]; //更新UI显示
    [self action_complete:nil];       //更新结果查询
}
- (void)closeBtnClicked{
    
    if (self.closeBlock) {
        
        self.closeBlock();
    }
}
- (void)addShopCar{
    
    //加入购物车
    [MBProgressHUD showHUDAddedTo:self.currentViewController.view animated:YES];
    [THHttpManager addWithCount:self.chosedSkuModel.num.integerValue AndGoodsId:self.detailModel.goodsId AndShopId:self.detailModel.shopId AndSkuId:self.chosedSkuModel.skuId AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"加入购物车成功" AndType:success IsHideBg:YES AnddataBlock:nil];
                [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
            });
        }else{
            [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
        }
    }];
}
- (void)buy{
    //购买商品
//    SettleViewController *vc = [[SettleViewController alloc] init];
//    vc.detailModel = self.detailModel;
//    vc.chosedSkuModel = self.chosedSkuModel;
//    vc.activityType = 1;
//    [self.currentViewController.navigationController pushViewController:vc animated:YES];
    [MBProgressHUD showHUDAddedTo:self.currentViewController.view animated:YES];
    [THHttpManager addressDefaultWithBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
            NSArray *arr = [AddressModel mj_objectArrayWithKeyValuesArray:data];
            if (arr.count) {

                //购买商品
                SettleViewController *vc = [[SettleViewController alloc] init];
                vc.detailModel = self.detailModel;
                vc.chosedSkuModel = self.chosedSkuModel;
                vc.activityType = 1;
                vc.addressArr = arr;
                [self.currentViewController.navigationController pushViewController:vc animated:YES];
            }else{

                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请先添加地址!" AndType:warning IsHideBg:NO AnddataBlock:^{

                    AddressListViewController *vc = [[AddressListViewController alloc] init];

                    [self.currentViewController.navigationController pushViewController:vc animated:YES];
                }];
            }
        }
    }];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initChooseSkuView];
        self.allSkuArr = @[].mutableCopy;
        self.skuDataArr = @[].mutableCopy;
        self.selectedIndexPaths = @[].mutableCopy;
    }
    return self;
}
- (void)initChooseSkuView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHorzMargin = 0;
    self.rootLy.myHeight = 550;
    self.rootLy.padding = UIEdgeInsetsMake(22, 0, TabbarSafeBottomMargin, 0);
    self.rootLy.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.rootLy];
    
    MyLinearLayout *goodsLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    goodsLy.myHorzMargin = 12;
    goodsLy.myHeight = 100;
    goodsLy.subviewHSpace = 12;
    [self.rootLy addSubview:goodsLy];
    
    self.goodsImage = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"img")];
    self.goodsImage.myWidth = self.goodsImage.myHeight = 100;
    self.goodsImage.layer.cornerRadius = 8;
    self.goodsImage.layer.masksToBounds = YES;
    [goodsLy addSubview:self.goodsImage];
    
    MyLinearLayout *goodsInfoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    goodsInfoLy.weight = 1;
    goodsInfoLy.myHeight = MyLayoutSize.wrap;
    [goodsLy addSubview:goodsInfoLy];
    
    self.goodsName = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont systemFontOfSize:15 weight:UIFontWeightSemibold] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:0];
    self.goodsName.myHorzMargin = 0;
    self.goodsName.myHeight = MyLayoutSize.wrap;
    self.goodsName.numberOfLines = 0;
    [goodsInfoLy addSubview:self.goodsName];
    
    self.goodsPrice = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont fontWithName:@"DIN-Medium" size:20] Color:[UIColor colorWithHexString:@"#FF3B30"] Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:1];
    self.goodsPrice.myHorzMargin = 0;
    self.goodsPrice.myHeight = MyLayoutSize.wrap;
    self.goodsPrice.myTop = 12;
    [goodsInfoLy addSubview:self.goodsPrice];
    
    self.gxz = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont systemFontOfSize:12] Color:[UIColor colorWithHexString:@"#FF9C6E"] Frame:CGRectZero Alignment:NSTextAlignmentLeft Tag:2];
    self.gxz.myHorzMargin = 0;
    self.gxz.myHeight = MyLayoutSize.wrap;
    self.gxz.myTop = 4;
    [goodsInfoLy addSubview:self.gxz];
    
    UIButton *closeBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(closeBtnClicked) Font:[UIFont systemFontOfSize:1] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"closeSku" HeightLightBackgroundImage:@"closeSku"];
    closeBtn.myWidth = closeBtn.myHeight = 22;
    [goodsLy addSubview:closeBtn];
    
    UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc] init];
    //设置滚动方向
    [flowlayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    //左右间距
    flowlayout.minimumInteritemSpacing = 12;
    //上下间距
    flowlayout.minimumLineSpacing = 12;
    
    flowlayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.skuCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowlayout];
    self.skuCollection.myHorzMargin = 12;
    self.skuCollection.myHeight = 550 - 22 - 100 - 44 - TabbarSafeBottomMargin - 12;
    self.skuCollection.backgroundColor = UIColor.whiteColor;
    self.skuCollection.delegate = self;
    self.skuCollection.dataSource = self;
    self.skuCollection.showsVerticalScrollIndicator = NO;
    [self.rootLy addSubview:self.skuCollection];
    [self.skuCollection registerClass:[SkuItem class] forCellWithReuseIdentifier:@"SkuItem"];
    [self.skuCollection registerClass:[SkuHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"SkuHeader"];
    [self.skuCollection registerClass:[SkuNumFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"SkuNumFooter"];
    
    MyLinearLayout *btnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    btnLy.myHorzMargin = 0;
    btnLy.myHeight = 44 + TabbarSafeBottomMargin + 12;
    btnLy.padding = UIEdgeInsetsMake(12, 12, 0, 12);
    btnLy.subviewHSpace = 12;
    [self.rootLy addSubview:btnLy];
    
    MyBorderline *topline = [[MyBorderline alloc] initWithColor:[UIColor colorWithHexString:@"#EEEEEE"] thick:1 headIndent:0 tailIndent:0];
    btnLy.topBorderline = topline;
    
    UIButton *addShopCarBtn = [BaseButton CreateBaseButtonTitle:@"加入购物车" Target:self Action:@selector(addShopCar) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorNamed:@"color-orange"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    addShopCarBtn.myWidth = (ScreenWidth - 36) / 2;
    addShopCarBtn.myHeight = 40;
    addShopCarBtn.layer.cornerRadius = 20;
    addShopCarBtn.layer.masksToBounds = YES;
    [btnLy addSubview:addShopCarBtn];
    
    UIButton *buyBtn = [BaseButton CreateBaseButtonTitle:@"立即购买" Target:self Action:@selector(buy) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    buyBtn.myWidth = (ScreenWidth - 36) / 2;
    buyBtn.myHeight = 40;
    buyBtn.layer.cornerRadius = 20;
    buyBtn.layer.masksToBounds = YES;
    [btnLy addSubview:buyBtn];
    
}
#pragma mark -- collectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.allSkuArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.allSkuArr[section][@"attrValue"] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SkuItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SkuItem" forIndexPath:indexPath];
    NSArray *data = self.allSkuArr[indexPath.section][@"attrValue"];
    cell.skuLable.text = data[indexPath.item][@"attrValueName"];
    
    if ([_filter.availableIndexPathsSet containsObject:indexPath]) {
        [cell setItemStatus:Normal];
    }else {
        [cell setItemStatus:Unable];
    }

    if ([_filter.selectedIndexPaths containsObject:indexPath]) {
        [cell setItemStatus:Select];
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *data = self.allSkuArr[indexPath.section][@"attrValue"];
    NSString *text = data[indexPath.item][@"attrValueName"];
    return CGSizeMake([text sizeWithLabelHeight:30 font:[UIFont systemFontOfSize:13]].width + 24, 30);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    //返回段头段尾视图
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        SkuHeader *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SkuHeader" forIndexPath:indexPath];
        view.skuHeaderLable.text = self.allSkuArr[indexPath.section][@"attrName"];
        return view;
    }else{
        
        if (indexPath.section == self.allSkuArr.count - 1) {
            
            SkuNumFooter *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"SkuNumFooter" forIndexPath:indexPath];
            footer.chooseNumBlock = ^(NSString * _Nonnull num) {
                self.chosedSkuModel.num = num;
            };
            return footer;
        }else{
            return nil;
        }
    }
}
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    CGSize size = CGSizeMake(ScreenWidth, 45);
    return size;
}
- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    
    if (section == self.allSkuArr.count - 1) {
        
        CGSize size = CGSizeMake(ScreenWidth, 30);
        return size;
    }else{
        
        return CGSizeMake(0, 0);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [_filter didSelectedPropertyWithIndexPath:indexPath];
    
    [collectionView reloadData];
    [self action_complete:nil];
}

#pragma mark -- ORSKUDataFilterDataSource

- (NSInteger)numberOfSectionsForPropertiesInFilter:(ORSKUDataFilter *)filter {
    return self.allSkuArr.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter propertiesInSection:(NSInteger)section {
    NSArray *curSectionSkuArr = self.allSkuArr[section][@"attrValue"];
    NSMutableArray *attrArr = @[].mutableCopy;
    for (NSDictionary *model in curSectionSkuArr) {
        [attrArr addObject:NSStringFormat(@"%@",model[@"attrValueId"])];
    }
    return attrArr;
}

- (NSInteger)numberOfConditionsInFilter:(ORSKUDataFilter *)filter {
    return self.skuDataArr.count;
}

- (NSArray *)filter:(ORSKUDataFilter *)filter conditionForRow:(NSInteger)row {
    if (self.skuDataArr) {
        
        GoodsSkuVosModel *model = self.skuDataArr[row];
        NSString *condition = model.skuValues;
        return [condition componentsSeparatedByString:@","];
    }
    return nil;
}

- (id)filter:(ORSKUDataFilter *)filter resultOfConditionForRow:(NSInteger)row {
    
    GoodsSkuVosModel *dic = self.skuDataArr[row];
    return dic;
}

#pragma mark -- action
- (void)action_complete:(id)sender {
    
    //
    GoodsSkuVosModel *model = _filter.currentResult;
    self.chosedSkuModel = model;
    self.chosedSkuModel.num = @"1";
    if (model == nil) {
        NSLog(@"请选择完整 属性");
        return;
    }
    self.goodsPrice.text = NSStringFormat(@"¥%.2f",model.salePrice);
    self.gxz.text = NSStringFormat(@"提升贡献值:%@",model.contributionValue);
    [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    if (self.succesBlock) {
        
        self.succesBlock(model);
    }
}
@end

@interface SkuItem()

@property (strong, nonatomic) MyLinearLayout *lableLy;

@end
@implementation SkuItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initItem];
    }
    return self;
}
- (void)setItemStatus:(itemStatus) status{
    
    switch (status) {
        case Normal:
        {
            self.lableLy.backgroundColor = color_f5;
            self.skuLable.textColor = color_3;
        }
            break;
        case Select:
        {
            self.lableLy.backgroundColor = [UIColor colorWithHexString:@"#FAEDEB"];
            self.skuLable.textColor = [UIColor colorWithHexString:@"#FF3B30"];
        }
            break;
        case Unable:
        {
            self.lableLy.backgroundColor = color_f5;
            self.skuLable.textColor = color_9;
        }
            break;
            
        default:
            break;
    }
}
- (void)initItem{
    
    self.lableLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.lableLy.myWidth = MyLayoutSize.wrap;
    self.lableLy.myHeight = MyLayoutSize.wrap;
    self.lableLy.layer.cornerRadius = 15;
    self.lableLy.layer.masksToBounds = YES;
    self.lableLy.backgroundColor = color_f5;
    self.lableLy.padding = UIEdgeInsetsMake(5, 12, 5, 12);
    [self.contentView addSubview:self.lableLy];
    
    self.skuLable = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont systemFontOfSize:13] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.skuLable.myWidth = self.skuLable.myHeight = MyLayoutSize.wrap;
    [self.lableLy addSubview:self.skuLable];
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.lableLy sizeThatFits:targetSize];
}
@end

@implementation SkuHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initHeader];
    }
    return self;
}
- (void)initHeader{
    
    self.skuHeaderLable = [BaseLabel CreateBaseLabelStr:@"" Font:[UIFont systemFontOfSize:17 weight:UIFontWeightSemibold] Color:color_3 Frame:CGRectMake(0, 12, ScreenWidth - 24, 30) Alignment:NSTextAlignmentLeft Tag:0];
    [self addSubview:self.skuHeaderLable];
}
@end

@interface SkuNumFooter()

@property (strong, nonatomic) PPNumberButton *chooseNumBtn;

@end

@implementation SkuNumFooter

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initFooter];
    }
    return self;
}
- (void)initFooter{
    
    MyLinearLayout *rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    rootLy.myHorzMargin = 0;
    rootLy.myHeight = 30;
    rootLy.gravity = MyGravity_Vert_Center;
    [self addSubview:rootLy];
    
    UILabel *title = [BaseLabel CreateBaseLabelStr:@"数量" Font:[UIFont systemFontOfSize:17] Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    title.myWidth = title.myHeight = MyLayoutSize.wrap;
    [rootLy addSubview:title];
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [rootLy addSubview:nilView];
    
    self.chooseNumBtn = [[PPNumberButton alloc] init];
    self.chooseNumBtn.borderColor = UIColor.grayColor;
    self.chooseNumBtn.myWidth = 110;
    self.chooseNumBtn.myHeight = 30;
    self.chooseNumBtn.font = [UIFont systemFontOfSize:15];
    self.chooseNumBtn.textField.backgroundColor = UIColor.whiteColor;
    weakSelf(self)
    self.chooseNumBtn.numberBlock = ^(NSString *number) {
        
        if (weakSelf.chooseNumBlock) {
            
            weakSelf.chooseNumBlock(number);
        }
    };
    [rootLy addSubview:self.chooseNumBtn];
}

@end
