//
//  ProductDetailBottomView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailBottomView.h"
#import "MerchantDetailBaseViewController.h"
#import "ShoppingCarViewController.h"
#import "AppDelegate.h"
#import "MainTabarViewController.h"

@interface ProductDetailBottomView()

@property (strong, nonatomic) MyLinearLayout *rootLy, *productLy;
@property (strong, nonatomic) UIButton       *buyBtn, *shareBtn, *collectionBtn;
@property (strong, nonatomic) GoodsSkuVosModel *curSkuModel;

@end

@implementation ProductDetailBottomView
- (void)shareProduct{
    
    
}
- (void)buyBtnProduct{
    
    KPostNotification(@"buyBtnClicked", nil);
}
-(void)threeBtnClicked:(UIButton *)sender{
    
    if (sender.tag == 0) {
        
        MerchantDetailBaseViewController *vc = [[MerchantDetailBaseViewController alloc] init];
        vc.shopID = self.model.shopId;
        [[THAPPService shareAppService].currentViewController.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1){
        
        [THHttpManager saveGoodsCollectWithGoodsID:self.model.goodsId AndShopID:self.model.shopId AndCollectionType:sender.selected ? 2:1 AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                if (sender.selected) {
                    
                    [self.collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
                    [sender setImage:IMAGE_NAMED(@"collection") forState:UIControlStateNormal];
                    [self.collectionBtn setTitleColor:color_6 forState:UIControlStateNormal];
                }else{
                    
                    [self.collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
                    [sender setImage:IMAGE_NAMED(@"isCollection") forState:UIControlStateNormal];
                    [self.collectionBtn setTitleColor:[UIColor colorWithHexString:@"#FF7332"] forState:UIControlStateNormal];
                }
                sender.selected = !sender.isSelected;
            }
        }];
    }else{
        MainTabarViewController *tabViewController = (MainTabarViewController *)[THAPPService WindowRootViewController];
        [tabViewController setSelectedIndex:3];
    }
}
- (void)setModel:(ProductDetailModel *)model{
    
    _model = model;
    if (model.ifCollect) {
        [self.collectionBtn setImage:IMAGE_NAMED(@"isCollection") forState:UIControlStateNormal];
        [self.collectionBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        [self.collectionBtn setTitleColor:[UIColor colorWithHexString:@"#FF7332"] forState:UIControlStateNormal];
        self.collectionBtn.selected = YES;
    }else{
        [self.collectionBtn setImage:IMAGE_NAMED(@"collection") forState:UIControlStateNormal];
        [self.collectionBtn setTitle:@"收藏" forState:UIControlStateNormal];
        [self.collectionBtn setTitleColor:color_6 forState:UIControlStateNormal];
        self.collectionBtn.selected = NO;
    }
    [self.buyBtn setTitle:NSStringFormat(@"立即购买\n¥%.2f",model.salePrice) forState:UIControlStateNormal];
    [self.shareBtn setTitle:NSStringFormat(@"分享赚\n¥%.2f",model.commission) forState:UIControlStateNormal];
}
- (void)setChosedSkuModel:(GoodsSkuVosModel *)chosedSkuModel{
    
    self.curSkuModel = chosedSkuModel;
    [self.buyBtn setTitle:NSStringFormat(@"立即购买\n¥%.2f",chosedSkuModel.salePrice) forState:UIControlStateNormal];
    [self.shareBtn setTitle:NSStringFormat(@"分享赚\n¥%.2f",chosedSkuModel.commission) forState:UIControlStateNormal];
    [self.rootLy reloadInputViews];
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
    
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = TabbarSafeBottomMargin + 40;
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.padding = UIEdgeInsetsMake(6, 12, 0, 12);
    self.rootLy.subviewHSpace = 10;
    [self addSubview:self.rootLy];
    
    NSArray *titleArr = @[@"店铺",@"收藏",@"购物车"];
    NSArray *imgArr = @[@"detailMerchant",@"collection",@"detailCar"];
    for (int i = 0; i < 3; i++) {
        
        DKSButton *btn = [[DKSButton alloc] initWithFrame:CGRectZero];
        btn.myWidth = 35;
        btn.myHeight = 40;
        btn.buttonStyle = DKSButtonImageTop;
        btn.tag = i;
        [btn setImage:IMAGE_NAMED(imgArr[i]) forState:UIControlStateNormal];
        if (i == 1) {
            self.collectionBtn = btn;
        }
        [btn setTitle:titleArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(threeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = [UIFont systemFontOfSize:11];
        [btn setTitleColor:color_6 forState:UIControlStateNormal];
        [self.rootLy addSubview:btn];
    }
    MyLinearLayout *buyBtnLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    buyBtnLy.weight = 1;
    buyBtnLy.myHeight = 40;
    buyBtnLy.subviewHSpace = 8;
    buyBtnLy.gravity = MyGravity_Vert_Center | MyGravity_Horz_Fill;
    [self.rootLy addSubview:buyBtnLy];
    
    self.shareBtn = [BaseButton CreateBaseButtonTitle:@"分享赚" Target:self Action:@selector(shareProduct) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorWithHexString:@"#FF7332"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.shareBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.shareBtn.myWidth = MyLayoutSize.wrap;
    self.shareBtn.myHeight = 40;
    self.shareBtn.layer.cornerRadius = 20;
    self.shareBtn.layer.masksToBounds = YES;
    [buyBtnLy addSubview:self.shareBtn];
    
    self.buyBtn = [BaseButton CreateBaseButtonTitle:@"立即购买" Target:self Action:@selector(buyBtnProduct) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    self.buyBtn.myWidth = MyLayoutSize.wrap;
    self.buyBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.buyBtn.myHeight = 40;
    self.buyBtn.layer.cornerRadius = 20;
    self.buyBtn.layer.masksToBounds = YES;
    [buyBtnLy addSubview:self.buyBtn];
}
@end
