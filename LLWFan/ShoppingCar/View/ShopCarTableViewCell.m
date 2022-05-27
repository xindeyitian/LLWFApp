//
//  ShopCarTableViewCell.m
//  LLWFan
//
//  Created by 张昊男 on 2022/3/26.
//

#import "ShopCarTableViewCell.h"

@interface ShopCarTableViewCell()

@property (strong, nonatomic) MyLinearLayout *rootLy, *contentLy;
@property (strong, nonatomic) UILabel        *productName, *sku, *productPrice, *oldPrice;
@property (strong, nonatomic) UIButton       *chooseBtn;
@property (strong, nonatomic) UIImageView    *productImage, *wuhuoImg;
@property (strong, nonatomic) ShopCarItemModel *goodsModel;
@property (strong, nonatomic) PPNumberButton *chooseNumBtn;

@end

@implementation ShopCarTableViewCell
- (void)setCellWithShopCarModel:(ShopCarItemModel *)model{
    
    self.goodsModel = model;
    self.productName.text = model.goodsName;
    self.sku.text = model.skuName;
    self.oldPrice.text = NSStringFormat(@"¥%.2f",model.priceMark);
    self.chooseNumBtn.textField.text = model.quantity;
    [self.productImage sd_setImageWithURL:[NSURL URLWithString:model.skuImgUrl] placeholderImage:IMAGE_NAMED(@"")];
    if (model.valid) {
        
        self.wuhuoImg.hidden = YES;
        self.chooseNumBtn.visibility = MyVisibility_Visible;
        self.chooseBtn.enabled = YES;
        if (model.isSelect) {
            [self.chooseBtn setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
        }else{
            [self.chooseBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
        }
        self.chooseBtn.selected = model.isSelect;
    }else{
        self.wuhuoImg.hidden = NO;
        self.chooseNumBtn.visibility = MyVisibility_Gone;
        [self.chooseBtn setImage:IMAGE_NAMED(@"shixiao") forState:UIControlStateNormal];
        self.chooseBtn.enabled = NO;
    }
    self.productPrice.text = NSStringFormat(@"¥%.2f",model.priceSale);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.productPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Bold" size:13] range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Bold" size:13] range:NSMakeRange([self.productPrice.text rangeOfString:@"."].location + 1, 2)];
    self.productPrice.attributedText = attr;
}
#pragma mark ----------click action------------
- (void)chooseCurProduct:(UIButton *)sender{
    
    if (self.goodsModel.valid) {
        
        [self setBtnType:sender];
        self.goodsModel.isSelect = sender.isSelected;
        if (self.chooseProductBlock) {

            self.chooseProductBlock(self.goodsModel);
        }
    }
}
- (void)setBtnType:(UIButton *)btn{
    
    if (btn.isSelected) {
        dispatch_async(dispatch_get_main_queue(), ^{

            [btn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [btn setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
        });
    }
    btn.selected = !btn.isSelected;
}
#pragma mark ----------init------------
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    self.rootLy.myHeight = MyLayoutSize.wrap;
    self.rootLy.myWidth = ScreenWidth - 24;
    self.rootLy.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];;
    [self.contentView addSubview:self.rootLy];
    
    self.contentLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.contentLy.myHorzMargin = 0;
    self.contentLy.myHeight = MyLayoutSize.wrap;
    self.contentLy.padding = UIEdgeInsetsMake(0, 8, 0, 8);
    self.contentLy.backgroundColor = UIColor.whiteColor;
    self.contentLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:self.contentLy];
    
    self.chooseBtn = [BaseButton CreateBaseButtonTitle:@"" Target:self Action:@selector(chooseCurProduct:) Font:[UIFont systemFontOfSize:10] Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0 BackgroundImage:@"choose" HeightLightBackgroundImage:@"choose"];
    self.chooseBtn.myWidth = 25;
    self.chooseBtn.myHeight = 85;
    [self.contentLy addSubview:self.chooseBtn];
    
    UIView *imgView = [[UIView alloc] initWithFrame:CGRectZero];
    imgView.myWidth = imgView.myHeight = 72;
    imgView.layer.cornerRadius = 4;
    imgView.layer.masksToBounds = YES;
    imgView.myLeft = 8;
    [self.contentLy addSubview:imgView];
    
    self.productImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    self.productImage.layer.cornerRadius = 4;
    self.productImage.layer.masksToBounds = YES;
    [imgView addSubview:self.productImage];
    
    self.wuhuoImg = [[UIImageView alloc] initWithImage:IMAGE_NAMED(@"wuhuo")];
    self.wuhuoImg.frame = CGRectMake(0, 0, 72, 72);
    self.wuhuoImg.layer.cornerRadius = 4;
    self.wuhuoImg.layer.masksToBounds = YES;
    self.wuhuoImg.hidden = YES;
    [imgView addSubview:self.wuhuoImg];
    
    MyLinearLayout *infoLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    infoLy.myWidth = ScreenWidth - 24 - 8 * 3 - 12 - 25 - 72;
    infoLy.myHeight = MyLayoutSize.wrap;
    infoLy.subviewVSpace = 8;
    infoLy.myLeft = 12;
    [self.contentLy addSubview:infoLy];
    
    self.productName = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productName.font = [UIFont systemFontOfSize:13 weight:UIFontWeightMedium];
    self.productName.textColor = UIColor.blackColor;
    self.productName.text = @"￼￼三只松鼠每日坚果 750g/30袋 送礼…";
    self.productName.myHorzMargin = 0;
    self.productName.myHeight = 20;
    [infoLy addSubview:self.productName];
    
    self.sku = [[UILabel alloc] initWithFrame:CGRectZero];
    self.sku.font = [UIFont systemFontOfSize:11];
    self.sku.textColor = color_6;
    self.sku.text = @"桶装每日坚果";
    self.sku.backgroundColor = [UIColor colorWithHexString:@"#F5F5F5"];
    self.sku.myWidth = MyLayoutSize.wrap;
    self.sku.myHeight = 20;
    self.sku.layer.cornerRadius = 10;
    self.sku.layer.masksToBounds = YES;
    [infoLy addSubview:self.sku];
    
    MyLinearLayout *priceLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    priceLy.myHorzMargin = 0;
    priceLy.myHeight = MyLayoutSize.wrap;
    priceLy.gravity = MyGravity_Vert_Center;
    [infoLy addSubview:priceLy];
    
    self.productPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.productPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    self.productPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.productPrice.text = @"¥199.87";
    self.productPrice.myWidth = self.productPrice.myHeight = MyLayoutSize.wrap;
    [priceLy addSubview:self.productPrice];
    
    self.oldPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.oldPrice.font = [UIFont fontWithName:@"DIN-Regular" size:11];
    self.oldPrice.textColor = color_9;
    self.oldPrice.text = @"¥210.39";
    self.oldPrice.myLeft = 8;
    self.oldPrice.myWidth = self.oldPrice.myHeight = MyLayoutSize.wrap;
    [priceLy addSubview:self.oldPrice];
    
    //中划线
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:self.oldPrice.text attributes:attribtDic];
    // 赋值
    self.oldPrice.attributedText = attribtStr;
    
    UIView *nilView = [[UIView alloc] initWithFrame:CGRectZero];
    nilView.weight = 1;
    nilView.myHeight = 1;
    [priceLy addSubview:nilView];
    
    self.chooseNumBtn = [[PPNumberButton alloc] init];
    self.chooseNumBtn.borderColor = UIColor.grayColor;
    self.chooseNumBtn.myWidth = 110;
    self.chooseNumBtn.myHeight = 30;
    self.chooseNumBtn.font = [UIFont systemFontOfSize:15];
    self.chooseNumBtn.textField.backgroundColor = UIColor.whiteColor;
    [priceLy addSubview:self.chooseNumBtn];
    
    weakSelf(self)
    self.chooseNumBtn.numberBlock = ^(NSString *number) {
        
        [MBProgressHUD showHUDAddedTo:weakSelf.currentViewController.view animated:YES];
        [THHttpManager changeQuantityWithCount:number.integerValue AndGoodsID:weakSelf.goodsModel.goodsId.integerValue AndShopID:weakSelf.goodsModel.shopId AndSkuID:weakSelf.goodsModel.skuId AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
            
            if (returnCode == 200) {
                
                [MBProgressHUD hideHUDForView:weakSelf.currentViewController.view animated:YES];
                weakSelf.goodsModel.quantity = number;
                if (weakSelf.reloadProductBlock) {
                    
                    weakSelf.reloadProductBlock(weakSelf.goodsModel);
                }
            }else{
                
                weakSelf.chooseNumBtn.textField.text = weakSelf.goodsModel.quantity;
                [MBProgressHUD hideHUDForView:weakSelf.currentViewController.view animated:YES];
            }
        }];
    };
}
- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize withHorizontalFittingPriority:(UILayoutPriority)horizontalFittingPriority verticalFittingPriority:(UILayoutPriority)verticalFittingPriority{
    
    return [self.rootLy sizeThatFits:targetSize];
}
@end
