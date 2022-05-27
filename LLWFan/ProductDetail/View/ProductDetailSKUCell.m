//
//  ProductDetailSKUCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/8.
//

#import "ProductDetailSKUCell.h"
#import "ChooseSkuView.h"

@interface ProductDetailSKUCell()

@property (strong, nonatomic) MyLinearLayout *rootLy;
@property (strong, nonatomic) MyFlowLayout   *ticketItemLy;
@property (strong, nonatomic) UILabel        *skuLable;
@property (strong, nonatomic) ChooseSkuView  *chooseSkuView;
@property (strong, nonatomic) ProductDetailModel *model;
@property (strong, nonatomic) GoodsSkuVosModel   *chosedSkuModel;
@property (weak, nonatomic) LSTPopView *pop;

@end

@implementation ProductDetailSKUCell
- (void)setCellWithModel:(ProductDetailModel *)model{
    
    self.model = model;
    GoodsSkuVosModel *skuModel = model.goodsSkuVos[0];
    skuModel.num = @"1";
    self.skuLable.text = skuModel.skuName;
}
//弹框
- (void)chooseSKU{
    
    self.chooseSkuView = [[ChooseSkuView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 550)];
    self.chooseSkuView.chosedSkuModel = self.chosedSkuModel;
    [self.chooseSkuView initViewWithProductDetailmodel:self.model];
    LSTPopView *popView = [LSTPopView initWithCustomView:self.chooseSkuView parentView:self.currentViewController.view popStyle:LSTPopStyleSmoothFromBottom dismissStyle:LSTDismissStyleSmoothToBottom];
    LSTPopViewWK(popView)
    popView.hemStyle = LSTHemStyleBottom;
    popView.dragStyle = LSTDragStyleY_Positive;
    popView.sweepStyle = LSTSweepStyleY_Positive;
    popView.isClickFeedback = YES;
    popView.popDuration = 0.2;
    popView.bgClickBlock = ^{
        [wk_popView dismiss];
    };
    self.chooseSkuView.closeBlock = ^{
        [wk_popView dismiss];
    };
    weakSelf(self)
    self.chooseSkuView.succesBlock = ^(GoodsSkuVosModel * _Nonnull model) {
        
        weakSelf.skuLable.text = model.skuName;
        weakSelf.chosedSkuModel = model;
        [weakSelf.rootLy reloadInputViews];
        if (weakSelf.returnSkuBlock) {
            
            weakSelf.returnSkuBlock(model);
        }
    };
    self.pop = popView;
    [popView pop];
}
- (void)buyBtnClicked{
    
    [self chooseSKU];
}
- (void)addShopCarClicked{
    
    [self chooseSKU];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(buyBtnClicked) name:@"buyBtnClicked" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addShopCarClicked) name:@"addShopCarClicked" object:nil];
    }
    return self;
}
- (void)initCustomView{
    //root 布局
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.rootLy.padding = UIEdgeInsetsMake(12, 0, 12, 0);
    [self.contentView addSubview:self.rootLy];
    //内容布局
    
    UITapGestureRecognizer *chooseSku = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseSKU)];
    
    MyLinearLayout *contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    contentLy.myHorzMargin = 12;
    contentLy.myHeight = MyLayoutSize.wrap;
    contentLy.layer.cornerRadius = 8;
    contentLy.layer.masksToBounds = YES;
    contentLy.backgroundColor = UIColor.whiteColor;
    contentLy.padding = UIEdgeInsetsMake(12, 12, 12, 12);
    contentLy.subviewVSpace = 12;
    [contentLy addGestureRecognizer:chooseSku];
    [self.rootLy addSubview:contentLy];
    //优惠券布局
    MyLinearLayout *ticketLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    ticketLy.myHorzMargin = 0;
    ticketLy.myHeight = MyLayoutSize.wrap;
    ticketLy.gravity = MyGravity_Vert_Center;
    ticketLy.subviewHSpace = 12;
    ticketLy.visibility = MyVisibility_Gone;
    [contentLy addSubview:ticketLy];
    //优惠券标题
    UILabel *getTicketLable = [[UILabel alloc] initWithFrame:CGRectZero];
    getTicketLable.text = @"领券";
    getTicketLable.font = [UIFont systemFontOfSize:13];
    getTicketLable.textColor = color_9;
    getTicketLable.myWidth = 30;
    getTicketLable.myHeight = 21;
    [ticketLy addSubview:getTicketLable];
    //优惠券item布局
    self.ticketItemLy = [MyFlowLayout flowLayoutWithOrientation:MyOrientation_Vert arrangedCount:0];
    self.ticketItemLy.weight = 1;
    self.ticketItemLy.myHeight = MyLayoutSize.wrap;
    self.ticketItemLy.subviewHSpace = 8;
    self.ticketItemLy.subviewVSpace = 8;
    [ticketLy addSubview:self.ticketItemLy];
    //右箭头
    UIImageView *right = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"youjiantou")];
    right.myWidth = right.myHeight = 18;
    [ticketLy addSubview:right];
    
    MyLinearLayout *skuLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    skuLy.myHorzMargin = 0;
    skuLy.myHeight = MyLayoutSize.wrap;
    skuLy.gravity = MyGravity_Vert_Center;
    skuLy.subviewHSpace = 12;
    [contentLy addSubview:skuLy];

    UILabel *choose = [[UILabel alloc] initWithFrame:CGRectZero];
    choose.text = @"选择";
    choose.font = [UIFont systemFontOfSize:13];
    choose.textColor = color_9;
    choose.myWidth = 30;
    choose.myHeight = 21;
    [skuLy addSubview:choose];

    self.skuLable = [[UILabel alloc] initWithFrame:CGRectZero];
    self.skuLable.weight = 1;
    self.skuLable.myHeight = 21;
    self.skuLable.font = [UIFont systemFontOfSize:13];
    self.skuLable.textColor = UIColor.blackColor;
    [skuLy addSubview:self.skuLable];

    //右箭头
    UIImageView *right1 = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"youjiantou")];
    right1.myWidth = right1.myHeight = 18;
    [skuLy addSubview:right1];

    MyLinearLayout *safeLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    safeLy.myHorzMargin = 0;
    safeLy.myHeight = MyLayoutSize.wrap;
    safeLy.gravity = MyGravity_Vert_Center;
    safeLy.subviewHSpace = 12;
    [contentLy addSubview:safeLy];

    UILabel *safe = [[UILabel alloc] initWithFrame:CGRectZero];
    safe.text = @"保障";
    safe.font = [UIFont systemFontOfSize:13];
    safe.textColor = color_9;
    safe.myWidth = 30;
    safe.myHeight = 21;
    [safeLy addSubview:safe];

    UILabel *safeDetail = [[UILabel alloc] initWithFrame:CGRectZero];
    safeDetail.font = [UIFont systemFontOfSize:13];
    safeDetail.textColor = UIColor.blackColor;
    safeDetail.weight = 1;
    safeDetail.myHeight = 21;
    [safeLy addSubview:safeDetail];
    
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:@"假一赔十    100%正品    放心承诺"];
    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
    attch.image = [UIImage imageNamed:@"dui"];
    attch.bounds = CGRectMake(0, 0, 10, 10);

    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];

    [attri insertAttributedString:string atIndex:0];
    [attri insertAttributedString:string atIndex:9];
    [attri insertAttributedString:string atIndex:19];

    safeDetail.attributedText = string;
    
}
- (void)initTicketItem{
    //加入优惠券
    
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
- (void)dealloc{
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"buyBtnClicked" object:nil];
}
@end
