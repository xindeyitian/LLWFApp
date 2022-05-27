//
//  ShopCarBottomSettlementView.m
//  LLWFan
//
//  Created by 张昊男 on 2022/4/14.
//

#import "ShopCarBottomSettlementView.h"
#import "SettleViewController.h"
#import "AddressListViewController.h"

@interface ShopCarBottomSettlementView()

@property (strong, nonatomic) MyLinearLayout *rootLy, *settlementLy, *editingLy;
@property (strong, nonatomic) UIButton       *chooseBtn, *settlementBtn, *collectBtn, *deleteBtn;
@property (strong, nonatomic) UILabel        *allPrice;

@end

@implementation ShopCarBottomSettlementView
- (void)setType:(SettlementType)type{
    
    _type = type;
    if (type) {
        self.settlementLy.visibility = MyVisibility_Gone;
        self.editingLy.visibility = MyVisibility_Visible;
    }else{
        self.settlementLy.visibility = MyVisibility_Visible;
        self.editingLy.visibility = MyVisibility_Gone;
    }
}
- (void)chooseBtnClicked:(UIButton *)sender{
    
    if (self.carList.count) {
        
        if (sender.isSelected) {
            
            [sender setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
        }else{
            
            [sender setImage:IMAGE_NAMED(@"chosed") forState:UIControlStateNormal];
        }
        sender.selected = !sender.isSelected;
        
        for (ShopCarModel *carModel in self.carList) {
            
            carModel.isSelect = sender.isSelected;
            for (ShopCarItemModel *itemModel in carModel.cartItems) {
                
                if (itemModel.valid) {
                    
                    itemModel.isSelect = carModel.isSelect;
                }
            }
        }
        if (self.reloadCarListBlock) {
            
            self.reloadCarListBlock(self.carList);
        }
    }else{
        
        [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请先添加商品" AndType:warning IsHideBg:YES AnddataBlock:nil];
    }
}
- (void)settlementBtnClicked{

    [MBProgressHUD showHUDAddedTo:self.currentViewController.view animated:YES];
    [THHttpManager addressDefaultWithBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        if (returnCode == 200) {
            
            [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
            NSArray *arr = [AddressModel mj_objectArrayWithKeyValuesArray:data];
            if (arr.count) {

                //购买商品
                SettleViewController *vc = [[SettleViewController alloc] init];
                vc.carModelArr = self.carList;
                vc.activityType = 1;
                vc.addressArr = arr;
                [self.currentViewController.navigationController pushViewController:vc animated:YES];
            }else{

                [MBProgressHUD hideHUDForView:self.currentViewController.view animated:YES];
                [[AllNoticePopUtility shareInstance] popViewWithTitle:@"请先添加地址!" AndType:warning IsHideBg:NO AnddataBlock:^{

                    AddressListViewController *vc = [[AddressListViewController alloc] init];

                    [self.currentViewController.navigationController pushViewController:vc animated:YES];
                }];
            }
        }
    }];
}
- (void)allCollect{
    
    //快速清理
    [THHttpManager cleanInvalidGoodsWithBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"删除成功" AndType:success IsHideBg:YES AnddataBlock:^{
                
                if (self.reloadDataBlock) {
                    
                    self.reloadDataBlock();
                }
            }];
        }
    }];
}
- (void)deleteBtnClicked{
    //删除
    NSMutableArray *skuIds = @[].mutableCopy;
    for (ShopCarModel *carModel in self.carList) {
        
        for (ShopCarItemModel *itemModel in carModel.cartItems) {
            
            if (itemModel.isSelect) {
                
                [skuIds addObject:itemModel.skuId];
            }
        }
    }
    [THHttpManager deleteItemsWithSkuIds:skuIds AndBlock:^(NSInteger returnCode, THRequestStatus status, id data) {
        
        if (returnCode == 200) {
            
            [[AllNoticePopUtility shareInstance] popViewWithTitle:@"删除成功" AndType:success IsHideBg:YES AnddataBlock:^{
                
                if (self.reloadDataBlock) {
                    
                    self.reloadDataBlock();
                }
            }];
        }
    }];
}
- (void)setViewWithModel:(TotalPayModel *)model AndCarList:(NSArray *)arr{
    
    self.carList = arr;
    self.allPrice.text = NSStringFormat(@"¥%@",[DHCCToolsMethod separatedDigitStringWithStr:[NSString stringWithFormat:@"%.2f",model.totalMoney]]);
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:self.allPrice.text];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Bold" size:13] range:NSMakeRange(0, 1)];
    [attr addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"DIN-Bold" size:13] range:NSMakeRange([self.allPrice.text rangeOfString:@"."].location + 1, 2)];
    self.allPrice.attributedText = attr;
}
- (void)reset{
    
    self.allPrice.text = @"¥0";
    [self.chooseBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    self.chooseBtn.selected = NO;
}
- (instancetype)initWithFrame:(CGRect)frame AndType:(SettlementType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        [self initCustomView];
    }
    return self;
}
- (void)initCustomView{
    
    self.rootLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.rootLy.myHeight = 50;
    self.rootLy.myWidth = ScreenWidth;
    self.rootLy.padding = UIEdgeInsetsMake(5, 20, 5, 12);
    self.rootLy.backgroundColor = UIColor.whiteColor;
    self.rootLy.gravity = MyGravity_Vert_Center;
    [self addSubview:self.rootLy];
    
    self.chooseBtn = [BaseButton CreateBaseButtonTitle:@"全选" Target:self Action:@selector(chooseBtnClicked:) Font:[UIFont systemFontOfSize:12] BackgroundColor:UIColor.whiteColor Color:color_6 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:0];
    [self.chooseBtn setImage:IMAGE_NAMED(@"choose") forState:UIControlStateNormal];
    self.chooseBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 7, 0, 0);
    self.chooseBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    self.chooseBtn.myWidth = 60;
    self.chooseBtn.myHeight = 30;
    [self.rootLy addSubview:self.chooseBtn];
    
    self.settlementLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.settlementLy.weight = 1;
    self.settlementLy.myHeight = 50;
    self.settlementLy.myLeft = 8;
    self.settlementLy.gravity = MyGravity_Vert_Center;
    [self.rootLy addSubview:self.settlementLy];
    
    UILabel *heji = [[UILabel alloc] initWithFrame:CGRectZero];
    heji.text = @"合计：";
    heji.myWidth = 50;
    heji.myHeight = 20;
    heji.font = [UIFont systemFontOfSize:15];
    heji.textColor = color_3;
    [self.settlementLy addSubview:heji];
    
    self.allPrice = [[UILabel alloc] initWithFrame:CGRectZero];
    self.allPrice.weight = 1;
    self.allPrice.myHeight = MyLayoutSize.wrap;
    self.allPrice.font = [UIFont fontWithName:@"DIN-Bold" size:17];
    self.allPrice.textColor = [UIColor colorWithHexString:@"#FF3B30"];
    self.allPrice.text = @"¥0";
    [self.settlementLy addSubview:self.allPrice];
    
    
    
    self.settlementBtn = [BaseButton CreateBaseButtonTitle:@"去结算" Target:self Action:@selector(settlementBtnClicked) Font:[UIFont systemFontOfSize:15] BackgroundColor:[UIColor colorNamed:@"color-red"] Color:UIColor.whiteColor Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:1];
    self.settlementBtn.myWidth = 108;
    self.settlementBtn.myHeight = 40;
    self.settlementBtn.layer.cornerRadius = 20;
    self.settlementBtn.layer.masksToBounds = YES;
    [self.settlementLy addSubview:self.settlementBtn];
    
    self.editingLy = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Horz];
    self.editingLy.weight = 1;
    self.editingLy.myHeight = 50;
    self.editingLy.gravity = MyGravity_Vert_Center | MyGravity_Horz_Right;
    self.editingLy.subviewHSpace = 12;
    [self.rootLy addSubview:self.editingLy];
    
    self.collectBtn = [BaseButton CreateBaseButtonTitle:@"快速清理" Target:self Action:@selector(allCollect) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.whiteColor Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:2];
    [self.collectBtn setImage:IMAGE_NAMED(@"快速清理") forState:UIControlStateNormal];
    self.collectBtn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
    self.collectBtn.myWidth = 108;
    self.collectBtn.myHeight = 40;
    self.collectBtn.layer.cornerRadius = 20;
    self.collectBtn.layer.masksToBounds = YES;
    self.collectBtn.layer.borderColor = [UIColor colorWithHexString:@"#E5E5E5"].CGColor;
    self.collectBtn.layer.borderWidth = 1;
    [self.editingLy addSubview:self.collectBtn];
    
    self.deleteBtn = [BaseButton CreateBaseButtonTitle:@"删除" Target:self Action:@selector(deleteBtnClicked) Font:[UIFont systemFontOfSize:15] BackgroundColor:UIColor.whiteColor Color:color_3 Frame:CGRectZero Alignment:NSTextAlignmentCenter Tag:3];
    self.deleteBtn.myWidth = 80;
    self.deleteBtn.myHeight = 40;
    self.deleteBtn.layer.cornerRadius = 20;
    self.deleteBtn.layer.masksToBounds = YES;
    self.deleteBtn.layer.borderColor = [UIColor colorWithHexString:@"#E5E5E5"].CGColor;
    self.deleteBtn.layer.borderWidth = 1;
    [self.editingLy addSubview:self.deleteBtn];
    
    
    if (_type) {
        
        self.settlementLy.visibility = MyVisibility_Gone;
        self.editingLy.visibility = MyVisibility_Visible;
    }else{
        
        self.settlementLy.visibility = MyVisibility_Visible;
        self.editingLy.visibility = MyVisibility_Gone;
    }
}
@end
